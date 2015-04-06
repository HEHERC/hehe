/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('posts', { 
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
    title: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    body: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    image_id: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    link: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    }
  });
};
