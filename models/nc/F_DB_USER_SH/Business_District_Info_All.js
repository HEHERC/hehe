/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Business_District_Info_All', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    business_district: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    total_order_count: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    average_order_count: {
      type: 'DOUBLE',
      allowNull: false,
    },
    shop_of_min_order_count: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_of_max_order_count: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    total_complaint_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    total_complaint_deliver_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    total_cancel_complaint_count: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    statistic_date: {
      type: DataTypes.DATE,
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
