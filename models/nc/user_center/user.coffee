# jshint indent: 2 
module.exports = (sequelize, DataTypes) ->
  User = sequelize.define 'User',
    id:
      type: DataTypes.INTEGER(11)
      allowNull: false

    email:
      type: DataTypes.STRING
      allowNull: true

    password:
      type: DataTypes.STRING
      allowNull: true

    type:
      type: DataTypes.INTEGER(6)
      allowNull: false

    status:
      type: DataTypes.INTEGER(6)
      allowNull: false

    create_time:
      type: DataTypes.DATE
      allowNull: false

    update_time:
      type: DataTypes.DATE
      allowNull: false

    tel:
      type: DataTypes.STRING
      allowNull: false
  , {
    tableName: 'user'
    classMethods: {
      associate: (models) ->
        User.hasOne(models.ncFDBUSERSHAccount, {
          foreignKey: 'user_id'
        })
        User.hasOne(models.ncMallShop, {
          foreignKey: 'owner_id'
        })
    }
  }

  return User
