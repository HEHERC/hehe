debug = require('debug')('routes:news')
express = require 'express'
router = express.Router()
models = require('../../models/index')
utils = require('../../lib/utils')
async = require('async')
moment = require('moment')
_= require('../../lib/utils')._
urls = require('../../config/url.json')
appConfig = require('../../app_config')
Q = require 'q'
router.get '/news', (req, res) ->
  hot = req.query.hot
  top = req.query.top
  count = req.query.count
  page = req.query.page
  term = req.query.term
  simple = req.query.simple
  if not term
    term = ''
  findOption =
    limit: count
    where:
      title:
        like: "%#{term}%"
    attributes: ['id', 'title', 'body', 'image_id', 'link', 'top', 'deleted', 'create_time', 'update_time', 'browser_times', 'top_image_id']
    order: [['update_time', 'DESC']]
  if top?
    findOption.where.top = true
  if page? and count?
    findOption.offset = (page - 1) * count
    debug 'findOption.offset is: '
    debug findOption.offset
  if hot?
    findOption.order = [['browser_times', 'DESC'], findOption.order]
  models.atomEmpireNews.findAndCount(findOption).then (allNews) ->
      # utils._.each(allNews.rows, (news) ->
      #   news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
      #   delete news.dataValues.image_id
      # )
    res.header('X-Resource-Count', allNews.count)
    res.status(200).send(allNews.rows)
  , (err) ->
    res.status(500).send('获取新闻失败')

router.get '/news/:newsId', (req, res) ->
  newsId = req.params.newsId
  #存储该用户已经读取的新闻id到hasWatched 将该新闻的读取状态存储在watched
  hasWatched = []
  watched='N'
  Q.fcall( ->
    models.atomEmpireUser.getUserFromToken(req.headers.authorization,true).then (user) ->
      models.atomEmpireUserReadNews.getWatchedByUserId(user.id).then (results) ->
        _.each results, (result) ->
          hasWatched.push(result.getDataValue('news_id'))
        ).then( ->
          #判断id
            _.each hasWatched,(hasWatchedId) ->
              watched = 'Y' if hasWatchedId == newsId
          ).then( ->
              models.atomEmpireNews.find(newsId, {
                attributes: ['id', 'title', 'body', 'image_id', 'link', 'top', 'deleted', 'create_time', 'update_time',]
              }).then (news) ->
                news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
                # delete news.dataValues.image_id
                news.setDataValue('top_img', urls[appConfig.get('env')].imageUrl + news.getDataValue('top_image_id'))
                 # delete news.dataValues.top_image_id
                if news.body.length > 100
                  middle = news.body.substring(0, 100)
                  news.body = middle
                news.setDataValue('watched',watched)
                res.status(200).send(news)
                # 更新查看新闻次数
                news.browser_times = news.getDataValue('browser_times') + 1
                news.save
                  silent: true
            , (err) ->
              res.status(500).send('获取失败')
        )

#获取简要新闻
router.get '/newsbrief', (req, res) ->
  models.atomEmpireNews.findAll({
      attributes: ['id', 'title', 'create_time', 'update_time']
      order: 'create_time DESC'
    }).then (news) ->
      res.status(200).send(news)
  , (err) ->
    res.status(500).send('获取简要新闻失败')

router.post '/news', (req, res) ->
  body = req.body

  models.atomEmpireNews.create(body).then (news) ->
    res.status(201).send(news)
  , (err) ->
    res.status(500).send('创建失败')

router.patch '/news/:newsId', (req, res) ->
  body = req.body
  newsId = req.params.newsId

  models.atomEmpireNews.update(body, {
    where:
      id: newsId
  }).then (news) ->
    res.status(200).send('修改成功')
  , (err) ->
    res.status(500).send('修改失败')

# 删除多条新闻
# @params newsIds 1,2,3
router.delete '/news/:newsIds', (req, res) ->
  newsIds = req.params.newsIds
  ids = newsIds.split(',')

  models.atomEmpireNews.destroy({
    where:
      id:
        in: ids
  }).then () ->
    res.status(204).send('删除成功')
  , (err) ->
    res.status(500).send('删除失败')

# 客户端接口
router.get '/apps/news', (req, res) ->
  count = req.query.count
  page = req.query.page
  term = req.query.term

  if not term
    term = ''

  async.parallel([
    (callback) ->
      models.atomEmpireNews.findAll({
        where:
          top: true
        attributes: ['id', 'image_id', 'title', 'link']
      }).then (topNews) ->
        utils._.each topNews, (news) ->
          news.img = news.image_id
          news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
          delete news.dataValues.image_id
        callback(null, topNews)
    (callback) ->
      models.atomEmpireNews.findAndCount({
        offset: (page - 1) * count
        limit: count
        where:
          title:
            like: "%#{term}%"
        attributes: ['id', 'title', 'body', 'image_id', 'link', 'top', 'deleted', 'create_time', 'update_time']
        order: 'create_time DESC'
      }).then (allNews) ->
        utils._.each allNews.rows, (news) ->
          news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
          delete news.dataValues.image_id
        callback(null, allNews)
  ], (err, results) ->
    if err
      res.status(500).send('获取新闻失败')
    else
      res.header('X-Resource-Count', results[1].count)
      res.status(200).send({
        top: results[0]
        posts: results[1].rows
      })
  )

# 首页
router.get '/apps/main_page', (req, res) ->
  count = req.query.count
  page = req.query.page
  term = req.query.term

  if not count
    count = 3

  async.parallel([
    (callback) ->
      models.atomEmpireNews.findAll({
        where:
          top: true
        attributes: ['id', 'image_id', 'title', 'link']
      }).then (topNews) ->
        utils._.each topNews, (news) ->
          news.img = news.image_id
          news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
          delete news.dataValues.image_id
        callback(null, topNews)
    (callback) ->
      models.atomEmpireNews.findAll({
        offset: (page - 1) * count
        limit: count
        where:
          top: false
        attributes: ['id', 'title', 'body', 'image_id', 'link', 'top', 'create_time', 'update_time']
        order: 'create_time DESC'
        # limit: 3
      }).then (posts) ->
        utils._.each posts, (news) ->
          news.img = news.image_id
          news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
          news.setDataValue('create_time', moment(news.getDataValue('create_time')).utc().format('YYYY-MM-DDTHH:mm:ss')+'Z')
          news.setDataValue('update_time', moment(news.getDataValue('update_time')).utc().format('YYYY-MM-DDTHH:mm:ss')+'Z')
          delete news.dataValues.image_id
        callback(null, posts)
  ], (err, results) ->
    if err
      res.status(500).send('获取失败')
    else
      res.status(200).send({
        top: results[0]
        posts: results[1]
      })
  )

module.exports = router
