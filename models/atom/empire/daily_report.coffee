module.exports = (sequelize, DataTypes) ->
  DailyReport = sequelize.define 'DailyReport',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    title:
      type: DataTypes.STRING(25)
      allowNull: false
      defaultValue: ""
    content:
      type: DataTypes.TEXT
      allowNull: false
      defaultValue: ""
    type:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: 1
  ,
    tableName: 'daily_report'
    classMethods:
      associate: () ->
        this.belongsTo(sequelize.model('User'), {
          as: 'user'
        })
        this.hasMany(sequelize.model('Comment'), {
          as: 'comment'
        })
