debug = require('debug')('routes:outExcel')
express = require 'express'
router = express.Router()
Sequelize = require('sequelize')
models = require('../../models/index')
moment = require('moment')
nodeExcel = require('excel-export')

router.get '/outexcel',(req,res)->
  response=res
  models.atomEmpireReimbursement.findAll({
    order: 'id asc'
  },
    raw: true
    logging: true
  plain: false).on('success', (res) ->
    m_data=[]
    conf=[]
    conf.cols=[
      {caption:'reimbursement_code',type:'string'},
      {caption:'apply_type',type:'string'},
      {caption:'applier_id',type:'number'},
      {caption:'fee_type',type:'string'},
      {caption:'receipt_type',type:'string'},
      {caption:'receipt_count',type:'number'},
      {caption:'date',type:'string'},
      {caption:'expense',type:'number'},
      {caption:'modified_expense',type:'number'},
      {caption:'description',type:'string'},
      {caption:'job',type:'string'},
      {caption:'remark',type:'string'},
      {caption:'is_effective',type:'string'},
    ]
    i = 0
    arr=new Array()
    while i < res.length
      arr.push [
        res[i].reimbursement_code
        res[i].apply_type
        res[i].applier_id
        res[i].fee_type
        res[i].receipt_type
        res[i].receipt_count
        res[i].date
        res[i].expense
        res[i].modified_expense
        res[i].description
        res[i].job
        res[i].remark
        res[i].is_effective
       ]
      i++
    conf.rows=arr
    result = nodeExcel.execute(conf)
    response.setHeader 'Content-Type', 'application/vnd.ms-excel',  
    response.setHeader 'Content-Disposition', 'attachment; filename=报销单.xlsx'
    response.end result, 'binary'
    return
).on 'failure', (err) ->
   console.log err


module.exports=router