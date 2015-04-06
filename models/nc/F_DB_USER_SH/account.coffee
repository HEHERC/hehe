# jshint indent: 2 
module.exports = (sequelize, DataTypes) ->
  Account = sequelize.define("Account",
    id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    user_id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    balance:
      type: DataTypes.DECIMAL(10, 2)
      allowNull: false

    recharge:
      type: DataTypes.DECIMAL(10, 2)
      allowNull: false

    cost:
      type: DataTypes.DECIMAL(10, 2)
      allowNull: false

    collection:
      type: DataTypes.DECIMAL(10, 2)
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

    alipay_account:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    alipay_name:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    withdrawal_password:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ""

    frozen_collection:
      type: DataTypes.DECIMAL(10, 2)
      allowNull: false
      defaultValue: "0.00"

    frozen_balance:
      type: DataTypes.DECIMAL(10, 2)
      allowNull: false
      defaultValue: "0.00"
  ,
    timestamps: false
    tableName: "account"
    classMethods: {
      associate: (models) ->
        Account.belongsTo(models.ncUserCenterUser, {
          foreignKey: 'user_id'
        })
    }
  )
  Account
