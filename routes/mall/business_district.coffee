models = require('../../models/index')
express = require('express')
router = express.Router()
debug = require('debug')('routes:mall:business_district')
sequelize = models.sequelize
_ = require('underscore')

# 根据商圈id获取小队
router.get '/mall/business_district/:businessDistrictId/team', (req, res) ->
  businessDistrictId = req.params.businessDistrictId

  models.ncMallBusinessDistrictTeamRelation.getTeamsByDistrict(businessDistrictId).then (relations) ->
    ids = _.pluck(relations, 'team_id')

    models.ncUserCenterDeliverTeam.getMany(ids).then (teams) ->
      res.json(teams)
    , (err) ->
      res.status(400).send('error')
  , (err) ->
    res.status(400).send('error')

module.exports = router
