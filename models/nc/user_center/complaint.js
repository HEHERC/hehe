/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('complaint', { 
    id: {
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
      allowNull: true,
    },
    type: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    status: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    deliver: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    notice_complaint: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    notice_to_shop: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    notice_to_deliver: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    shop_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    punish_amount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    group_num: {
      type: DataTypes.BIGINT,
      allowNull: false,
    }
  });
};
