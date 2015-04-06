fs = require 'fs'
nodemon = require 'nodemon'
nodemon(
  script: 'app.coffee'
  stdout: false).on 'readable', ->
  @stdout.pipe fs.createWriteStream('output.txt')
  @stderr.pipe fs.createWriteStream('err.txt')
  return
