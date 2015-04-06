/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_channel', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
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
