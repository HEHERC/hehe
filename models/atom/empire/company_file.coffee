module.exports = (sequelize, DataTypes) ->
  CompanyFile = sequelize.define 'CompanyFile',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    title:
      type: DataTypes.STRING
      allowNull: false
    content:
      type: DataTypes.TEXT
      allowNull: false
      defaultValue: ''
    range:
      type: DataTypes.INTEGER
      allowNull: true
    icon:
      type: DataTypes.STRING(64)
      allowNull: true
    department_structure_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
    desc:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: ''
  ,
    tableName: 'company_file'
    classMethods:
      associate: () ->
        this.belongsTo(sequelize.model('DepartmentStructure'), {
          as: 'departmentStructure'
        })

