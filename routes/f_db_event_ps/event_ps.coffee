models = require('../../models/index')
express = require('express')
router = express.Router()
debug = require('debug')('routes:event:log')
sequelize = models.sequelize
_ = require('../../lib/utils')._

url = '/event/ps'

# 获取更新地理位置
router.get "#{url}/position", (req, res) ->
  query = req.query

  query.event_type = 1037

  models.ncFDBEVENTPSEVENTPS.getAll(query).then (logs) ->
    res.json(logs)
  , (err) ->
    console.log err
    res.status(400).send('error')

module.exports = router
