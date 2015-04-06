models = require('../../models/index')
express = require('express')
router = express.Router()
debug = require('debug')('routes:F_DB_USER_SH:withdraw')
sequelize = models.sequelize

router.get '/shop_other/withdraw', (req, res) ->
  query = req.query

  if not req.headers.authorization
    res.send(400)

  token = req.headers.authorization.split(' ')[1]

  models.ncUserCenterToken.find({
    where:
      content: token
      app_id: 883
  }, {
    raw: true
    nest: true
  }).then (user) ->
    currentUser = user

    if not currentUser
      res.send(401)

    if new Date(currentUser.expire_time).getTime() < new Date().getTime()
      res.send(401)

    models.ncFDBUSERSHWithdraw.findAndCountAll({
      include: [{
        model: models.ncFDBUSERSHAccount
        attributes: ['id', 'user_id']
        include: [{
          model: models.ncUserCenterUser
          # include: [models.ncMallShop]
        }]
      }]
      offset: (query.page - 1) * query.count
      limit: query.count
      order: 'create_time DESC'

    }).then (withdraws) ->
      debug('Get the withdraws, see below:')
      res.header('X-Resource-Count', withdraws.count)
      res.json(withdraws.rows)
    , (err) ->
      debug('Get withdraws counted a error, see below:')
      debug(err)

  , (err) ->
    res.send(401)

module.exports = router
