/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('recruit', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
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
    },
    creator_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    creator_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    creator_tel: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    images: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    amount: {
      type: DataTypes.INTEGER(5),
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    district: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    latitude: {
      type: 'DOUBLE',
      allowNull: false,
    },
    longitude: {
      type: 'DOUBLE',
      allowNull: false,
    },
    geohash: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    remark: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    reason: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  });
};
