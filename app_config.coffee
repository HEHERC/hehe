express = require('express')
app = express()

# config
app.set('port', process.env.PORT || 3000)
app.set('env', process.env.NODE_ENV || 'development')

module.exports = app
