module.exports = (sequelize, DataTypes) ->
  News = sequelize.define 'News',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    title:
      type: DataTypes.STRING
      allowNull: false
      title: ''
    body:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ''
    image_id:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ''
    top_image_id:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ''
    link:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ''
    type:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: true
    top:
      type: DataTypes.BOOLEAN
      allowNull: true
      defaultValue: false
    deleted:
      type: DataTypes.BOOLEAN
      allowNull: true
      defaultValue: false
    # 浏览次数
    browser_times:
      type: DataTypes.INTEGER
      allowNull: true
      defaultValue: 0
  ,
    tableName: 'news'
    classMethods:
      associate: () ->

