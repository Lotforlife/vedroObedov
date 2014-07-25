mongoose = require 'mongoose'
_ = require 'underscore'

Bid = mongoose.model 'Bid'


exports.index = (req, res) ->
  Bid.list (err, bids) ->
    res.render 'bids/index',
      bids: bids
  return