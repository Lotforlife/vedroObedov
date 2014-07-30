mongoose = require 'mongoose'
_ = require 'underscore'

Order = mongoose.model 'Order'

#
# List order
#
exports.index = (req, res) ->
  console.log "List order"
  Order.list (err, orders) ->
    res.render 'order/index',
      orders: orders
      message: req.flash 'notice'
    return

#
# add order
#
exports.add = (req, res) ->
  username = req.user.name
  #dish = req.body.dish
  dish = ['sup', 'salat', 'pelmeni']
  #quantity = req.body.quantity
  quantity = [ '1', '1', '1' ]
  t = new Date()
  time = new Array()
  ti = t.getHours() + ":" + t.getMinutes() + ":" + t.getSeconds()
  i = 0
  while i < dish.length
    time[i] = ti
    i++
  
  #console.log('Body ',req.body, 'Username: ', username, 'dish: ', dish, 'quantity: ', quantity, 'time: ', time )
  console.log(time)
  order = new Order
    username: username
    dish: dish
    quantity: quantity
    time: time

  order.save (err) ->
    unless err
      res.redirect '/order'
      console.log "success save order"
    else
      console.log 'Err add on save', err
      res.render 'order/index',
        errors: err.errors
        order: order
        message: err.message
  return

#
# Display new order form
#
exports.new = (req, res) ->
  res.render 'order/new',
    order: new Order({})
    message: ''
  return

#
# delete Order
#

exports.delete = (req, res) ->
  #console.log('Profile: ',req.profile)
  order = req.profile
  order.remove (err) ->
    req.flash 'notice', 'Order was successfully deleted.'
    res.redirect '/order'
  return

exports.findId = (req, res, next, id) ->
  Order.findById(id).exec (err, order) ->
    return next err if err
    return next new Error 'Failed to load user' if not order
    req.profile = order
    next()
    return
  return