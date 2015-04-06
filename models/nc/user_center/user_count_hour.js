/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_count_hour', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    count: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    datetime: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
