/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('multiple_shop_relation', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    multiple_shop: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop: {
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
    }
  });
};
