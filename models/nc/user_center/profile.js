/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('profile', { 
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
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    age: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    birthday: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    gender: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    image: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    desc: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    tel: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    country: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    state: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    city: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    district: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    street: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    interests: {
      type: DataTypes.STRING,
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
    banned: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '0'
    },
    unauthenticated: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: '0'
    }
  });
};
