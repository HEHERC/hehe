/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('InfoAll', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user_id: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    shop_id: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    total_order_count: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    total_deliver_count: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    average_deliver_count: {
      type: 'DOUBLE',
      allowNull: false,
    },
    non_accept_order_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    exception_order_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    complaint_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    cancel_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    total_refund: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    total_charge: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    total_cashback: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    total_cost: {
      type: DataTypes.DECIMAL(10,2),
      allowNull: false,
    },
    min_order_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    max_order_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    average_order_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    province_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    city_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    district_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    }
  });
};
