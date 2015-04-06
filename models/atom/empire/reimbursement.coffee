debug = require('debug')('model:reimbursement')
module.exports = (sequelize, DataTypes) ->
  Reimbursement = sequelize.define 'Reimbursement',
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

    # 票据类型 A:表示票据跟实际金额相符 B:与A相反
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

      # 产生报销(支付)编号
      generateReimbursementCode: (Q, Sequelize, moment, applierId, models, addZero) ->
        deferred = Q.defer()
        startTime = moment(new Date()).set
          hour: 0
          minute: 0
          second: 0
          millisecond: 0
        .toISOString()
        endTime = moment(new Date()).set
          hour: 24
          minute: 0
          second: 0
          millisecond: 0
        .toISOString()

        models.atomEmpireReimbursement.findAndCount({
          where: Sequelize.and(Sequelize.where(Sequelize.col('Reimbursement.applier_id'), '=', applierId), Sequelize.where(Sequelize.col('Reimbursement.create_time'), '>=', startTime), Sequelize.where(Sequelize.col('Reimbursement.create_time'), '<=', endTime))
        }).then (reimbursements) ->
          models.atomEmpireUser.find(applierId).then (user) ->
            time = moment().format('MMDD')
            staffNumMax =  addZero(user.getDataValue('staff_num'), 4)
            debug 'reimbursements count is: '
            debug reimbursements
            numStr = addZero(reimbursements.count + 1, 3)
            code = staffNumMax + time + numStr
            deferred.resolve(code)
        , (err) ->
          deferred.reject err
        return deferred.promise
