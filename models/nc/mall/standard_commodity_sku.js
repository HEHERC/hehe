/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('standard_commodity_sku', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    commodity: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    property: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    amount: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    price: {
      type: 'DOUBLE',
      allowNull: false,
    },
    delivery_price: {
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
    creator_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    deleted: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    }
  });
};
