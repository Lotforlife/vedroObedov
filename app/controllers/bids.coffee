mongoose = require 'mongoose'
_ = require 'underscore'

Bid = mongoose.model 'Bid'


exports.index = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/index',
      bids: bids
  return

exports.manage = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/manage',
      bids: bids
      message: req.flash 'notice'
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
  bid = req.bid
  bid.remove (err) ->
    res.redirect '/bids'