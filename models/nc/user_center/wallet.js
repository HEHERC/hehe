/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('wallet', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    balance: {
      type: 'DOUBLE',
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
    }
  });
};
