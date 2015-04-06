/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_rule', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    desc: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    allowance: {
      type: 'DOUBLE',
      allowNull: false,
    },
    city: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    city_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    create_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    update_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    deleted: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    tip_percent: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: '1'
    },
    fixed_deduct_fee: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: '0'
    },
    fixed_fee: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: '0'
    },
    active_rule: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
      defaultValue: '1'
    },
    real_allowance: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: '0'
    }
  });
};
