/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('shop_verify', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    creator_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    info: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    reason: {
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
    deleted: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    cert_time: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    feedback_times: {
      type: DataTypes.INTEGER(5),
      allowNull: false,
      defaultValue: '0'
    },
    image_ids: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: '[]'
    },
    image_menu_front_ids: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: '[]'
    },
    image_menu_back_ids: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: '[]'
    },
    state: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    city: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    district: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    latitude: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: '0'
    },
    longitude: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: '0'
    },
    geohash: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    street: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    interested: {
      type: DataTypes.INTEGER(4),
      allowNull: false,
      defaultValue: '1'
    },
    is_taken_out: {
      type: DataTypes.INTEGER(4),
      allowNull: false,
      defaultValue: '1'
    },
    daily_order_num: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    wind_flag: {
      type: DataTypes.INTEGER(4),
      allowNull: false,
      defaultValue: '0'
    },
    phone: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    remark: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    creator_name: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    creator_tel: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    }
  });
};
