/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('notice_user_relation', { 
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
    title: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    body: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    },
    type: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    from_user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    to_user: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    has_read: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
    },
    args: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: ''
    }
  });
};
