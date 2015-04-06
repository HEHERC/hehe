/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_salary_detail', { 
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
    deliver_monthly_salary: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    closed: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    }
  });
};
