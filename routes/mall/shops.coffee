models = require('../../models/index')
express = require('express')
router = express.Router()
debug = require('debug')('routes:mall:shops')
sequelize = models.sequelize
debug('Entered the shops.coffee')

router.get '/mall/shops', (req, res) ->
  models.ncMallShop.findAll().then (shops) ->
    debug('Get the shops, see below:')
    debug(shops)
    res.json(shops)
  , (err) ->
    debug('Get shops counted a error, see below:')
    debug(err)

module.exports = router
