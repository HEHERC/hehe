Q = require('q')
models = require('../../index')

module.exports = (sequelize, DataTypes) ->
  BusinessDistrict = sequelize.define "business_district",
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

    app_id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    desc:
      type: DataTypes.STRING
      allowNull: false

    name:
      type: DataTypes.STRING
      allowNull: false

    state:
      type: DataTypes.STRING
      allowNull: false

    state_code:
      type: DataTypes.BIGINT
      allowNull: false

    city:
      type: DataTypes.STRING
      allowNull: false

    city_code:
      type: DataTypes.BIGINT
      allowNull: false

    district:
      type: DataTypes.STRING
      allowNull: false

    district_code:
      type: DataTypes.BIGINT
      allowNull: false

    street:
      type: DataTypes.STRING
      allowNull: false

    street_code:
      type: DataTypes.BIGINT
      allowNull: false

    longitude:
      type: "DOUBLE"
      allowNull: false

    latitude:
      type: "DOUBLE"
      allowNull: false

    geohash:
      type: DataTypes.STRING
      allowNull: false

    address:
      type: DataTypes.STRING
      allowNull: false

    radius:
      type: DataTypes.INTEGER(11)
      allowNull: false

    manager:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"
  ,
    tableName: 'business_district'
    classMethods:
      associate: (models) ->
        BusinessDistrict.hasMany(models.ncMallShop, {
          foreignKey: 'business_district'
        })

      # 获得一个商圈
      getOne: (id) ->
        deferred = Q.defer()

        BusinessDistrict.find({
          where:
            id: id
          attributes: ['id', 'desc', 'name', 'state', 'state_code', 'city', 'city_code', 'district', 'district_code', 'street', 'street_code', 'address']
          include: [{
            model: models.ncMallShop
            attributes: ['id', 'name', 'desc', 'phone', 'state', 'city', 'district', 'street']
          }]
        }, {
          # raw: true
          # nest: true
        }).then (businessDistrict) ->
          deferred.resolve(businessDistrict)
        , (err) ->
          console.log(err)
          deferred.reject(err)

        deferred.promise

      # 获得多个商圈
      getMany: (ids) ->
        deferred = Q.defer()
        promiseArr = []

        ids.forEach (id, index) ->
          promiseArr.push(BusinessDistrict.getOne(id))

        Q.all(promiseArr).then (businessDistricts) ->
          deferred.resolve(businessDistricts)
        , (err) ->
          console.log(err)
          deferred.reject(err)

        deferred.promise

  return BusinessDistrict
