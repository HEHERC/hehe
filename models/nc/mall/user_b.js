/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_b', { 
    id: {
      type: DataTypes.INTEGER(6),
      allowNull: true,
    },
    name: {
      type: 'CHAR(9)',
      allowNull: true,
    }
  });
};
