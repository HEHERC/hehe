/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deal', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    user: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    type: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    source: {
      type: DataTypes.INTEGER(6),
      allowNull: true,
    },
    target_type: {
      type: DataTypes.INTEGER(6),
      allowNull: true,
    },
    target: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    amount: {
      type: 'DOUBLE',
      allowNull: false,
    },
    create_time: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
