/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_monthly_salary', { 
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
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    amount: {
      type: 'DOUBLE',
      allowNull: false,
    },
    year: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    month: {
      type: DataTypes.INTEGER(5),
      allowNull: false,
    },
    closed: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    }
  });
};
