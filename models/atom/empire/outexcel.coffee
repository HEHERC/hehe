module.exports = (sequelize, DataTypes) ->
  Reimbursement = sequelize.define 'Outexcel',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    reimbursement_code:
      type: DataTypes.STRING
      allowNull: false
    apply_type:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: "NORMAL"
    applier_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
    fee_type:
      type: DataTypes.STRING
      allowNull: false
    receipt_type:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: ''
    receipt_count:
      type: DataTypes.INTEGER(11)
      allowNull: false
    date:
      type: DataTypes.STRING
      allowNull: true
    expense:
      type: DataTypes.INTEGER(11)
      allowNull: false
    modified_expense:
      type: DataTypes.INTEGER(11)
      allowNull: true
    description:
      type: DataTypes.STRING
      allowNull: true
    remark:
      type: DataTypes.STRING
      allowNull: true
    job:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: ''
    is_effective:
      type: DataTypes.STRING
      allowNull: false
      defaultValue: 'Y'
  ,
    tableName: 'reimbursement'
    classMethods:
      associate: () ->
        this.belongsTo(sequelize.model('User'), {
          foreignKey: 'applier_id'
          as: 'applyInfo'
        })

