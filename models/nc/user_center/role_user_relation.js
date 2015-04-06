/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('role_user_relation', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    windaccount_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    role_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    }
  });
};
