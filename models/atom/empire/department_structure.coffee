debug = require('debug')('models:department_structure')
Q = require('q')
_ = require('../../../lib/utils')._
async = require('async')

module.exports = (sequelize, DataTypes) ->
  DepartmentStructure = sequelize.define 'DepartmentStructure',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    name:
      type: DataTypes.STRING
      allowNull: false
    parent:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      defaultValue: 0
    description:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: ''
    code:
      type: DataTypes.STRING
      allowNull: true
      defaultValue: ''
  ,
    tableName: 'department_structure'
    subArray: []
    classMethods:
      associate: (models) ->
        @.belongsToMany(sequelize.model('User'), {
          as: 'EmpireUser'
          through: 'user_in_department'
        })
        @.hasMany sequelize.model 'CompanyFile'

      # 获得某个组织信息
      getOne: (id) ->
        @find(id)

      # 获取组织
      getAll: (options) ->
        @.findAll(options)

      # 创建组织
      createOne: (values) ->
        @.create(values)

      # 修改组织信息
      updateOne: (values) ->
        @.update(values, {
          where:
            id: values.id
        })

      # 删除组织
      removeOne: (id) ->
        @.destroy({
          where:{
            id: id
          }
        })

      findSubDepartments: (department, callback) ->
        self = this
        if typeof department is 'object' and department.getDataValue?
          departmentId = department.getDataValue('id')
        else
          departmentId = department
        this.find({
          where:
            parent: departmentId
        }).then (subDepartment) ->
          if subDepartment
            self.findSubDepartments(subDepartment, callback)
          callback(subDepartment)


      getAllSubDepartmentIds: (departmentId, callback) ->
        departmentIds = []
        self = this

        if parseInt(departmentId) is 0
          callback null
          return

        self.find(departmentId).then (department) ->
          debug 'department is: '
          debug department
          if department?
            departmentIds.push(department.getDataValue('id'))
          self.findAll({
            where:
              parent: departmentId
          }).then (departments) ->
            debug 'dpartments is: '
            debug departments
            each = (department, next) ->
              debug 'department id is: '
              debug department.getDataValue('id')
              self.getAllSubDepartmentIds(department.getDataValue('id'), (subDepartments) ->
                debug 'subDepartments is: '
                debug subDepartments
                departmentIds = departmentIds.concat(subDepartments)
                next()
                debug 'departmentIds is: '
                debug departmentIds
              )
            done = () ->
              debug 'done departmentIds is: '
              debug departmentIds
              callback(departmentIds)
            async.each(departments, each, done)

      # 根据用户获取上级所有部门
      getAllByUser: (userId) ->
        atomEmpireUser.find(userId).then (user) ->
          user.getEmpireDepartment().then (department) ->
            console.log department

      # 获得该部门下的成员
      getMembers: (id) ->
        deferred = Q.defer()

        @.find({
          where:
            id: id
        }).then (department) ->
          if department
            department.getEmpireUser().then (users) ->
              users = _(users).pluckAttrDeep('dataValues').map((user) ->
                user.isLeaf = true
                return _.omit(user, 'user_in_department')
              ).value()

              deferred.resolve(users)
          else
            deferred.resolve([])

        deferred.promise

      # 获取某部门的子部门以及成员
      getSubs: (id) ->
        deferred = Q.defer()

        findDepartmentsPromise = @.findAll({
          where:
            parent: id
          attributes: ['id', 'name', 'parent', 'code']
        })

        Q.all([@.getMembers(id), findDepartmentsPromise]).then (results) ->
          subDepartments = _(results[1]).pluckAttrDeep('dataValues').map((department) ->
            department.isLeaf = false
            return department
          ).value()

          deferred.resolve(results[0].concat(subDepartments))

        deferred.promise

