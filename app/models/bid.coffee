mongoose = require 'mongoose'
bcrypt = require 'bcrypt'
Schema = mongoose.Schema

BidSchema = new Schema
  status:
    type: String
    required: false
    default: "В ожидании"
  users:
    type: String
    required: true
    default: " "
  body:
    type: String
    required: true
    default: " "
  title:
    type: String
    required: true
    default: " "
  createdAt:
    type: Date
    default: Date.now
  username:
    type: String
    required: false
    default: " "

BidSchema.statics =
  list: (cb) ->
    this.find().sort
      createdAt: -1
    .exec(cb)
    return

Bid = mongoose.model 'Bid', BidSchema

BiddSchema = new Schema
  status:
    type: String
    required: false
    default: " "
  users:
    type: String
    required: true
    default: " "
  body:
    type: String
    required: true
    default: " "
  title:
    type: String
    required: true
    default: " "
  createdAt:
    type: Date
    default: Date.now
  closedAt:
    type: Date
    default: Date.now
  username:
    type: String
    required: false
    default: " "
  comment:
    type: String
    required: true

BiddSchema.statics =
  list: (cb) ->
    this.find().sort
      createdAt: -1
    .exec(cb)
    return

Bidd = mongoose.model 'Bidd', BiddSchema
###
bid = new Bid
  users: 'Stepa'
  title: 'NU TAKOE'
bid.save (err) ->
  if err
    console.log err
  else
    console.log 'Created bid'
###