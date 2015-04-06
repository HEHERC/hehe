debug = require('debug')('routes:user')
express = require 'express'
router = express.Router()
models = require('../../models/index')
_ = require('../../lib/utils')._
utils = require('../../lib/utils')
async = require('async')

request = require('request')
urls = require('../../config/url.json')
appConfig = require('../../app_config')

router.get '/user', (req, res) ->
  query = req.query
  if req.query.department_id?
    debug 'has query department_id'
    debug req.query.department_id
    # if req.query.department_id is '0'
    #   models.atomEmpireUser.getusers({raw: true}).then (users) ->
    #     debug 'users is:'
    #     debug users.length
    # else
    models.atomEmpireDepartmentStructure.getAllSubDepartmentIds(req.query.department_id, (departmentIds) ->
      debug 'departmentIds is: '
      debug departmentIds
      option =
        name: query.term
        auth_id: query.user_id
      if departmentIds?
        option.departmentId = departmentIds
      models.atomEmpireUser.getAll(option).then (users) ->
        debug 'users is: '
        debug users[0]

        # 假如是0, 则表明想要获取没有部门的用户
        if req.query.department_id is '0'
          rawUsers = _.pluckAttrDeep users, 'dataValues'
          users = _.filter rawUsers, (user) ->
            return user.empire_department.length is 0

        # resUsers = []
        # async.each users, (user, callback) ->
        #   request.get(urls[appConfig.get('env')].authority + '/cloud/auth/user/' + user.getDataValue('auth_id'), (err, response, body) ->
        #     debug 'body is: '
        #     debug body
        #     if err
        #       callback(err)
        #     else
        #       user = _.pluckAttrDeep(user, 'dataValues')

        #       body = JSON.parse(body)
        #       if body.role_info.length
        #         user.roles = body.role_info
        #       resUsers.push(user)
        #       callback()
        #   )
        # , (err) ->
        #   if err
        #     res.status(500).json(err).end()
        #   else
        #     res.json(resUsers).end()
        res.json(users).end()
      , (err) ->
        res.status(500).json(err).end()
    )
  else if req.query.group is 'DAILY_REPORT'
    authorization = req.headers.authorization
    debug 'authorization is: '
    debug authorization
    models.atomEmpireUser.getUserFromToken(authorization, true).then (user) ->
      debug 'user is: '
      debug user
      userId = user.auth_id
      request.get urls[appConfig.get('env')].authority + "/cloud/auth/group/check/#{userId}", {
        qs:
          app_code: 'report'
        json: true
        headers:
          Authorization: 'token ' + authorization.split(' ')[1]
      }, (err, response, body) ->
        debug 'response body is: '
        debug body
        models.atomEmpireUser.findAll
          where:
            auth_id: body
        .then (users) ->
          res.status(200).json(users).end()
        , () ->
          res.status(500).end()
  else
    getOptions =
      name: query.term

    if query.user_ids?
      if query.user_ids.length is 0
        res.json([]).end()
        return false
      getOptions.authId = query.user_ids.split(',')

    if query.user_id?.length > 0
      if query.user_id.length is 0
        res.json([]).end()
        return false
      getOptions.authId = query.user_id

    debug 'enter get user'
    models.atomEmpireUser.getAll(getOptions).then (users) ->
      debug 'users is: '
      debug users[0]
      # resUsers = []
      # async.each users, (user, callback) ->
      #   request.get(urls[appConfig.get('env')].authority + '/cloud/auth/user/' + user.getDataValue('auth_id'), (err, response, body) ->
      #     debug 'body is: '
      #     debug body
      #     if err
      #       callback(err)
      #     else
      #       user = _.pluckAttrDeep(user, 'dataValues')

      #       body = JSON.parse(body)
      #       if body.role_info.length
      #         user.roles = body.role_info
      #       resUsers.push(user)
      #       callback()
      #   )
      # , (err) ->
      #   if err
      #     res.status(500).json(err).end()
      #   else
      #     res.json(resUsers).end()
      res.json(users).end()
    , (err) ->
      res.status(500).json(err)

# 获取客户经理或者人事经理
# @todo  可以封装一个根据角色id获取用户id的列表
router.get '/user/manager', (req, res) ->
  type = req.query.type
  status = req.query.status
  count = req.query.count
  page = req.query.page
  term = req.query.term

  if not term
    term = ''

  request.get(urls[appConfig.get('env')].authority + '/cloud/apps/883/areas/manage/city_manager_relation_v2' , {
    headers:
      Authorization: 'token ' + req.headers.authorization.split(' ')[1]
    qs:
      type: type
    json: true
  }, (err, response, body) ->

    if err
      res.status(500).send('获取失败')
    userIds = body[status]

    models.atomEmpireUser.findAndCount({
      where:
        auth_id:
          in: userIds
        name:
          like: "%#{term}%"
      offset: (page - 1) * count
      limit: count
    }).then (managers) ->
      res.header('X-Resource-Count', managers.count)
      res.json(managers.rows)
    , (err) ->
      res.status(500).send('获取列表失败')
  )

router.get '/user/:userId', (req, res) ->
  debug req.params.userId
  if not (/^[1-9]+[0-9]*]*$/.test(req.params.userId))
    debug 'asdf'
    # next()
    return
  userId = req.params.userId

  models.atomEmpireUser.find({
    where:
      id: userId
    include: [
      {
        model: models.atomEmpireDepartmentStructure
        as: 'empireDepartment'
        attributes: ['name', 'id']
      }
    ]
    attributes: ['id', 'name', 'is_leader', 'active', 'avatar_qiniu_hash', 'phone', 'staff_num', 'type', 'auth_id']
  })
  .then (user) ->
    debug 'req.headers.authorization is: '
    debug req.headers.authorization
    request.get(urls[appConfig.get('env')].authority + '/cloud/auth/user/' + user.getDataValue('auth_id'), {
      headers:
        Authorization: 'token ' + req.headers.authorization.split(' ')[1]
    }, (err, response, body) ->
      if err
        res.status(500).send(err).end()
      else
        user = _.pluckAttrDeep(user, 'dataValues')
        debug 'response body is: '
        debug body
        body = JSON.parse(body)
        if body.roles?.length
          user.roles = body.roles
        # _.extend(user, body)
        debug 'user is: '
        debug user
        res.json(user).end()
    )

  , (err) ->
    res.status(500).json(err)

router.post '/load_users_from_excel', (req, res) ->
  models.atomEmpireUser.insertUsersFromExcel().then (users) ->
    res.json(users)
  , (err) ->
    res.status(500).json(err)

router.post '/update_user_from_excel', (req, res) ->
  models.atomEmpireUser.updateUsersFromExcel().then (users) ->
    res.json(users)
  , (err) ->
    res.status(500).json(err)

router.patch '/user/:userId', (req, res, next) ->

  if not /^[1-9]+[0-9]*]*$/.test(req.params.userId)
    return next()

  userId = req.params.userId
  body = req.body

  models.atomEmpireUser.updateOne(userId, body, req.headers).then (user) ->
    res.sendStatus(200)
  , (err) ->
    res.status(500).json(err)

router.get '/account', (req, res) ->
  pagination = utils.getPagination(req)
  debug 'pagination is: '
  debug pagination
  findOptions = {
    order: [['staff_num', 'ASC'], ['type', 'ASC']]
    include: {
      model: models.atomEmpireRole
      as: 'role'
      attributes: ['name', 'id']
    }
  }
  _.extend findOptions, pagination
  debug 'findOptions is: '
  debug findOptions
  debug 'models.atomEmpireUser has a function called, findAndCount:'
  debug models.atomEmpireUser.findAndCount
  models.atomEmpireUser.findAndCount(findOptions).then (users) ->
    debug 'users\' rows is: '
    debug users.rows
    res.header('X-Resource-Count', users.count)
    res.json(users.rows)
  , () ->
    res.status(500).json('服务器错误')

router.delete '/user/:userId', (req, res) ->
  userId = req.params.userId
  destroyOptions = {
    where: {
      id: userId
    }
  }
  models.atomEmpireUser.destroy(destroyOptions).then (user) ->
    res.status(200).json({})
  , (err) ->
    res.status(500).json('服务器错误')

# 以下为工具接口, 如不清楚用法，请勿调用!!!!

## 查询用户是否存在权限id, 假如存在不做任何操作；不存在的话那么就在权限表里面创建一个用户，然后将返回的权限用户id更新到auth_id字段中
router.patch '/user/update_auth_id', (req, res) ->
  debug 'enter /user/update_auth_id'
  models.atomEmpireUser.findAll({
    where: ["auth_id is ?", null]
    order: 'id ASC'
  }).then (users) ->
    debug 'users is: '
    debug users
    async.each users, (user, callback) ->
      request.post(urls[appConfig.get('env')].authority + '/users', {
        headers:
          Authorization: 'token ' + req.headers.authorization.split(' ')[1]
      }, (err, response, body) ->
        if err
          res.status(500).json('创建账户失败').end()
        else
          user.auth_id = body
          user.save().then () ->
            callback()
          , (err) ->
            callback(err)
      )
    , (err) ->
      if err
        res.status(500).send('操作失败')
      res.send('操作成功')

router.get '/role/:roleId/user', (req, res) ->
  roleId = req.params.roleId
  request.get(urls[appConfig.get('env')].authority + '/cloud/auth/roles/' + roleId, {
    headers:
      Authorization: 'token ' + req.headers.authorization.split(' ')[1]
  }, (err, response, body) ->
    debug 'response body is: '
    debug body
    body = JSON.parse(body)
    models.atomEmpireUser.findAll({
      where:
        auth_id: body.user_ids
      attributes: ['id', 'name', 'staff_num']
    }).then (users) ->
      debug 'users is: '
      debug users
      res.json(users).end()
  )

module.exports = router

