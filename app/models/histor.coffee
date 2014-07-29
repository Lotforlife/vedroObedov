mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

Schema = mongoose.Schema

#
# Histor schema
#
HistorSchema = new Schema
  username:
    type: String
    required: true
  dish:
    type: Array
    required: true
  quantity:
    type: Number
    required: true
    default: 1
  price:
    type: Number
    required: true
  total:
    type: Number
    required: true
  day:
    type: Number
    required: true
  month:
    type: String
    required: true
  year:
    type: Number
    required: true



HistorSchema.statics =
  list: (cb) ->
    this.find()
    .exec(cb)
    return

Histor = mongoose.model 'Histor', HistorSchema