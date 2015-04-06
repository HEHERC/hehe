models = require('../../models/index')
express = require('express')
router = express.Router()
debug = require('debug')('routes:user_center:deliver_team')
sequelize = models.sequelize
_ = require('underscore')

# 根据配送队id获取商圈
router.get '/user/deliver_team/:teamId/business_district', (req, res) ->
  teamId = req.params.teamId

  models.ncMallBusinessDistrictTeamRelation.getDistrictsByTeam(teamId).then (relations) ->
    ids = _.pluck(relations, 'business_district')
    models.ncMallBusinessDistrict.getMany(ids).then (businessDistricts) ->
      res.json(businessDistricts)
    , (err) ->
      res.status(400).send('error')

  , (err) ->
    debug('Get shops counted a error, see below:')
    debug(err)
    res.status(400).send('error')

module.exports = router
