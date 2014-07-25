
###
Form5 Node.js Express Skeleton
Based on https://github.com/madhums/nodejs-express-mongoose-demo
###
express = require("express")
http = require("http")
fs = require("fs")
passport = require("passport")
mongoose = require("mongoose")
coffee = require("coffee-script")
less = require("less")
# assets = require("connect-assets")
env = process.env.NODE_ENV or "development"
config = require("./config/environment")[env]
auth = require("./config/middlewares/authorization")

# Bootstrap database
mongoose.connect('mongodb://localhost/skeleton');
db = mongoose.connection

db.once "open", callback = ->
  console.log "Connected to DB!"
  return

db.on "error", (err) ->
  console.error "connection error:", err.message
  return

# Bootstrap models
models_path = __dirname + "/app/models"
fs.readdirSync(models_path).forEach (file) ->
  require models_path + "/" + file
  return

# bootstrap passport config
require("./config/passport") passport, config
app = express()

# express settings
require("./config/express") app, config, passport

# Bootstrap routes
require("./config/routes") app, passport, auth

# Helper funtions
require("./app/helpers/general") app

app.use require("connect-assets")
	helperContext: app.locals

# Start the app by listening on <port>
port = process.env.PORT or 3000
http.createServer(app).listen port, ->
  console.log "Form5 Express app running on port " + port
  return