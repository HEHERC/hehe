Q = require('q')

module.exports = (sequelize, DataTypes) ->
  BusinessDistrictTeamRelation = sequelize.define 'business_district_team_relation',
    id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    create_time:
      type: DataTypes.DATE
      allowNull: false

    update_time:
      type: DataTypes.DATE
      allowNull: false

    deleted:
      type: DataTypes.BOOLEAN
      allowNull: true

    business_district:
      type: DataTypes.INTEGER(11)
      allowNull: false

    team_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
  ,
    tableName: 'business_district_team_relation'
    classMethods:
      associate: (models) ->

      # 根据小队查找商圈
      getDistrictsByTeam: (id) ->
        deferred = Q.defer()

        BusinessDistrictTeamRelation.findAll({
          where:
            team_id: id
        }).then (relations) ->
          deferred.resolve(relations)
        , (err) ->
          console.log(err)
          deferred.reject(err)

        deferred.promise

      # 根据商圈查找小队
      getTeamsByDistrict: (id) ->
        deferred = Q.defer()

        BusinessDistrictTeamRelation.findAll({
          where:
            business_district: id
        }).then (relations) ->
          deferred.resolve(relations)
        , (err) ->
          console.log(err)
          deferred.reject(err)

        deferred.promise

  return BusinessDistrictTeamRelation
