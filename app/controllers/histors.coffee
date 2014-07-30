mongoose = require 'mongoose'
_ = require 'underscore'

Histor = mongoose.model 'Histor'

#
# List histor
#
exports.index = (req, res) ->
  console.log "List histor"
  Histor.list (err, histors) ->
    res.render 'histor/index',
      histors: histors
      message: req.flash 'notice'
    return

#
# add histor
#

exports.add = (req, res) ->
  console.log(req.body)
  username = req.user.username
  dish = req.body.title
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
      #res.redirect '/histor'
      console.log "success save histor"
    else
      console.log 'Err add on save', err
      res.render 'histor/index',
        errors: err.errors
        histors: histors
        message: err.message
  return

exports.jan = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/jan',
      histors: histors
    return
exports.feb = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/feb',
      histors: histors
    return
exports.mar = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/mar',
      histors: histors
    return
exports.apr = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/apr',
      histors: histors
    return
exports.may = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/may',
      histors: histors
    return
exports.jun = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/jun',
      histors: histors
    return
exports.jul = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/jul',
      histors: histors
    return
exports.aug = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/aug',
      histors: histors
    return
exports.sen = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/sen',
      histors: histors
    return
exports.oct = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/oct',
      histors: histors
    return
exports.nov = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/nov',
      histors: histors
    return
exports.dec = (req, res) ->
  Histor.list (err, histors) ->
    res.render 'histor/dec',
      histors: histors
    return