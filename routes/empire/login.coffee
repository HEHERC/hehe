# 提供login服务
md5 = require('blueimp-md5').md5
debug = require('debug')('routes:login')
express = require 'express'
router = express.Router()
models = require('../../models/index')
_ = require('../../lib/utils')._
utils = require('../../lib/utils')
moment = require('moment')
request = require('request')
urls = require('../../config/url.json')
appConfig = require('../../app_config')
debug 'appConfig is: '
debug appConfig.get('env')

router.post '/login', (req, res) ->
  staffNum = req.body.staff_num
  password = req.body.password
  platform = req.body.platform

  platformRoleHash = {
    "monitor_app" : ["monitor", "admin"]
    "monitor" : ["monitor", "admin"]
    "renli_app": ["renli", "admin"]
    "renli"   : ["renli", "admin"]
    "zhaopin" : ["leader", "admin"]
    "erp": "*"
  }

  role = platformRoleHash[platform]

  debug 'role is:'
  debug role

  response = (res, tokenInstance, user) ->
    debug tokenInstance
    expires_time = tokenInstance.expires_time
    create_time = tokenInstance.create_time
    expires = moment(expires_time).diff(moment(create_time), 'days')
    debug 'added token is: '
    debug tokenInstance
    user.staff_num = models.atomEmpireUser.autoFillStaffNum(user.staff_num)
    res.status(201).json
      token: tokenInstance.content
      expires_time: tokenInstance.expires_time
      expires: expires
      user: user
      city: ''
      city_code: ''

  models.atomEmpireUser.find({
    where:
      staff_num: staffNum
  }).then (user) ->
    if not user
      res.status(400).json(utils.generateError(4, '用户不存在')).end()
      return false
    authId = user.getDataValue('auth_id')
    request.get(urls[appConfig.get('env')].authority + '/cloud/auth/permission/check/' + authId, {
      qs:
        resource: '/nc/login'
        action: 'POST'
        param: "#{platform}"
    }, (err, responseData, body) ->

      if parseInt(body) is 0
        res.status(403).json(utils.generateError(3, '没有登录权限')).end()
      else
        models.atomEmpireUser.getStaffByLogin(staffNum, password, role).then (staff) ->
          debug 'staff is: '
          debug staff
          if not staff
            res.status(422).json(utils.generateError(1, '用户或密码不存在'))
            return false
          if staff.getDataValue('active') is false
            res.status(403).json(utils.generateError(2, '用户未激活'))
            return false
          authId = staff.getDataValue('auth_id')

          request.post(urls[appConfig.get('env')].authority + '/cloud/apps/883/user/tokens', {
            body:
              user_id: staff.getDataValue('auth_id')
            json: true
          }, (err, resp, body) ->
            debug 'body is: '
            debug body
            if err
              res.status(500).json({}).end()
            else
              request.get(urls[appConfig.get('env')].authority + "/cloud/auth/user/#{authId}", {
                headers:
                  Authorization: 'token ' + body.token
                json: true
              }, (err, respon, authBody) ->
                if err
                  res.status(500).json({}).end()
                else

                  # 将返回的角色对应的权限数据删除掉，只返回角色信息
                  _.each authBody.roles, (role, roleIndex) ->
                    authBody.roles[roleIndex] = _.pick role, ['id', 'name', 'code']
                  debug 'authBody is: '
                  debug authBody
                  _.extend(staff.dataValues, authBody)
                  tokenInstance =
                    create_time: moment().toISOString()
                    expires_time: body.expire_time
                    content: body.token
                  response(res, tokenInstance, staff.dataValues)
              )
          )
        , (err) ->
          debug 'err is: '
          debug err
          res.status(500).json({})
    )


crypto=require('crypto')

# 使用登录码登录
router.post '/login_code', (req, res) ->
  code = crypto.createHash('md5').update(req.body.code).digest('hex')

  models.atomEmpireLoginCode.findOne({
    where:
      code: code
  }).then (record) ->
    if not record
      res.status(404).send('登录码不存在')
    else
      console.log record
      request.post(urls[appConfig.get('env')].authority + '/cloud/apps/883/user/tokens', {
        body: {
          user_id: record.dataValues.user_id
        }
        json: true
      }, (err, response, data) ->
        if err
          res.status('500').send('token不存在')
        else
          res.send(data)
      )

router.post '/user', (req, res) ->
  roleId = req.body.role
  active = req.body.active || false
  type = req.body.type || 1
  avatar_qiniu_hash = req.body.avatar_qiniu_hash || ''
  name = req.body.name || ''
  phone = req.body.phone || ''
  request.post(urls[appConfig.get('env')].authority + '/cloud/apps/883/users', {
    headers:
      Authorization: 'token ' + req.headers.authorization.split(' ')[1]
  }, (err, response, body) ->
    debug 'body is: '
    debug body
    if err
      res.status(500).json('创建账户失败')
    else
      models.atomEmpireUser.getStaffNum(req.body.type).then (staff_num) ->
        user = {
          type: type
          staff_num: staff_num
          phone: phone
          name: name
          avatar_qiniu_hash: avatar_qiniu_hash
          active: active
          password: md5('111111')
          auth_id: body
        }

        models.atomEmpireUser.create(user).then (user) ->
          debug 'request url is: '
          debug urls[appConfig.get('env')].authority + '/cloud/auth/user/' + user.getDataValue('auth_id')
          debug 'request body is: '
          debug JSON.stringify({role_set: roleId})
          request.patch(urls[appConfig.get('env')].authority + '/cloud/auth/user/' + user.getDataValue('auth_id'), {
            body:
              role_set: roleId
            json: true
            headers:
              Authorization: 'token ' + req.headers.authorization.split(' ')[1]
          }, (err, response, body) ->
            if err
              res.status(500).json('绑定角色失败')
            debug 'response user is: '
            debug user
            responseUser = _.pick(user.dataValues, ['password', 'id', 'type', 'staff_num', 'phone', 'name', 'avatar_qiniu_hash', 'active', 'update_time', 'create_time'])
            responseUser.role = body
            res.json(responseUser)
          )
        , (err) ->
          debug err
          res.status(500).json('创建用户失败')
      , (err) ->
        debug err
        res.status(500).json('创建用户失败')
  )

# 修改密码
router.put '/user/:userId/password', (req, res) ->
  models.atomEmpireUser.getUserFromToken(req.headers.authorization, false).then (user) ->
    debug 'user is: '
    debug user
    debug 'user has function called save'
    debug user.save

    if user.password is req.body.old_password
      user.password = req.body.new_password
    else
      res.status(403).send(utils.generateError(1, '密码不正确'))
      return false

    debug 'req.params.userId is: '
    debug req.params.userId

    debug 'user.getDataValue("id") is: '
    debug user.getDataValue('id')

    if user.getDataValue('id') isnt parseInt(req.params.userId)
      res.status(403).send(utils.generateError(3, '用户未登录'))
      return false

    user.password_edited = true
    user.save().then (user) ->
      res.json(user)
    , () ->
      res.status(500).send('很抱歉, 服务器出问题啦!')
  , (err) ->
    res.status(403).send(utils.generateError(2, '用户未登录'))
module.exports = router
