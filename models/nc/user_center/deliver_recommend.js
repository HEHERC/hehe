/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_recommend', { 
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
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    desc: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    recommend_user_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    recommend_user_name: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    recommend_user_type: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    tel: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    transformed: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    user_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    }
  });
};
