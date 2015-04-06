/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('system_account', { 
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
      allowNull: true,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    active: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    permission: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  });
};
