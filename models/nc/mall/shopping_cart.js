/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('shopping_cart', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    commodity_sku: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    count: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    price: {
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
