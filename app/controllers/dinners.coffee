mongoose = require 'mongoose'
_ = require 'underscore'

Eda = mongoose.model 'Eda'

#
# menu
#
exports.menu = (req, res) ->
  console.log "menu"
  Eda.list (err, edas) ->
    res.render 'dinner/index',
      edas: edas
      message: req.flash 'notice'
    return

#
# add
#
exports.add = (req, res) ->
  eda = new Eda req.body

  eda.save (err) ->
    unless err
      res.redirect '/menu'
      console.log "success save eda"
    else
      console.log 'Err add on save', err
      res.render 'dinner/index',
        errors: err.errors
        eda: eda
        message: err.message
