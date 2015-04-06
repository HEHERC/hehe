module.exports = (sequelize, DataTypes) ->
  Login_code = sequelize.define 'LoginCode',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    code:
      type: DataTypes.STRING
      allowNull: false
    user_id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
  ,
    tableName: 'login_code'

