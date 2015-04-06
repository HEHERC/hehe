/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_type_relation', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    deliver_type_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user_id: {
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
    }
  });
};
