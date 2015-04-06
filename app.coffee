debug = require('debug')('atomNodeAPI')
path = require('path')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
app = require('./app_config')

routers = require('./routes/')

# 判断线上加入监控
if app.get('env') is 'production'
  require('newrelic')

app.use(logger('combined'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({
  extended: false
}))
app.use(cookieParser())

# 解决跨域问题
app.all '*', (req, res, next) ->
  res.set
   'Access-Control-Allow-Origin': '*'
   'Access-Control-Allow-Headers': 'X-Requested-With,Accept,Content-Type, Origin, Authorization'
   'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE'
   'Access-Control-Expose-Headers': 'X-Resource-Count'
  next()

# routers
# @think Only use '/' can it enter the shops router?
# @params routers 所有路由对象
app.use.apply(app, routers)

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)

# error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status(err.status || 500)
    console.log err.stack
    res.send({
      message: err.message,
      error: err
    })

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status(err.status || 500)
  res.send({
    message: err.message,
    error: {}
  })

server = app.listen app.get('port'), () ->
  debug('Express server listening on port ' + server.address().port)

module.exports = app
