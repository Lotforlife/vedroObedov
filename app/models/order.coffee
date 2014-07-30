mongoose = require 'mongoose'
#moment = require 'moment'

bcrypt = require 'bcrypt'

Schema = mongoose.Schema

#
# Order schema
#
OrderSchema = new Schema
  username:
    type: String
  dish:
    type: Array
    required: true
  quantity:
    type: Array
    required: true
  time:
    type: Array
  typ:
    type: Array

OrderSchema.statics =
  list: (cb) ->
    this.find()
    .exec(cb)
    return

Order = mongoose.model 'Order', OrderSchema