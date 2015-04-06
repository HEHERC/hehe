/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('permission_system_account_relation', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    systemaccount_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    permission_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    }
  });
};
