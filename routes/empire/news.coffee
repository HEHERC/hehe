debug = require('debug')('routes:news')
express = require 'express'
router = express.Router()
models = require('../../models/index')
utils = require('../../lib/utils')
_ = require('../../lib/utils')._
async = require('async')
moment = require('moment')
Q = require 'q'
urls = require('../../config/url.json')
appConfig = require('../../app_config')

router.get '/news', (req, res) ->
  hot = req.query.hot
  top = req.query.top
  count = req.query.count
  page = req.query.page
  term = req.query.term    #标题内容
  dataType = req.query.dataType   #得到新闻的信息程度 简要新闻和详细新闻
  if not term
    term = ''
  if not dataType
    dataType = 'normal'
  findOption =
    limit: count
    where:
      title:
        like: "%#{term}%"
    attributes: ['id', 'title', 'body', 'image_id', 'link', 'top', 'deleted', 'create_time', 'update_time', 'browser_times', 'top_image_id']
    order: [['update_time', 'DESC']]
  if top?
    findOption.where.top = true
  if hot?
    findOption.order = [['browser_times', 'DESC'], findOption.order]
  if dataType == 'simple'
    findOption =
      limit : count
      where:
        title:
          like: "%#{term}%"
      attributes: ['id', 'title', 'body' ,'create_time', 'update_time']
      order: [['update_time', 'DESC']]
  if page? and count?
    findOption.offset = (page - 1) * count
    debug 'findOption.offset is: '
    debug findOption.offset
  models.atomEmpireUser.getUserFromToken(req.headers.authorization,true).then (user) ->
    # @method 将未读新闻和已读新闻分别查询 函数体1为查询未读新闻，函数体2为查询已读新闻
    # @情况分三种：
    # 1.当前页只显示未读新闻
    # 2.当前页显示未读新闻和已读新闻
    # 3.当前页只显示已读新闻
    async.series([        #此处代码需要流水线执行
      (callback) ->
        # @此处的函数体根据当前连接的用户认证得到user_id，并调用news模板中的getUnReadNews方法返回所有未读新闻的id
        # @param user.id为跨域得到的user.id
        # @see models/atom/empire/news.coffee中的getUnReadNews方法
        models.atomEmpireNews.getUnReadNews(user.id).then (news_ids) ->
          findOption.where.id= news_ids    #此处设置sequelize的findAndCount方法参数中的id
          models.atomEmpireNews.getNews(findOption).then (UnReadNews) ->
            _.each UnReadNews.rows ,(UnReadNew) ->
              UnReadNew.setDataValue('read',false)  #设置所有未读新闻中的read参数为'false'
            # 判断当前页中已读新闻和未读新闻共存
            if UnReadNews.rows.length isnt count and UnReadNews.rows.length isnt 0
              findOption.limit = (count - UnReadNews.rows.length) #设置当前页中的已读新闻的limit
              findOption.offset = 0
            else if UnReadNews.rows.length == 0 #当前页只存在已读新闻
              findOption.limit = count          #重新设置当前页的已读新闻的limit
              findOption.offset = (page - 1) * count- UnReadNews.count   #根未读新闻返回的数量count得到已读新闻的offset
            callback(null,UnReadNews)
      (callback) ->
        # @此处的函数体根据当前连接的用户认证得到user_id，并调用news模板中的getReadNews方法返回所有已读新闻的id
        # @param user.id为跨域得到的user.id
        # @see models/atom/empire/news.coffee中的getReadNews方法
        models.atomEmpireNews.getReadNews(user.id).then (news_ids) ->
          findOption.where.id = news_ids
          if findOption.limit   #此处判断的情况是当当前页中只有未读新闻时，函数执行到此处会将所有已读新闻返回
            models.atomEmpireNews.getNews(findOption).then (ReadNews) ->
              _.each ReadNews.rows ,(ReadNew) ->
                ReadNew.setDataValue('read',true)
              callback(null,ReadNews)
          else
            callback(null,[])
    ], (err, results) ->
        if err
          res.status(500).send('获取新闻失败')
        else
          res.header('X-Resource-Count', results[0].count+results[1].count)
          news = []
          _.each results[0].rows, (unread) ->
            news.push(unread.dataValues)
          _.each results[1].rows, (read) ->
            news.push(read.dataValues)
          res.status(200).send(news)
    )




  # res.header('X-Resource-Count', _.flatten(results).count)
  # res.status(200).send(_.flatten(results).rows)
  #   )
  # , (err) ->
  #   res.status(500).send('获取新闻失败')


# @获取新闻的详细信息 并且将新闻的body部分限制在100个字符内
# @用户读取新闻后将关系表绑定在user_read_news数据表中
# @param newsId:前端news_id
# @param authorization:认证用户
# @param hasWatched 已经读取的新闻id
# @return {news}
# @see news数据结构详见empire/doc文档
router.get '/news\/:newsId(\\d+)$/', (req, res) ->
  newsId = req.params.newsId
  hasWatched = []
  Q.fcall( ->
    models.atomEmpireUser.getUserFromToken(req.headers.authorization,true).then (user) ->
      models.atomEmpireUserReadNews.getWatchedByUserId(user.id).then (results) ->
        _.each results, (result) ->
          hasWatched.push(result.getDataValue('news_id'))
        return user.id
        ).then( (userid)->
            models.atomEmpireNews.find(newsId, {
              attributes: ['id', 'title', 'body', 'image_id', 'link', 'top', 'deleted', 'create_time', 'update_time',]
            }).then (news) ->
              #绑定user和news的读取关系
              models.atomEmpireUserReadNews.findOrCreate({
                where:
                  user_id : userid,
                  news_id : newsId
                })
              news.setDataValue('img', urls[appConfig.get('env')].imageUrl + news.getDataValue('image_id'))
              # delete news.dataValues.image_id
              news.setDataValue('top_img', urls[appConfig.get('env')].imageUrl + news.getDataValue('top_image_id'))
              # delete news.dataValues.top_image_id
              #限制news长度100字符之内
              if news.body.length > 100
                middle = news.body.substring(0, 100)
                news.body = middle
              #默认设置read字段为false
              news.setDataValue('read',false)
              #对比当前新闻id和已读新闻id
              _.each hasWatched,(hasWatchedId) ->
                if hasWatchedId+'' == newsId
                  read = true
                  #对比成功则设置read为true
                  news.setDataValue('read',true)
              res.status(200).send(news)
              news.browser_times = news.getDataValue('browser_times') + 1
              news.save
                silent: true
            , (err) ->
              res.status(500).send('获取失败')
        )

# @获取简要新闻
#  将新闻的简要信息返回表并且将该新闻的读取状态'read'加到返回字符串
# @param hasWatched 已经读取的新闻id
# @see 返回参数中的news的数据结构
# @return {news} /{['id', 'title', 'create_time', 'update_time'，'read']}
# router.get '/newsbrief', (req, res) ->
#   hasWatched = []
#   Q.fcall( ->
#     models.atomEmpireUser.getUserFromToken(req.headers.authorization,true).then (user) ->
#       models.atomEmpireUserReadNews.getWatchedByUserId(user.id).then (results) ->
#         _.each results, (result) ->
#           hasWatched.push(result.getDataValue('news_id'))
#         ).then ( ->
#           models.atomEmpireNews.findAll({
#             attributes: ['id', 'title', 'create_time', 'update_time']
#             order: 'create_time DESC'
#           }).then (news) ->
#             _.each news,(new_simple) ->
#               new_simple.setDataValue('read',false)
#               _.each hasWatched,(hasWatchedId) ->
#                 if hasWatchedId == new_simple.getDataValue('id')
#                   new_simple.setDataValue('read',true)
#             res.status(200).send(news)
#           , (err) ->
#             res.status(500).send('获取简要新闻失败')
#       )

# @获取当前用户的未读新闻的数量接口
#  新闻的总数量减去已经读取的新闻数量就是没有读取的新闻数量
# @param hasWatchedMounts 已经读取新闻的数量
# @param hasWatched 已经读取的新闻id
# @param newMounts 所有新闻的数量
# @return {'hasWatchedMounts':hasWatchedMounts,'newMounts':newMounts}
router.get '/news/unread' ,(req,res) ->
  Q.fcall(->
    models.atomEmpireUser.getUserFromToken(req.headers.authorization,true).then (user) ->
      hasWatched = []
      models.atomEmpireUserReadNews.getWatchedByUserId(user.id).then (results) ->
        _.each results, (result) ->
          hasWatched.push(result.getDataValue('news_id'))
        models.atomEmpireNews.count(
          where:
            deleted:false
            id :
              in : hasWatched
        ).then (n)->
          return n
    ).then( (hasWatchedMounts)->
      #delete_time字段为空和delete字段为0确定当前新闻可读
      models.atomEmpireNews.count(
          where:
            deleted:false
        ).then (n)->
          newMounts = n
          return {'hasWatchedMounts':hasWatchedMounts,'newMounts':newMounts}
    ).then (results)->
        mount = results.newMounts - results.hasWatchedMounts
        # res.status(200).send('{"unread_mount":'+mount+'}')
        res.status(200).send({unread_mount: mount})

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
