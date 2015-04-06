/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('abnormal_orders', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    order_num: {
      type: DataTypes.BIGINT,
      allowNull: true,
      defaultValue: '0',
    },
    deliver_id: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
      defaultValue: '0',
    },
    type: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    level: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    create_time: {
      type: DataTypes.DATE,
      allowNull: true,
    }
  }, {
    timestamps: false,
  });
};
