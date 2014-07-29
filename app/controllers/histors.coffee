mongoose = require 'mongoose'
_ = require 'underscore'

Histor = mongoose.model 'Histor'

#
# List histor
#
exports.index = (req, res) ->
  console.log "List histor"
  Histor.list (err, orders) ->
    res.render 'histor/index',
      #histors: histors
      message: req.flash 'notice'
    return

#
# add histor
#

exports.add = (req, res) ->
  console.log(req.body)
  username = req.body.username
  dish = req.body.dish
  quantity = req.body.quantity
  price = req.body.price
  total = req.body.total
  #date = dateShortMon(new  Date())
  date = new Date()
  day = date.getDate()
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
  month = m[date.getMonth()]
  year = date.getFullYear()
  console.log('Param: ', username,' | ', dish,' | ', quantity,' | ', price,' | ', total,' | ', date)
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
      res.redirect '/histor'
      console.log "success save histor"
    else
      console.log 'Err add on save', err
      res.render 'histor/index',
        errors: err.errors
        #histors: histors
        message: err.message
  return