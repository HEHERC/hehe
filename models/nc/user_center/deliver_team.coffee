Q = require('q')
models = require('../../index')
_ = require('underscore')

module.exports = (sequelize, DataTypes) ->
  DeliverTeam = sequelize.define 'deliver_team',
    id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      autoIncreatment: true

    create_time:
      type: DataTypes.DATE
      allowNull: false

    update_time:
      type: DataTypes.DATE
      allowNull: false

    deleted:
      type: DataTypes.BOOLEAN
      allowNull: true

    name:
      type: DataTypes.STRING
      allowNull: false

    leader:
      type: DataTypes.INTEGER(11)
      allowNull: false

    desc:
      type: DataTypes.STRING
      allowNull: false

    district:
      type: DataTypes.STRING
      allowNull: false

    district_code:
      type: DataTypes.BIGINT
      allowNull: false

    state:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    state_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    city:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    city_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    apply_reason:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    status:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "1"

    manager:
      type: DataTypes.INTEGER(11)
      allowNull: true
      defaultValue: "0"
  ,
    tableName: 'deliver_team'
    classMethods:
      associate: (models) ->
        DeliverTeam.hasMany(models.ncUserCenterRealInfo, {
          foreignKey: 'deliver_team'
        })
        
      getOne: (id) ->
        deferred = Q.defer()

        DeliverTeam.find({
          where:
            id: id
          attributes: ['id', 'desc','leader', 'name', 'state', 'state_code', 'city', 'city_code', 'district', 'district_code', 'status']
          include: [{
            model: models.ncUserCenterRealInfo
            attributes: ['id', 'user', 'real_name']
            include: [{
              model: models.ncUserCenterUser
              attributes: ['tel']
            }]
          }]
        }, {
          # raw: true
          # nest: true
        }).then (deliverTeam) ->
          deferred.resolve(deliverTeam)
        , (err) ->
          console.log(err)
          deferred.reject(err)

        deferred.promise

      # 获得多个小队
      getMany: (ids) ->
        deferred = Q.defer()
        promiseArr = []

        ids.forEach (id, index) ->
          promiseArr.push(DeliverTeam.getOne(id))

        Q.all(promiseArr).then (deliverTeams) ->
          deliverTeams = deliverTeams.map (team) ->
            real_infos = team.dataValues.real_infos
            if real_infos and real_infos.length isnt 0
              real_infos = real_infos.map (info) ->
                info.dataValues.phone = info.dataValues.User.tel
                info.dataValues.name = info.dataValues.real_name
                info.dataValues = _.omit info.dataValues, ['User', 'real_name']

                return info.dataValues

            return team.dataValues
          deferred.resolve(deliverTeams)
        , (err) ->
          console.log(err)
          deferred.reject(err)

        deferred.promise

  return DeliverTeam
