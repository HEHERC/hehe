/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_team_shop_relation', { 
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
    deliver_team: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_id: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    }
  });
};
