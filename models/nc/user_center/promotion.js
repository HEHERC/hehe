/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('promotion', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    from_user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    tel: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    to_user: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    status: {
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
    },
    promotion_str: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    }
  });
};
