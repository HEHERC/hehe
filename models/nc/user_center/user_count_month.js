/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_count_month', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    count: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
