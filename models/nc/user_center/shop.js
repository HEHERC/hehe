/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('shop', { 
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
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    images: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    desc: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    bulletin: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    phone: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    owner_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    reason: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    asked_menu_num: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    country: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    state_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: '0'
    },
    state: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    city: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    city_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: '0'
    },
    district: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    district_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: '0'
    },
    street: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    street_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: '0'
    },
    longitude: {
      type: 'DOUBLE',
      allowNull: false,
    },
    latitude: {
      type: 'DOUBLE',
      allowNull: false,
    },
    geohash: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    location_desc: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    location_mark: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    owner_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    owner_tel: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    cert_images: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    open_time: {
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
    shop_type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '1'
    },
    subscriber_tel: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    }
  });
};
