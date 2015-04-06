models = require('../../models/index')
express = require('express')
router = express.Router()
debug = require('debug')('routes:stat:city')
utils = require('../../lib/utils')
_ = require('underscore')
sequelize = models.sequelize
fs = require('fs')
async = require('async')

debug('enter the city')
getHasOrderCities = (cityModelName, callback) ->
  debug('City model is: ' + cityModelName)
  # colFinishedOrders = sequelize.col('finished_orders')
  debug('sequelize model is below: ')
  debug(models[cityModelName])
  models[cityModelName].find({
    attributes: ['city_code']
    where: {
      'finished_orders': {
        gt: 1
      }
    }
  }).then((max) ->
    debug('max is :' + max)
    callback(null, max)
  )

router.get '/stat/city', (req, res) ->
  debug('enter the get city request')
  host = 'stat'
  database = 'stats_center'
  modelsPath = utils.gotoDir('models/stat/stats_center')
  debug('stats_center\'s path is : ' + modelsPath)
  fs.readdir(modelsPath, (err, modelPath) ->
    if(err)
      console.log err
    debug('Read all modelPath is below: ')
    debug(modelPath)
    cityModels = _.filter(modelPath, (model) ->
      return /\_stats\./.test(model)
    )

    cityModelNames = []
    _.each(cityModels, (cityModel) ->
      cityModelNames.push(utils.generateModelName(host, database, utils.getFileName(cityModel)))
    )
    async.map(cityModelNames, getHasOrderCities, (err, results) ->
      debug('max array is below : ')
      results = _.filter(results, (result) ->
        return result isnt null
      )
      debug(results)
      res.json(results)
      debug('max array length is ' + results.length)
    )

  )

module.exports = router
