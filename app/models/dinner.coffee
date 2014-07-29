mongoose = require 'mongoose'
bcrypt = require 'bcrypt'
Schema = mongoose.Schema

#
# Eda schema
#
EdaSchema = new Schema
  title:
    type: String
    required: true
  money:
    type: String
    required: true
  type:
    type: String
    required: true

EdaSchema.statics =
  list: (cb) ->
    this.find().sort
      type: 1
    .exec(cb)
    return

Eda = mongoose.model 'Eda', EdaSchema