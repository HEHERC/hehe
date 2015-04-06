module.exports = (sequelize, DataTypes) ->
  Comment = sequelize.define 'Comment',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    content:
      type: DataTypes.TEXT
      allowNull: false
      defaultValue: ""
    owner_id:
      type: DataTypes.INTEGER(11).UNSIGNED
      unique: true
    daily_report_id:
      type: DataTypes.INTEGER(11).UNSIGNED
      unique: true
  ,
    tableName: 'comment'
    classMethods:
      associate: () ->
        this.belongsTo(sequelize.model('DailyReport'), {
          as: 'daily_report'
        })
        this.belongsTo(sequelize.model('User'), {
          as: 'owner'
        })

      findCommentFromReportOption: () ->
        return {
          model: sequelize.model('Comment')
          as: 'comment'
          attributes: ['id', 'content']
          include:
            model: sequelize.model('User')
            as: 'owner'
            attributes: ['id', 'name', 'avatar_qiniu_hash']
        }
