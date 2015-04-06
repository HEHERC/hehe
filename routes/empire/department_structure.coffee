debug = require('debug')('routes:department_structure')
express = require('express')
router = express.Router()
models = require('../../models/index')
_ = require('../../lib/utils')._
async = require('async')

url = '/empire/department'

# 获得所有部门
router.get url, (req, res) ->
  name = req.query.term
  where = {}

  if name
    where.name =
      like: "%#{name}%"

  models.atomEmpireDepartmentStructure.getAll({
    where: where
    attributes: ['id', 'name', 'parent', 'code']
  }).then (departments) ->
    res.send(departments)
    # models.atomEmpireUser.findAll({
    #   where: where
    #   include: [{
    #     as: 'empireDepartment'
    #     model: models.atomEmpireDepartmentStructure
    #   }]
    # }).then (users) ->
    #   res.send(departments.concat(users))
  , (err) ->
    res.status(500).send({})

router.get "#{url}/:departmentId", (req, res) ->
  departmentId = req.params.departmentId

  models.atomEmpireDepartmentStructure.find({
    where:
      id: departmentId
  }).then (department) ->
    res.send(department)
  , (err) ->
    res.status(500).send({})

router.get "#{url}/:departmentId/users", (req, res) ->
  departmentId = req.params.departmentId

  models.atomEmpireDepartmentStructure.getMembers(departmentId).then (members) ->
    res.send(members)
  , (err) ->
    res.status(500).send({})

# 获得某个部门的子部门包括成员
router.get "#{url}/:departmentId/sub", (req, res) ->
  departmentId = req.params.departmentId

  models.atomEmpireDepartmentStructure.getSubs(departmentId).then (departments) ->
    res.send(departments)
  , (err) ->
    res.status(500).send({})

# 创建
router.post url, (req, res) ->
  body = req.body

  models.atomEmpireDepartmentStructure.createOne(body).then (department) ->
    res.send({
      id: department.id
      name: department.name
      parent: department.parent
    })
  , (err) ->
    res.status(500).send({})

# 增加成员 或 删除成员
router.post "#{url}/:departmentId/users", (req, res) ->
  departmentId = req.params.departmentId
  users = req.body.users
  delete_users = req.body.delete_users

  if not departmentId
    res.status(422).send({
      code: 1
      message: 'param no departmentId'
    })
  else
    async.waterfall([
      (callback) ->
        models.atomEmpireDepartmentStructure.getOne(departmentId).then (department) ->
          if not department
            res.status(500).send({
              code: 2
              message: 'can not find department'
            })
          else
            callback(null, department)

      (department, callback) ->
        if users?.length
         for user in users
            models.atomEmpireUser.find(user).then (user) ->
              # 先删除用户所在部门再修改
              user.setEmpireDepartment([]).then () ->
                department.addEmpireUser([user])

        if delete_users?.length
          for user in delete_users
            models.atomEmpireUser.find(user).then (user) ->
              user.setEmpireDepartment([]).then () ->
                console.log 'delete member success'

        res.sendStatus(201)
    ])

# 修改
router.patch "#{url}/:departmentId", (req, res) ->
  params = req.params
  body = req.body

  models.atomEmpireDepartmentStructure.updateOne({
    id: params.departmentId
    name: body.name
  }).then (department) ->
    res.sendStatus(200)
  , (err) ->
    console.log err
    res.status(500).send({})

# 删除
router.delete "#{url}/:departmentId", (req, res) ->
  params = req.params

  models.atomEmpireDepartmentStructure.removeOne(params.departmentId).then () ->
    res.sendStatus(204)
  , (err) ->
    res.status(500).send({})

module.exports = router
