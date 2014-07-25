#
# Module dependencies
#
mongoose = require 'mongoose'
_ = require 'underscore'

User = mongoose.model 'User'
_noPhoto = 'http://rastaman.mmk-spb.ru/img/unknown_user.png'

#
# Show login form
#
exports.login = (req, res) ->

  res.render 'users/login',
    title: 'Login'
    message: req.flash 'error'
  return

#
# Logout
#
exports.logout = (req, res) ->
  req.logout()
  res.redirect '/'
  return

#
# List users
#
exports.index = (req, res) ->
  User.list (err, users) ->
    res.render 'users/index',
      users: users
      message: req.flash 'notice'
    return

#
# Display new user form
#
exports.new = (req, res) ->
  res.render 'users/new',
    user: new User({})
    message: ''
  return

#
# Create user
#
exports.create = (req, res) ->
  user = new User req.body

  user.save (err) ->
    unless err
      res.redirect '/login'
    else
      console.log 'Err on save', err
      res.render 'users/new',
        errors: err.errors
        user: user
        message: err.message

#
# Find user by id
#
exports.user = (req, res, next, id) ->
  User.findById(id).exec (err, user) ->
    return next err if err
    return next new Error 'Failed to load user' if not user
        
    req.profile = user
    next()
    return
  return

#
# Show edit form for users
#
exports.edit = (req, res) ->
  console.log('profile edit ', req.profile)

  res.render 'users/edit',
    user: req.profile
    message: ''
  return

#
# Update user
#
exports.update = (req, res) ->
  user = req.profile

  console.log('profile update ', req.profile)

  user.name = req.body.name
  user.lastName = req.body.lastName
  user.birth = req.body.birth
  user.username = req.body.username
  user.email = req.body.email

  user.password = req.body.password if req.body.password
  
  user.save (err) ->
    if err
      console.log err
      
      res.render 'users/edit',
        user: user
        errors: err.errors
    else
      req.flash 'notice', 'User was successfully updated'
      res.redirect '/users'
    return
  return

#
# Delete user
#
exports.destroy = (req, res) ->
  user = req.profile
  
  user.remove (err) ->
    req.flash 'notice', 'User ' + user.name + ' was successfully deleted.'
    res.redirect '/users'
  return

#
# vk
#
exports.vk = (req, res) ->

  social = req.user.social
  name = req.user.name
  lastName = req.user.lastName
  email = "vkont@kte.com"

  username = req.user.username
  if username is undefined
    username = req.user.name
  password = "admin"
  photo = req.user.photo
  if photo is undefined
    photo = _noPhoto

  User.where(social: social).exec (err, results) ->
    if !err

      if (results.length != 0)
        console.log "we have this user"

      if (results.length == 0)
        user = new User({
          name: name
          lastName: lastName
          birth: 'none'
          social: social
          email: email
          username: username
          password: password
          photo: photo
        })
        user.save (err, res) ->
          if !err
            console.log "create new user VK"
      res.redirect "/"
    else console.log "save in db error"

#
# fb
#
exports.fb = (req, res) ->

  social = req.user.social
  name = req.user.name
  lastName = req.user.lastName
  email = "f@cebook.com"

  username = req.user.username
  if username is undefined
    username = req.user.name

  birth = "none"
  password = "admin"
  photo = req.user.photo
  if photo is undefined
    photo = _noPhoto

  User.where(social: social).exec (err, results) ->
    if !err

      if (results.length != 0)
        console.log "we have this user"

      if (results.length == 0)
        user = new User({
          name: name
          lastName: lastName
          birth: birth
          social: social
          email: email
          username: username
          password: password
          photo: photo
        })
        user.save (err, res) ->
          if !err
            console.log "create new user FB"
      res.redirect "/"
    else console.log "save in db error"

#
#  google
#
exports.google = (req, res) ->

  email = req.user.email
  name = req.user.name
  lastName = req.user.lastName
  username = req.user.username
  if username is undefined
    username = req.user.email
  password = "admin"
  photo = _noPhoto

  User.where(email: email).exec (err, results) ->
    if !err

      if (results.length != 0)
        console.log "we have this user"

      if (results.length == 0)
        user = new User({
          name: name
          lastName: lastName
          birth: 'none'
          social: 'none'
          email: email
          username: username
          password: password
          photo: photo
        })
        user.save (err) ->
          if !err
            console.log "create new user Google"
      res.redirect "/"
    else console.log "save in db error"