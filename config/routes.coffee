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
# Bids routes
  bids = require '../app/controllers/bids'
  app.get '/bids', auth.requiresLogin, bids.manage
  app.get '/bids/open', auth.requiresLogin, bids.open
  app.post '/bids', bids.new
  app.get '/bids/:bidId/edit', auth.requiresLogin, bids.edit
  app.post '/bids/edit', bids.work
  app.put '/bids/:bidId', auth.requiresLogin, bids.work
  app.get '/bids/:bidId/destroy', auth.requiresLogin, bids.destroy

  app.param 'bidId', bids.bid
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
  app.get '/', articles.index                           #main page. do not delete
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

  app.get '/menu', auth.requiresLogin, dinners.menu
  app.post '/menu', auth.requiresLogin, dinners.add
  app.get '/delEda/:edaId/del', auth.requiresLogin, dinners.delEda

  app.param 'edaId', dinners.findId

  app.post '/order', dinners.order


  # Order routes

  orders = require '../app/controllers/orders'
  app.get '/order', auth.requiresLogin, orders.index
  app.post '/order/new', auth.requiresLogin, orders.add
  app.get '/order/new', auth.requiresLogin, orders.new

  # Histor routes

  histors = require '../app/controllers/histors'
  app.get '/histor', auth.requiresLogin, histors.index

  return