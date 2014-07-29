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
#  table = req.body.table
  username = req.user.name + ' ' + req.user.name
  dish = req.body.dish
  quantity = req.body.quantity
  time = new Date()

  order = new Order
#    table: table
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
    console.log('Time: ',order.time)
  return

#
# Display new order form
#
exports.new = (req, res) ->
  res.render 'order/new',
    order: new Order({})
    message: ''
  return
