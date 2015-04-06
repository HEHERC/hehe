debug = require('debug')('routes:reimbursement')
express = require 'express'
router = express.Router()
Sequelize = require('sequelize')
models = require('../../models/index')
moment = require('moment')
Q = require('q')

addZero = (str, num) ->
  length = str.toString().length

  if not num
    num = 5

  i = 0
  while i < (num - length)
    i++
    str = '0' + str

  return str

router.get '/reimbursement/code', (req, res) ->
  applierId = req.query.applier_id

  models.atomEmpireReimbursement.generateReimbursementCode(Q, Sequelize, moment, applierId, models, addZero).then (code) ->
    res.status(200).send({
      code: code
    })
  , () ->
    res.status(500).send('编码获取失败')

router.get '/reimbursement', (req, res) ->
  code = req.query.code
  where = {}

  if code
    where.reimbursement_code = code

  models.atomEmpireReimbursement.findAll({
    where: where
    # attributes: ['id', 'apply_type', 'reimbursement_code', 'modified_expense', 'receipt_type', 'fee_type', 'date', 'expense', 'description', 'remark']
    include: [
      {
        model: models.atomEmpireUser
        as: 'applyInfo'
        attributes: ['id', 'staff_num', 'phone', 'is_leader', 'name']
        include: [
          {
            model: models.atomEmpireDepartmentStructure
            as: 'empireDepartment'
            attributes: ['name', 'id']
          }
        ]
      }
    ]
  }).then (reimbursements) ->
    res.status(200).send(reimbursements)
  , (err) ->
    console.log err
    res.status(500).send('获取失败')

router.post '/reimbursement', (req, res) ->
  applierId = req.body.applier_id
  models.atomEmpireReimbursement.generateReimbursementCode(Q, Sequelize, moment, applierId, models, addZero).then (code) ->
    req.body.reimbursement_code = code
    models.atomEmpireReimbursement.create(req.body).then (reimbursement) ->
      res.status(201).send(reimbursement)
    , (err) ->
      res.status(500).send('创建失败')

router.put '/reimbursement/:reimbursementId', (req, res) ->
  reimbursementId = req.params.reimbursementId

  models.atomEmpireReimbursement.update(req.body, {
    where:
      id: reimbursementId
  }).then () ->
    res.status(200).send('修改成功')
  , (err) ->
    res.status(500).send('修改失败')

router.patch '/reimbursement/:reimbursementId', (req, res) ->
  reimbursementId = req.params.reimbursementId

  models.atomEmpireReimbursement.update(req.body, {
    where:
      id: reimbursementId
  }).then () ->
    if req.body.is_effective == 'N'
      res.status(200).send ('删除成功')
    else
      res.status(200).send ('恢复成功')
  , (err) ->
    res.status(500).send('删除失败')

module.exports = router

