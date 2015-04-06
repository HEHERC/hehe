debug = require('debug')('routes:company_file')
express = require 'express'
router = express.Router()
models = require('../../models/index')
_ = require('../../lib/utils')._
utils = require('../../lib/utils')
async = require('async')
Q=require ('q')
request = require('request')
urls = require('../../config/url.json')
appConfig = require('../../app_config')

# 获取文件
router.get '/file', (req, res) ->
  models.atomEmpireCompanyFile.findAll({
    include: [{
      model: models.atomEmpireDepartmentStructure
      as: 'departmentStructure'
      attributes: ['id', 'name', 'code']
    }]
  }).then (files) ->
    res.status(200).send(files)
  , (err) ->
    console.log err
    res.status(500).send('获取失败')

# 获取单个文件信息
router.get '/file/:fileId', (req, res) ->
  fileId = req.params.fileId

  models.atomEmpireCompanyFile.find({
    where:
      id: fileId
    include: [{
      model: models.atomEmpireDepartmentStructure
      as: 'departmentStructure'
      attributes: ['id', 'name', 'code']
    }]
  }).then (file) ->
    res.status(200).send(file)
  , (err) ->
    res.status(500).send('获取失败')

# 创建文件
# 当req中传递的参数中没有group_ids参数时，默认该文件创建的为系统公共文件，不为空，则将对应的
# group_ids存在group_with_files数据表中
router.post '/file', (req, res) ->
  groupids=req.body.group_ids.split(',')
  Q.fcall(->
      models.atomEmpireCompanyFile.create(req.body)
    ).then (file) ->
      res.status(200).send(file)
      promises=[]
      if groupids.length==1
        promises.push(models.atomEmpireGroupWithFile.create({'group_id':null,'document_id':file.id}))
      else
        _.each groupids, (groupid) ->
         promises.push(models.atomEmpireGroupWithFile.create({'group_id':groupid,'document_id':file.id}))
      Q.all(promises)

# 修改文件
router.patch '/file/:fileId', (req, res) ->
  body = req.body
  fileId = req.params.fileId

  models.atomEmpireCompanyFile.update(body, {
    where:
      id: fileId
  }).then (file) ->
    res.status(200).send('修改成功')
  , (err) ->
    console.log err
    res.status(400).send('修改失败')

router.delete '/file/:fileId', (req, res) ->
  fileId = req.params.fileId

  models.atomEmpireCompanyFile.destroy({
    where:
      id: fileId
  }).then (file) ->
    console.log file
    res.status(204).send('已删除')
  , (err) ->
    console.log err
    res.status(500).send('删除失败')

module.exports = router

