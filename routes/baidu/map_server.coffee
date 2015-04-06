express = require 'express'
router = express.Router()
url = require 'url'
querystring = require 'querystring'
http = require 'http'
# Q = require 'Q'

getInfo = (options, callback) ->
  # deferred = Q.defer()
  str = ''
  data = {}

  options.ak = 'EkWrRKGGyYTHavtTxGsFXy3p'
  options.output = 'json'
  options.query = '街道'

  urlStr = url.format({
    protocol: 'http'
    host: 'api.map.baidu.com'
    pathname: '/place/v2/search'
    search: querystring.stringify(options)
  })

  req = http.get urlStr, (res) ->
    res.on 'data', (chunk) ->
      str += chunk

    res.on 'end', () ->
      # deferred.resolve JSON.parse(str)
      return callback(JSON.parse(str))

  req.on 'error', (err) ->
    # deferred.reject err
    return err

  # deferred.promise

router.get '/baidu/map', (req, res, next) ->
  query = req.query

  if not query.longitude || not query.latitude
    res.send({
      message: 'not found'
      status: 404
    })
    return

  getInfo {
    location: "#{query.latitude},#{query.longitude}"
  }, (data) ->
    resData = {}
    resData.status = data.status
    resData.message = data.message
    resData.street = data.results[0]?.address
    resData.address = data.results[0]?.name
    res.send(resData)

module.exports = router
