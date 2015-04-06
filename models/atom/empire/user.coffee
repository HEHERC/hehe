debug = require('debug')('models:user')
Q = require('q')
XLSX = require('xlsx')
path = require('path')
fs = require('fs')
xlsx = require('node-xlsx')
_ = require('lodash')
md5 = require('blueimp-md5').md5
async = require('async')

request = require('request')
urls = require('../../../config/url.json')
appConfig = require('../../../app_config')

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define 'User',
    email:
     type: DataTypes.STRING
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    staff_num:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
    password:
      type: DataTypes.STRING(32)
      allowNull: false
    # 表示员工类型,1表示正式员工;2表示实习生;3表示兼职
    type:
      type: DataTypes.INTEGER(6)
      allowNull: false
      defaultValue: 1
    avatar_qiniu_hash:
      type: DataTypes.STRING(64)
    name:
      type: DataTypes.STRING(10)
    phone:
      type: DataTypes.STRING(11)
    active:
      type: DataTypes.BOOLEAN
      allowNull: false
      defaultValue: false
    # 密码是否修改过, 创建帐号的时候默认密码必须要修改
    password_edited:
      type: DataTypes.BOOLEAN
      allowNull: false
      defaultValue: false
    is_leader:
      type: DataTypes.BOOLEAN
      allowNull: true
      defaultValue: false
    # 0是女，1是男
    sex:
      type: DataTypes.BOOLEAN
      allowNull: true
      defaultValue: false
    # 权限配置系统对应的用户id
    auth_id:
      type: DataTypes.INTEGER(11).UNSIGNED
  ,
    tableName: 'user'
    classMethods:
      associate: () ->
        this.hasMany(sequelize.model('DailyReport'), {
          as: {
            singular: 'dailyReport'
            plural: 'dailyReports'
          }
        })
        this.hasMany(sequelize.model('Token'), {
          as: {
            singular: 'token'
            plural: 'tokens'
          }
        })
        this.belongsTo(sequelize.model('Role'), {
          as: 'role'
        })
        this.belongsToMany(sequelize.model('DepartmentStructure'), {
          as: 'empireDepartment'
          through: 'user_in_department'
        })

      # 是否是管理员
      isAdmin: (roleId) ->
        deferred = Q.defer()
        this.sequelize.model 'Role'
        .find(roleId).then (role) ->
          if role.getDataValue('name') is 'admin'
            deferred.resolve true
          else
            deferred.reject false

        return deferred.promise

      # 获取所有账号
      getAll: (opts) ->
        deferred = Q.defer()

        where = {}
        self = this
        modelDepartment = {
          model: sequelize.model('DepartmentStructure')
          as: 'empireDepartment'
          attributes: ['id', 'name', 'parent']
        }

        if opts.name
          where.name =
            like: "%#{opts.name}%"
        if opts.authId
          where.auth_id =
            in: [opts.authId]
        if opts.authIds
          where.auth_id =
            in: opts.authIds

        async.series([(callback) ->
          if opts.departmentId?
            modelDepartment.where =
              id: opts.departmentId

          callback(null)
        , (callback) ->
          self.findAll({
            order: 'update_time DESC'
            where: where
            attributes: ['id', 'staff_num', 'type', 'name', 'avatar_qiniu_hash', 'phone', 'active', 'is_leader', 'auth_id', 'update_time']
            include: [modelDepartment]
          }).then (users) ->
            console.log where
            if parseInt(opts.departmentId) is 0
              users = _.where(users, {
                empireDepartment: []
              })
            deferred.resolve(users)
            callback(null)
        ])

        deferred.promise

      # 修改账号
      updateOne: (id, values, headers) ->
        deferred = Q.defer()
        debug 'values.type is: '
        debug values.type
        if values.role?
          _role = values.role
          values.role = null

        that = this
        updatedUser = this.update(values, {
          where:
            id: id
        })
        updatedUser.then (user) ->
          debug 'id is: '
          debug id
          that.find(id).then (user) ->
            debug 'user is: '
            debug user
            request.patch(urls[appConfig.get('env')].authority + '/cloud/auth/user/' + user.getDataValue('auth_id'), {
              body:
                role_set: _role
              json: true
              headers:
                Authorization: 'token ' + headers.authorization.split(' ')[1]
            }, (err, response, body) ->
              if err
                deferred.reject(err)
              else
                deferred.resolve(user)
            )

        return deferred.promise

      # 自动补全staffNum, 假如工号小于4位, 那么自动在前面补全成四位
      autoFillStaffNum: (staffNum) ->
        staffNumStr = staffNum.toString()
        if /\d+/.test staffNumStr
          while staffNumStr.length < 4
            staffNumStr = '0' + staffNumStr
        else
          staffNumStr = ''
        return staffNumStr

      getStaffByLogin: (staff_num, password, roleName) ->
        includeRoleOption = {
          model: sequelize.model('Role')
          as: 'role'
          required: false
          attributes: ['name', 'id']
          include: {
            model: sequelize.model('Authority')
            as: 'authorities'
            attributes: ['name']
          }
        }

        if roleName isnt "*"
          includeRoleOption.where = {
            name: roleName
          }

        return this.find({
          where:
            staff_num: staff_num
            password: password
          include: [
            # includeRoleOption,
            {
              model: sequelize.model('DepartmentStructure')
              as: 'empireDepartment'
              attributes: ['id', 'name']
            }
          ]
          attributes: ['id', 'staff_num', 'type', 'avatar_qiniu_hash', 'name', 'phone', 'active', 'role_id', 'password_edited', 'is_leader', 'auth_id']
        })

      # 获取新用户的staff_num
      getStaffNum: (type) ->
        deferred = Q.defer()
        this.max('staff_num').then (staffNumMax) ->
          if isNaN(staffNumMax)
            staffNumMax = 1
          else
            staffNumMax++
          deferred.resolve staffNumMax
        , (err) ->
          deferred.reject err
        return deferred.promise

      getUserFromToken: (authorization, isUserRaw) ->
        deferred = Q.defer()
        findUserOption = {
          raw: isUserRaw
        }
        debug 'token is: '
        debug authorization.split(' ')[1]
        request.get(urls[appConfig.get('env')].authority + '/cloud/apps/883/user/tokens?token=' + authorization.split(' ')[1], {
          headers:
            Authorization: 'token ' + authorization.split(' ')[1]
        }, (err, response, body) ->
          if err?
            deferred.reject err
          else
            debug 'body is: '
            debug body
            body = JSON.parse(body)
            debug 'body is: '
            debug body
            user_id = body.user_id
            User.find({
              where:
                auth_id: user_id
            }, findUserOption).then (user) ->
              debug "user is: "
              debug user
              deferred.resolve(user)
            , (err) ->
              deferred.reject(err)
        )
        return deferred.promise
      updateUsersFromExcel: () ->
        self = this
        deferred = Q.defer()
        file = path.join(__dirname,'..', '..', '..', 'users.xlsx')
        sheets = xlsx.parse(file)

        # 表格每一列代表的键值
        cols = ['staff_num', 'name', 'phone']

        users = []
        for row, rowIndex in sheets[0].data
          debug 'row is: '
          debug row
          staffNum = row[0]

          (() ->
            phone = row[2]
            self.find({
              where:
                staff_num: staffNum
            }).then (user) ->
              debug phone
              user.phone = phone
              user.save({
                fileds: ['phone']
              }).then () ->
          )()


      insertUsersFromExcel: () ->
        deferred = Q.defer()
        file = path.join(__dirname,'..', '..', '..', 'users.xlsx')

        sheets = xlsx.parse(file)
        debug 'excels sheets[0].data is: '
        debug sheets[0].data

        # sheet表对应的type值
        sheetUserTypes = [1, 2, 3]

        # 表格每一列代表的键值
        cols = ['staff_num', 'name', {
          name: 'active'
          func: (value) ->
            debug 'value is:'
            debug value
            if value is '在职'
              return true
            else
              return false
        }, 'type']

        users = []

        for sheet, sheetIndex in sheets
          for row, rowIndex in sheet.data
            if rowIndex > 0
              user = {}
              for col, colIndex in row
                if typeof cols[colIndex] is 'string'
                  if typeof col is 'string'
                    user[cols[colIndex]] = col.trim()
                  else
                    user[cols[colIndex]] = col
                else
                  user[cols[colIndex].name] = cols[colIndex].func(col)
              user.password = md5('111111')
              users.push(user)

        debug 'generated users is: '
        debug users

        this.bulkCreate(users).then (users) ->
          deferred.resolve(users)
        , (err) ->
          deferred.reject(err)

        deferred.promise

