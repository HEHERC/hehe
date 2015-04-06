md5 = require('blueimp-md5').md5
moment = require 'moment'
debug = require('debug')('models:token')

module.exports = (sequelize, DataTypes) ->
  Token = sequelize.define 'Token',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    content:
      type: DataTypes.STRING(64)
      allowNull: false
    expires_time:
      type: DataTypes.DATE
      allowNull: false
  ,
    tableName: 'token'
    classMethods:
      generateToken: (staffId, platform) ->
        debug "platform is: "
        debug platform

        if ['monitor_app'].lastIndexOf(platform) >= 0
          expiresDistanceDay = 365
        else
          expiresDistanceDay = 7
        curDate = new Date()
        content = md5(staffId + curDate)
        create_time = moment(curDate).toISOString()
        expires_time = moment(curDate).add(expiresDistanceDay, 'd').toISOString()
        return {
          create_time: create_time
          content: content
          expires_time: expires_time
        }
      createOne: (staffId) ->
        generatedToken = this.generateToken(staffId)
        return this.create(generatedToken)
