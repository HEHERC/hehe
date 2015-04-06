Q = require('q')
moment = require('moment')

module.exports = (sequelize, DataTypes) ->
  sequelize.define 'EVENT_PS',
    id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    user_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    user_type:
      type: DataTypes.STRING
      allowNull: false

    user_team_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    event_type:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "1"

    deliver_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    deliver_type:
      type: DataTypes.STRING
      allowNull: false

    deliver_team_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    executor_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    related_user_ids:
      type: DataTypes.STRING
      allowNull: false

    ip_address:
      type: DataTypes.STRING
      allowNull: false

    money:
      type: DataTypes.DECIMAL(10, 2)
      allowNull: false
      defaultValue: "0.00"

    order_num:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    group_num:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    group_num_count:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "0"

    shop_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    shop_type:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "0"

    business_district:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    distance:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    order_type:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "0"

    related_tables:
      type: DataTypes.STRING
      allowNull: false

    operation_type:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "0"

    is_operation_success:
      type: DataTypes.INTEGER(4)
      allowNull: false
      defaultValue: "1"

    tel:
      type: DataTypes.STRING
      allowNull: false

    phone_brand:
      type: DataTypes.STRING
      allowNull: false

    phone_version:
      type: DataTypes.STRING
      allowNull: false

    phone_os_version:
      type: DataTypes.STRING
      allowNull: false

    phone_network_type:
      type: DataTypes.STRING
      allowNull: false

    phone_operator:
      type: DataTypes.STRING
      allowNull: false

    interface_return_value:
      type: DataTypes.STRING
      allowNull: false

    interface_use_time:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    recommended_tel:
      type: DataTypes.STRING
      allowNull: false

    source:
      type: DataTypes.STRING
      allowNull: false

    equipment_id:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "0"

    order_use_time:
      type: DataTypes.INTEGER(11)
      allowNull: false
      defaultValue: "0"

    create_time:
      type: DataTypes.DATE
      allowNull: false

    utc_create_time:
      type: DataTypes.DATE
      allowNull: false

    province_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    city_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    district_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    street_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    longitude:
      type: DataTypes.FLOAT
      allowNull: false
      defaultValue: "0"

    latitude:
      type: DataTypes.FLOAT
      allowNull: false
      defaultValue: "0"

    geohash:
      type: DataTypes.STRING
      allowNull: false

    reason:
      type: DataTypes.STRING
      allowNull: false
  ,
    timestamps: false
    tableName: 'EVENT_PS'
    classMethods:
      getAll: (options) ->
        deferred = Q.defer()
        where = {}

        if options.user_id
          where.user_id = options.user_id

        if options.start_time
          where.utc_create_time =
            between: [options.start_time, options.end_time]

        if options.event_type
          where.event_type = options.event_type

        @.findAll({
          where: where
          attributes: ['user_id', 'utc_create_time', 'longitude', 'latitude']
        }).then (logs) ->
          deferred.resolve(logs)
        , (err) ->
          deferred.reject(err)

        deferred.promise
