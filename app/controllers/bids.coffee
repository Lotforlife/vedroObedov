mongoose = require 'mongoose'
_ = require 'underscore'

Bid = mongoose.model 'Bid'
Bidd = mongoose.model 'Bidd'

exports.index = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/index',
      bids: bids
  return

exports.manage = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/manage',
      bids: bids
      message: req.flash 'error'
    return

exports.open = (req, res) ->
  res.render 'bids/open',
    bid: new Bid({})
  return

exports.new = (req,res) ->
 console.log('KA BOOM')
 bid = new Bid req.body
 bid.users = req.user.name
 bid.username = req.user.username
 bid.save (err) ->
    if err
      res.render 'bids/index',
        errors: err.errors
        bid: bid
    res.redirect '/bids'
    return
  return

exports.bid = (req, res, next, id) ->
  Bid.findById(id).exec (err, bid) ->
    return next err if err
    return next new Error 'Failed to load bid' if not bid
      
    req.bid = bid
    next()
    return
  return

exports.edit = (req, res) ->
  bid = req.bid
  res.render 'bids/edit',
    bid:bid
  return

exports.work = (req, res) ->
  bid = req.bid
  bid = _.extend bid, req.body
  bid.status = "В работе"
  bid.save (err) ->
    if err
      res.render 'bids/edit',
        bid:bid
        errors: err.errors
    else
      res.redirect '/bids'
    return
  return

exports.destroy = (req, res) ->
  if req.body.delform == ""
   req.flash 'error', 'Поле комментария обязательно к заполнению!'
   res.redirect '/bids'
#  bid = req.bid
#  bid.remove (err) ->
#    res.redirect '/bids'
   return
  else
   bid = req.bid
   bidd = new Bidd({
    status: "Удалена юзером"
    users: req.bid.users
    body: req.bid.body
    title: req.bid.title
    createdAt: req.bid.createdAt
    username: req.bid.username
    comment: req.body.delform
   })
   bidd.save (err) ->
    if err
      res.redirect '/logout',
        bidd:bidd
        errors: err.errors
    else
      res.redirect '/bids'
   , bid.remove (err) ->
    res.redirect '/bids'
   res.redirect '/bids'
   return

exports.del = (req,res) ->
  Bidd.list (err, bidds) ->
    res.render 'bids/del',
      bidds: bidds
    return

exports.close = (req,res) ->
   bid = req.bid
   bidd = new Bidd({
    status: "Закрыта"
    users: req.bid.users
    body: req.bid.body
    title: req.bid.title
    createdAt: req.bid.createdAt
    username: req.bid.username
    comment: "Complete"
   })
   bidd.save (err) ->
    if err
      res.redirect '/logout',
        bidd:bidd
        errors: err.errors
    else
      res.redirect '/bids'
   , bid.remove (err) ->
    res.redirect '/bids'
   res.redirect '/bids'
   return

exports.closed = (req,res) ->
  Bidd.list (err, bidds) ->
    res.render 'bids/closed',
      bidds: bidds
    return

exports.worked = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/worked',
      bids: bids
      message: req.flash 'error'
    return

exports.wait = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/waiting',
      bids: bids
      message: req.flash 'error'
    return