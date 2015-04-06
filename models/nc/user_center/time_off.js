/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('time_off', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
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
      allowNull: false,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    off_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    type: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    operator: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    approved: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    checked: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '0'
    }
  });
};
