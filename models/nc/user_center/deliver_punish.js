/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_punish', { 
    id: {
      type: DataTypes.INTEGER(11),
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
    punish_user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    amount: {
      type: 'DOUBLE',
      allowNull: false,
    },
    reason: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    executor: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '0'
    }
  });
};
