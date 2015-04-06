module.exports = (sequelize, DataTypes) ->
  RealInfo = sequelize.define "real_info",
    id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    app_id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    user:
      type: DataTypes.INTEGER(11)
      allowNull: false

    remark:
      type: DataTypes.STRING
      allowNull: false

    gravatar:
      type: DataTypes.STRING
      allowNull: false

    location:
      type: DataTypes.STRING
      allowNull: false

    id_num:
      type: DataTypes.STRING
      allowNull: false

    id_images:
      type: DataTypes.STRING
      allowNull: false

    real_name:
      type: DataTypes.STRING
      allowNull: false

    create_time:
      type: DataTypes.DATE
      allowNull: false

    update_time:
      type: DataTypes.DATE
      allowNull: false

    deleted:
      type: DataTypes.BOOLEAN
      allowNull: false

    banned:
      type: DataTypes.BOOLEAN
      allowNull: false
      defaultValue: "0"

    unauthenticated:
      type: DataTypes.BOOLEAN
      allowNull: false
      defaultValue: "0"

    working:
      type: DataTypes.BOOLEAN
      allowNull: false
      defaultValue: "1"

    deliver_team:
      type: DataTypes.INTEGER(11)
      allowNull: true

    city_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    province_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    district_code:
      type: DataTypes.BIGINT
      allowNull: false
      defaultValue: "0"

    deliver_type:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: "part-time"

    level:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "1"

    alipay_account:
      type: DataTypes.STRING
      allowNull: true

    alipay_name:
      type: DataTypes.STRING
      allowNull: true

    income_rule:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: "0"

    check_status:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    province:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    city:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: ""

    district:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    manager:
      type: DataTypes.INTEGER(11)
      allowNull: false

    resign_result_reason:
      type: DataTypes.STRING
      allowNull: true
  ,
    tableName: 'real_info'
    classMethods:
      associate: (models) ->
        RealInfo.belongsTo(models.ncUserCenterUser, {
          foreignKey: 'user'
        })

  return RealInfo
