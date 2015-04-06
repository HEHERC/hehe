/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('dongguan_stats', { 
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
    finished_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    finished_delivers: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_first_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    deliver_first_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    business_district_calls: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    no_call_business_district: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    first_call_business_district: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    first_send_team_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    first_call_business_district_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    highest_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    shop_calls: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    group_calls: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    adopted_teams: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    adopted_delivers: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    team_deliver_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    city_code: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: '441900000000',
    },
    deliver_complaints: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    error_orders: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    most_distance: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    average_distance: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    longest_time: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    average_time: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    first_call_shops: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    no_call_shops: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    first_send_deliver: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    no_send_deliver: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    first_send_team: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    no_send_team: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    charge_shops: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    charge_amount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    tip_cost_shops: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    tip_cost_amount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    system_charge_shops: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    system_charge_amount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    tip_grant_delivers: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    tip_grant_amount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    bonus_number: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    bonus_amount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    payments_balance: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    cash_pooling: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    }
  }, {
    timestamps: false,
  });
};
