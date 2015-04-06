/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('shop_settle', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    settle_day: {
      type: DataTypes.INTEGER(6),
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
    }
  });
};
