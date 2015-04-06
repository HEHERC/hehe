/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  var Withdraw = sequelize.define('withdraw', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    account: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    amount: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    frozen_collection: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    frozen_balance: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    num: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    alipay_account: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    alipay_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    create_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    withdraw_time: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    update_time: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  }, {
    timestamps: false,
    tableName: 'withdraw',
    classMethods: {
      associate: function(models) {
        Withdraw.belongsTo(models.ncFDBUSERSHAccount, {
          foreignKey: 'account',
        });
      }
    }  
  });

  return Withdraw
};
