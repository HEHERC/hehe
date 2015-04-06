express = require 'express'
router = express.Router()
models = require('../../models/index')
utils = require('../../lib/utils')
debug = require('debug')('routes:authority')

router.post '/authority', (req, res) ->
	name = req.body.name
	models.atomEmpireAuthority.create({
		name: name
	}).then (authority) ->
		res.json(authority)
	, (err) ->
		debug err
		res.status(500).send('服务器错误')

module.exports = router
