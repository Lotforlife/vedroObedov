module.exports = (app, passport, auth) ->
  
  # User routes
  users = require '../app/controllers/users'

  app.get '/login', users.login

  app.post '/login', passport.authenticate('local',
    failureRedirect: '/login'
    failureFlash: true),

    (req, res) ->
      res.redirect '/'
      return

#
# vk
#
  app.get '/vk', passport.authenticate('vk',
    scope: ["friends"]
  ),(req, res) ->
    console.log "routes. vk auth success"
    return

  app.get "/vk/callback", passport.authenticate("vk",
    failureRedirect: "/login"
  ), (req, res) ->
    users.vk(req, res)                                #find in db
    return

#
# fb
#
  app.get '/fb', passport.authenticate('fb',
    scope: 'read_stream'),

  (req, res) ->
    console.log "routes. fb auth success"
    return

  app.get "/fb/callback", passport.authenticate("fb",
    failureRedirect: "/login"
  ), (req, res) ->
    users.fb(req, res)                                 #find in db
    return

#
# google
#
  app.get "/google", passport.authenticate ("google")

  (req, res) ->
    console.log "routes. google auth success"
    return

  app.get "/google/callback", passport.authenticate("google",
    failureRedirect: "/login"
  ), (req, res) ->
    users.google(req, res)                                 #find in db
    return
#
#
#

  app.get '/logout', users.logout

  app.get '/users', auth.requiresLogin, users.index
  app.get '/users/new', users.new

  app.post '/users', users.create
  app.get '/users/:userId/edit', auth.requiresLogin, users.edit
  app.put '/users/:userId', auth.requiresLogin, users.update
  app.get '/users/:userId/destroy', auth.requiresLogin, users.destroy

  app.param 'userId', users.user

  # Article routes
  articles = require '../app/controllers/articles'
  app.get '/', articles.index
  app.get '/articles', articles.manage
  app.get '/articles/new', auth.requiresLogin, articles.new
  app.get '/articles/:articleId', articles.show
  app.post '/articles', auth.requiresLogin, articles.create
  app.get '/articles/:articleId/edit', auth.requiresLogin, articles.edit
  app.put '/articles/:articleId', auth.requiresLogin, articles.update
  app.get '/articles/:articleId/destroy', auth.requiresLogin, articles.destroy

  app.param 'articleId', articles.article

  # Dinner routes

  dinners = require '../app/controllers/dinners'

  app.get '/menu', dinners.menu
  app.post '/menu', dinners.add


  # Order routes

  orders = require '../app/controllers/orders'
  app.get '/order', auth.requiresLogin, orders.index
  app.post '/order/new', auth.requiresLogin, orders.add
  app.get '/order/new', auth.requiresLogin, orders.new
  return