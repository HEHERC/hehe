/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  var Shop = sequelize.define('shop', { 
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
    state: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    state_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: '0'
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
    subscriber_tel: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    shop_type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '0'
    },
    business_district: {
      type: DataTypes.INTEGER(12),
      allowNull: true,
    },
    forecast_breakfast_orders: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    forecast_lunch_orders: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    forecast_afternoon_orders: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    forecast_supper_orders: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    forecast_midnight_orders: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    forecast_daily_orders: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
      defaultValue: '0'
    },
    has_android: {
      type: DataTypes.INTEGER(1),
      allowNull: true,
      defaultValue: '1'
    },
    referrer_user_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
      defaultValue: '0'
    },
    referrer_longitude: {
      type: 'DOUBLE',
      allowNull: false,
      defaultValue: '0'
    },
    referrer_latitude: {
      type: 'DOUBLE',
      allowNull: false,
      defaultValue: '0'
    },
    referrer_geohash: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    recommend_user_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    big_volume_merchant: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '0'
    },
    is_rush_hour: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    manager: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
      defaultValue: '0'
    }
  }, {
    tableName: 'shop',
    classMethods: {
      associate: function(models) {
        Shop.belongsTo(models.ncUserCenterUser, {
          foreignKey: 'owner_id'
        });
      }
    }
  });

  return Shop;
};
