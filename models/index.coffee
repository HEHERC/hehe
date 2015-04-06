fs = require('fs')
path = require('path')
utils = require '../lib/utils'
Sequelize = require('sequelize')
env = process.env.NODE_ENV || 'development'
config = require(__dirname + '/../config/config.json')
debug = require('debug')('models:index')
async = require 'async'

debug('config is below:')
debug(config)
db =
  sequelizes: []
  Sequelize: Sequelize

models = utils.walkModelsSync()
debug models

for key, model of models
  if config[key]
    configEnv = config[key][env]

    if not configEnv
      return

    for dbKey, dbValue of models[key]
      sequelize = new Sequelize dbKey, configEnv.username, configEnv.password, configEnv
      for file, index in dbValue
        if file[0] is '.'
          return
        modelObj = sequelize['import'](path.join(__dirname, key, dbKey, file))
        modelName = utils.generateModelName(key, dbKey, modelObj.name)
        debug(modelName)
        db[modelName] = modelObj
      db.sequelizes.push sequelize
debug 'sequelizes:'
debug db.sequelizes

for modelName in Object.keys(db)
  # coffee中使用of判断对象是否存在属性
  if ('associate' of db[modelName])
    db[modelName].associate(db)

module.exports = db
