mongoose = require 'mongoose'
_ = require 'underscore'

Histor = mongoose.model 'Histor'
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
  console.log(req.body)
  username = req.user.name
  dish = req.body.title
  quantity = req.body.quantity
  price = req.body.money
  k = 0
  total = 0
  while k < req.body.money.length
    q = parseInt(req.body.money[k])
    total += q
    k++
  t = new Date()
  time = new Array()
  day = t.getDate()
  m = new Array(
    'Января'
    'Февраля'
    'Марта'
    'Апреля'
    'Мая'
    'Июня'
    'Июля'
    'Августа'
    'Сентября'
    'Октября'
    'Ноября'
    'Декабря'
  )
  month = m[t.getMonth()]
  year = t.getFullYear()
  ti = t.getHours() + ":" + t.getMinutes() + ":" + t.getSeconds()
  i = 0
  while i < dish.length
    time[i] = ti
    i++
  console.log('Param: ', username,' | ', dish,' | ', quantity,' | ', price,' | ', total,' | ', month)

  order = new Order
    username: username
    dish: dish
    quantity: quantity
    time: time

  histor = new Histor
    username: username
    dish: dish
    quantity: quantity
    price: price
    total: total
    day: day
    month: month
    year: year

  histor.save (err) ->
    unless err
      #res.redirect '/histor'
      console.log "success save histor"
    else
      console.log 'Err add on save', err
      res.render 'histor/index',
        errors: err.errors
        histor: histor
        message: err.message

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