/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Token', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    content: {
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
    expire_time: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  }, {
    tableName: 'token'
  });
};
