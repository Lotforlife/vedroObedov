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
    type: Array
    required: true
    default: 1
  price:
    type: Array
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
###
histor = new Histor({
  username: "admin"
  dish: ["BRUDA","EDA", "BORODA", "HOLODA"]
  quantity: [1, 1, 2, 1]
  price: [24, 46, 64, 11]
  total: 157
  day: 30
  month: "Декабрь"
  year: 2014
})
histor.save (err) ->
    if err
        console.log "NE OK"
        histor:histor
        errors: err.errors
    else
      console.log "OK"
    return
###