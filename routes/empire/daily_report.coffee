debug = require('debug')('routes:daily_report')
express = require 'express'
router = express.Router()
models = require('../../models/index')
utils = require('../../lib/utils')
_ = require('../../lib/utils')._
moment = require('moment')
q = require('q')
async = require('async')

request = require('request')
urls = require('../../config/url.json')
appConfig = require('../../app_config')

transformDayToUtc = (startTime = new Date(), endTime = new Date()) ->
  return {
    start: moment(startTime).add(6, 'h').toISOString()
    end: moment(endTime).add(1, 'd').add(6, 'h').toISOString()
  }

router.get '/daily_report', (req, res) ->
  page = req.query.page
  count = req.query.count
  userId = req.query.user_id
  type = req.query.type || undefined
  create_time = req.query.create_time
  startTime = req.query.start_time
  endTime = req.query.end_time

  if not page
    page = null
  if not count
    count = null

  sequelize = models.atomEmpireDailyReport.sequelize
  where = []
  if create_time? and (not startTime? or not endTime?)
    # 获取一个月的数据
    if /\d{4}-\d{1,}$/.test(create_time)
      create_time += '-01'
      start_time = utils.dateFillZero(create_time)
      debug 'start_time is: '
      debug start_time
      end_time = moment(new Date(start_time)).endOf('month').format('YYYY-MM-DD')
      where.push(sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.create_time')), '>=', start_time))
      where.push(sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.create_time')), '<=', end_time))
    else
      where.push(sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.create_time')), create_time))
  else
    # 根据用户传进来的start_time和end_time进行筛选, 它的优先级比create_time传月份的筛选优先级要高
    if startTime?
      startTime = transformDayToUtc(startTime).start
      where.push(sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.create_time')), '>=', startTime))
    if endTime?
      endTime = transformDayToUtc('', endTime).end
      where.push(sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.create_time')), '<=', endTime))

  if type?
    where.push({
      type: type.split(',')
    })

  # @todo 将这块内容组装成一个函数
  if userId?
    where.push({
      user_id: userId
    })
  if where.length is 0
    where = {}
  else if where.length is 1
    where = where[0]

  findOptions = {
    where: where
    # offset: (page - 1) * count
    # limit: count
    order: 'create_time DESC'
    include: [
      model: models.atomEmpireUser
      as: 'user'
      attributes: ['id', 'name']
    ]
  }
  findOptions.include.push(models.atomEmpireComment.findCommentFromReportOption())

  debug 'findOptions is: '
  debug findOptions
  models.atomEmpireDailyReport.findAndCountAll(findOptions).then (dailyReports) ->
    debug 'dailyReports is: '
    debug dailyReports
    res.header('X-Resource-Count', dailyReports.count)
    res.json(dailyReports.rows)
  , (err) ->
    console.log err
    res.status(500).send('数据库出现问题')

  # getUserId = (userId, req, models, q) ->
  #   deferred = q.defer()
  #   if userId?
  #     deferred.resolve(userId)
  #   else
  #     models.atomEmpireUser.getUserFromToken(req.headers.authorization).then (user) ->
  #       userId = user.getDataValue('id')
  #       deferred.resolve userId
  #     , () ->
  #       deferred.reject('根据token获取用户失败')
  #   deferred.promise

  # getUserId(userId, req, models, q).then (userId) ->
  #   debug 'userId is: '
  #   debug userId

  #   if userId?
  #     where.push({
  #       user_id: userId
  #     })
  #   if where.length is 0
  #     where = {}
  #   else if where.length is 1
  #     where = where[0]

  #   findOptions = {
  #     where: where
  #     # offset: (page - 1) * count
  #     # limit: count
  #     order: 'create_time DESC'
  #   }

  #   debug 'findOptions is: '
  #   debug findOptions
  #   models.atomEmpireDailyReport.findAndCountAll(findOptions, {
  #     raw: true
  #   }).then (dailyReports) ->
  #     res.header('X-Resource-Count', dailyReports.count)
  #     res.json(dailyReports.rows)
  #   , (err) ->
  #     console.log err
  #     res.status(500).send('数据库出现问题')
  # , (err) ->
  #   res.status(403).send(utils.generateError(1, err))

# 根据部门id获取日报
router.get '/daily_report/department/:departmentId', (req, res) ->
  sequelize = models.atomEmpireDailyReport.sequelize
  departmentId = req.params.departmentId
  page = req.query.page
  count = req.query.count

  models.atomEmpireDepartmentStructure.getAllSubDepartmentIds(departmentId, (departmentIds) ->
    debug 'departmentIds is: '
    debug departmentIds
    findOptions =
        {
          order: 'create_time DESC'
          attributes: ['id', 'type', 'title', 'content', 'create_time', 'user_id', 'update_time']
          include: [
            {
              model: models.atomEmpireUser
              as: 'user'
              attributes: ['id', 'name', 'phone']
              include: [
                {
                  model: models.atomEmpireDepartmentStructure
                  as: 'empireDepartment'
                  where:
                    id: departmentIds
                  attributes: []
                }
              ]
            }
          ]
        }

      if req.query.start_time?
        startTime = moment(new Date(req.query.start_time)).hour(0).toISOString()
        startTimeWhere = sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.update_time')), '>=', startTime)
      if req.query.end_time?
        endTime = moment(new Date(req.query.end_time)).hour(24).toISOString()
        endTimeWhere = sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.update_time')), '<=', endTime)

      if startTimeWhere? and endTimeWhere?
        findOptions.where = sequelize.and(startTimeWhere, endTimeWhere)
      else if startTimeWhere?
        findOptions.where = startTimeWhere
      else if endTimeWhere?
        findOptions.where = endTimeWhere

      findOptions.include.push(models.atomEmpireComment.findCommentFromReportOption())

    models.atomEmpireDailyReport.findAndCountAll(findOptions).then (dailyReports) ->
      debug 'first dailyReport is: '
      debug dailyReports.rows[0]
      # res.header('X-Resource-Count', dailyReports.count)
      res.json(dailyReports.rows)
    , (err) ->
      console.log err
      res.status(500).send('数据库出现问题')
  )

router.post '/daily_report', (req, res) ->
  debug 'req.body is:'
  debug req.body
  models.atomEmpireUser.getUserFromToken(req.headers.authorization).then (user) ->
    debug 'user is: '
    debug user
    user_id = user.id

    if req.body instanceof Array
      dailyReports = req.body
      for dailyReport in dailyReports
        dailyReport.user_id = user_id
      dailyReportInstance = models.atomEmpireDailyReport.bulkCreate(dailyReports)
      debug 'dailyReports is: '
      debug dailyReports
    else
      dailyReport = req.body
      dailyReport.user_id = user_id
      dailyReportInstance = models.atomEmpireDailyReport.create(dailyReport)

    dailyReportInstance.then (dailyReport) ->
      res.json(dailyReport)
    , (err) ->
      debug err
      res.status(500).send('服务器错误')
  , (err) ->
    debug err
    res.status(500).send(utils.generateError(1, err))

# 根据组获取日报
router.get '/daily_report/group', (req, res) ->
  sequelize = models.atomEmpireDailyReport.sequelize
  authorization = req.headers.authorization
  models.atomEmpireUser.getUserFromToken(authorization, true).then (user) ->
    debug 'user is: '
    debug user
    userId = user.auth_id
    request.get(urls[appConfig.get('env')].authority + "/cloud/auth/group/check/#{userId}", {
      qs:
        app_code: 'report'
      json: true
      headers:
        Authorization: 'token ' + authorization.split(' ')[1]
    }, (err, response, body) ->
      debug 'response body is: '
      debug body

      # 将这个用户从这个组中删除
      body = _.remove body, (user) ->
        return user is userId


      includeUser =
        model: models.atomEmpireUser
        as: 'user'
        where: {}
        attributes: ['id', 'name', 'phone']

      if body?.length > 0
        includeUser.where.auth_id = body
      else
        includeUser.where.auth_id = [null]

      findOption =
        order: 'create_time DESC'
        include: [
          includeUser
          models.atomEmpireComment.findCommentFromReportOption()
        ]
        where: []
        attributes: ['id', 'type', 'title', 'content', 'create_time', 'user_id', 'update_time']

      if req.query.start_time?
        # startTime = moment(new Date(req.query.start_time)).hour(0).toISOString()
        startTime = transformDayToUtc(req.query.start_time).start
        startTimeWhere = sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.update_time')), '>=', startTime)
      if req.query.end_time?
        # endTime = moment(new Date(req.query.end_time)).hour(24).toISOString()
        endTime = transformDayToUtc('', req.query.endTime).end
        endTimeWhere = sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.update_time')), '<=', endTime)

      if startTimeWhere? and endTimeWhere?
        dateWhere = sequelize.and(startTimeWhere, endTimeWhere)
      else if startTimeWhere?
        dateWhere = startTimeWhere
      else if endTimeWhere?
        dateWhere = endTimeWhere
      if dateWhere?
        findOption.where.push dateWhere

      if req.query.type?
        findOption.where.push
          type: req.query.type.split ','

      debug 'findOption is: '
      debug findOption

      models.atomEmpireDailyReport.findAll(findOption).then (dailyReports) ->
        res.json(dailyReports).end()
      , () ->
        res.status(500).send(utils.generateError(1, '获取日报失败'))
    )

router.get '/daily_report/group/:groupId', (req, res) ->
  sequelize = models.atomEmpireDailyReport.sequelize
  groupId = req.params.groupId
  authorization = req.headers.authorization

  models.atomEmpireUser.getUserFromToken(authorization, true).then (user) ->
    debug 'user is: '
    debug user
    userId = user.auth_id
    request.get urls[appConfig.get('env')].authority + "/cloud/auth/groups/#{groupId}", {
      json: true
      headers:
        Authorization: 'token ' + authorization.split(' ')[1]
    }, (err, response, body) ->
      debug 'response body is: '
      debug body

      userIds = body.user_ids

      debug userId
      # 将这个用户从这个组中删除
      _.remove userIds, (user) ->
        return user is userId
      debug 'userIds is: '
      debug userIds

      includeUser =
        model: models.atomEmpireUser
        as: 'user'
        where: {}
        attributes: ['id', 'name', 'phone']

      if userIds?.length > 0
        includeUser.where.auth_id = userIds
      else
        includeUser.where.auth_id = [null]

      findOption =
        order: 'create_time DESC'
        include: [
          includeUser
          models.atomEmpireComment.findCommentFromReportOption()
        ]
        where: []
        attributes: ['id', 'type', 'title', 'content', 'create_time', 'user_id', 'update_time']

      if req.query.start_time?
        # startTime = moment(new Date(req.query.start_time)).hour(0).toISOString()
        startTime = transformDayToUtc(req.query.start_time).start
        # startTimeWhere = sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.update_time')), '>=', startTime)
        startTimeWhere =
          update_time:
            gt: startTime
      if req.query.end_time?
        # endTime = moment(new Date(req.query.end_time)).hour(24).toISOString()
        endTime = transformDayToUtc('', req.query.end_time).end
        # endTimeWhere = sequelize.where(sequelize.fn('date', sequelize.col('DailyReport.update_time')), '<=', endTime)
        endTimeWhere =
          update_time:
            lt: endTime

      if startTimeWhere? and endTimeWhere?
        dateWhere = sequelize.and(startTimeWhere, endTimeWhere)
      else if startTimeWhere?
        dateWhere = startTimeWhere
      else if endTimeWhere?
        dateWhere = endTimeWhere
      if dateWhere?
        findOption.where.push dateWhere

      if req.query.type?
        findOption.where.push
          type: req.query.type.split ','


      debug 'findOption is: '
      debug findOption

      models.atomEmpireDailyReport.findAll(findOption).then (dailyReports) ->
        res.json(dailyReports).end()
      , () ->
        res.status(500).send(utils.generateError(1, '获取日报失败'))

module.exports = router
