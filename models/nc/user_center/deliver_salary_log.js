/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_salary_log', { 
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
    executor: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    deliver: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    amount: {
      type: 'DOUBLE',
      allowNull: false,
    }
  });
};
