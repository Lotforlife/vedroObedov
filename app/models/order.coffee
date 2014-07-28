mongoose = require 'mongoose'
#moment = require 'moment'

bcrypt = require 'bcrypt'

Schema = mongoose.Schema

#
# Order schema
#
OrderSchema = new Schema
  table:
    type: Number
    required: true
  username:
    type: String
    required: true
    #default: user.username
  dish:
    type: Array
    required: true
  quantity:
    type: Number
    required: true
    #default: 1
  time:
    type: Date
    #required: true
    default: Date.now

OrderSchema.statics =
  list: (cb) ->
    this.find()
    .exec(cb)
    return

Order = mongoose.model 'Order', OrderSchema