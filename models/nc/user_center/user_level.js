/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('user_level', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    level: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
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
    type: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: true,
    }
  });
};
