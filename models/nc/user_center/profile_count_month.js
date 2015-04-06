/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('profile_count_month', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
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
