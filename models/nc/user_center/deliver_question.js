/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('deliver_question', { 
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    category: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    app_id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    images: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    content: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    options: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    answer: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    order: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    parent: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    score: {
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
