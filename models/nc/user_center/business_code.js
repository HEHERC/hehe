/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('business_code', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    code: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    version: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    promoter: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    area: {
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
