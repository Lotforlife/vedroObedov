mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

Schema = mongoose.Schema

BidSchema = new Schema
  status:
    type: String
    required: false
  users:
    type: String
    required: true
  title:
    type: String
    required: true
  createdAt:
    type: Date
    default: Date.now

BidSchema.statics =
  list: (cb) ->
    this.find().sort
      createdAt: -1
    .exec(cb)
    return

Bid = mongoose.model 'Bid', BidSchema

bid = new Bid
  users: 'Serega'
  title: 'NU TAKOE'
bid.save (err) ->
  if err
    console.log err
  else
    console.log 'Created bid'