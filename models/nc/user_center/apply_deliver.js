/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ApplyDeliver', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    tel: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    province: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    province_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    city: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    city_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    district: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    district_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    street: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    street_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    qq: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    experience: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '0'
    },
    vehicle: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '0'
    },
    how_long: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '0'
    },
    birthday: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    source: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    location: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    create_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    remark: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    checked: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '0'
    },
    update_time: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    deleted: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
      defaultValue: '0'
    },
    has_android: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '1'
    },
    recommend_user_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    trained: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '1'
    },
    check_status: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    sex: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    height: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    age: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    education: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    school_office: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    growth_environment: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    children_order: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    parents_backgrounds: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    marital_status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    native_province: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    native_province_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    native_city: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    native_city_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },
    score: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    id_card_num: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    }
  }, {
    tableName: 'apply_deliver'
  });
};
