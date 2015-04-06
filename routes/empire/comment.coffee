debug = require('debug')('models:comment')
models = require('../../models/index')
Mail = require('../../lib/mail')
moment = require('moment')
express = require 'express'
router = express.Router()

router.put '/daily_report/:daily_report/comment', (req, res) ->
  req.body.daily_report_id = req.params.daily_report
  comment = req.body
  models.atomEmpireComment.upsert(req.body, {
    where:
      daily_report_id: req.params.daily_report
  }).then () ->
    models.atomEmpireUser.find(req.body.owner_id, {
      raw: true
    }).then((owner) ->
      req.body.owner = owner
      res.status(200).json(req.body).end()

      models.atomEmpireDailyReport.find(req.body.daily_report_id).then (dailyReport) ->
        dailyReport.getUser({
          raw: true
        }).then (receiver) ->

          # 发送邮件
          mail = new Mail('dg')
          mail.send('dailyReportComment', {
            email: receiver.email
            name: receiver.name
            comment: comment.content
            ownerName: owner.name
            dailyReportCreateTime: moment(dailyReport.getDataValue('create_time')).format('YYYY年MM月DD日')
          }).then () ->
    )
  , () ->
    res.status(500).end('创建评论失败')

module.exports = router
