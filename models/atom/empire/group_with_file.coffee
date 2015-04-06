debug = require('debug')('models:GroupWithFile')
Q=require ('q')
module.exports = (sequelize, DataTypes) ->
  GroupWithFile = sequelize.define 'GroupWithFile',
    id:
      type: DataTypes.INTEGER(11).UNSIGNED
      allowNull: false
      autoIncrement: true
      primaryKey: true
    group_id:
      type: DataTypes.INTEGER(11)
      allowNull: true
    document_id:
      type: DataTypes.INTEGER(11)
      allowNull: false
  ,
    tableName: 'group_with_file'
    classMethods:
      #得到对应的groupId所在的document流程文档
      getDocumentByGroups: (groupId) ->
        debug 'groupIds is :'
        debug groupId
        deferred = Q.defer()
        @.findAll({
          where:
            group_id:groupId
          attributes:['document_id']
        }).then (results) ->
          deferred.resolve results
        deferred.promise
      #得到没有对应组的流程文档，相当与公共文档
      getPublicDocument: () ->
        debug 'export all groupId is NULL Document'
        deferred = Q.defer()
        @.findAll({
          where:
            group_id:null
          attributes:['document_id']
        }).then (results) ->
          debug results
          deferred.resolve results
        deferred.promise



