module.exports = (sequelize, DataTypes) ->
  Authority = sequelize.define 'Authority',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    name:
      type: DataTypes.STRING(64)
      allowNull: false
    desc:
      type: DataTypes.TEXT
      allowNull: false
      defaultValue: ""
  ,
    tableName: 'authority'
    classMethods:
      associate: () ->
        this.belongsToMany(sequelize.model('Role'), {
          as: {
            plural: 'roles'
            singular: 'role'
          }
          through: 'role_authority'
        })
