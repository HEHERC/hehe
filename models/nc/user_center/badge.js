/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('badge', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    desc: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    image: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    order: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    price: {
      type: 'DOUBLE',
      allowNull: false,
    },
    creator: {
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
    }
  });
};
