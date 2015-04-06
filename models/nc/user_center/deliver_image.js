/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_image', { 
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
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    avatar: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    avatar_status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    avatar_reason: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    id_image: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    id_image_back: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    id_status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    id_reason: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    health_image: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    health_reason: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    health_status: {
      type: DataTypes.INTEGER(6),
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
