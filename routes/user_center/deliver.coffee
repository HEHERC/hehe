models = require '../../models/index'
express = require 'express'
router = express.Router()
debug = require('debug')('routes:user_center:deliver')
sequelize = models.sequelize

router.get '/user/deliver/:deliverId', (req, res) ->
  params = req.params
  deliverId = req.params.deliverId
  data = {}
  
  models.ncUserCenterRealInfo.find({
    where:
      user: deliverId
    attributes: ['remark', 'resign_result_reason']
  }).then (realInfo) ->
    models.ncUserCenterApplyDeliver.find({
      where:
        user: deliverId
      # attributes: ['check_status', 'education', 'score', 'age', 'sex', 'school_office', 'native_province', 'native_city', 'birthday', 'height', 'has_android', 'how_long', 'growth_environment', 'parents_backgrounds', 'marital_status', 'children_order', 'id_card_num', 'emergency_tel', 'emergency_contact', 'remark']
    }).then (applyDeliver) ->

      if applyDeliver
        applyDeliver.status = applyDeliver.check_status
        applyDeliver.dataValues.native_place = applyDeliver.dataValues.native_province + applyDeliver.dataValues.native_city


      if realInfo && realInfo.dataValues
        applyDeliver.dataValues.remark = realInfo.dataValues.remark

        if realInfo.dataValues.resign_result_reason
          applyDeliver.dataValues.remark = realInfo.dataValues.resign_result_reason

      res.send(applyDeliver)

module.exports = router
