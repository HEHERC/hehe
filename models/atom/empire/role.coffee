module.exports = (sequelize, DataTypes) ->
  Role = sequelize.define 'Role',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    # @depreted 移到了权限角色中心
    name:
      type: DataTypes.STRING(64)
      allowNull: false
    # @depreted 移到了权限角色中心
    desc:
      type: DataTypes.TEXT
      allowNull: false
      defaultValue: ""
  ,
    tableName: 'role'
    classMethods:
      associate: () ->
        this.hasMany sequelize.model 'User'
        this.belongsToMany(sequelize.model('Authority'), {
          as: {
            plural: 'authorities'
            singular: 'authority'
          }
          through: 'role_authority'
        })
