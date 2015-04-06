debug = require('debug')('routes:role')
express = require 'express'
router = express.Router()
models = require('../../models/index')

router.post '/role', (req, res) ->
  models.atomEmpireRole.create(req.body).then (role) ->
    res.json(role)
  , (err) ->
    res.status(500).json(err)

router.get '/role', (req, res) ->
	models.atomEmpireRole.findAll({
		attributes: ['id', 'name', 'desc']
	}).then (roles) ->
		res.json(roles)
	, (err) ->
		res.status(500).json(err)

router.post '/role/:roleId/authority/:authorityId', (req, res) ->
	roleId = req.params.roleId
	models.atomEmpireRole.find(roleId).then (role) ->
		debug 'atomEmpireRole has function called addAuthorities: '
		debug role.addAuthorities
		models.atomEmpireAuthority.find(authorityId).then (authority) ->
			role.addAuthority(authority).then () ->
				res.status(200)
			, () ->
				res.status(500)


module.exports = router
