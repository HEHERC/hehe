
debug = require('debug')('models:UserReadNews')
Q=require 'q'

module.exports = (sequelize, DataTypes) ->
  UserReadNews = sequelize.define 'UserReadNews',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    user_id:
      type:DataTypes.INTEGER(11)
      allowNull:false
    news_id:
      type:DataTypes.INTEGER(11)
      allowNull:false
  ,
    tableName: 'user_read_news'
    classMethods:
      #得该用户读取当前新闻的状态
      getWatchedByUserId: (userId) ->
        debug('get watched from scheam')
        debug userId
        deferred = Q.defer()
        @.findAll({
          where:
            user_id:userId
          attributes:['news_id']
          }).then (result) ->
            deferred.resolve result
        deferred.promise

