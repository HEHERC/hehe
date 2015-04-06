/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_permission_relation', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    windaccount_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    permission_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    }
  });
};
