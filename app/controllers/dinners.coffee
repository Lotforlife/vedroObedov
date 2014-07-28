mongoose = require 'mongoose'
_ = require 'underscore'

Eda = mongoose.model 'Eda'

#
# menu
#
exports.menu = (req, res) ->
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
      console.log "success add in db:", eda.title
    else
      console.log 'Err add on save', err
      res.render 'dinner/index',
        errors: err.errors
        eda: eda
        message: err.message

#
# order
#
exports.order = (req, res) ->
  res.redirect '/menu'
  console.log "dinners. order", req.body
  console.log "dinners. order", req.user

#
# delEda
#
exports.delEda = (req, res) ->
  eda = req.profile

  eda.remove (err) ->
    req.flash 'notice', 'User ' + eda.title + ' was successfully deleted.'
    res.redirect '/menu'
  return


exports.findId = (req, res, next, id) ->
  Eda.findById(id).exec (err, eda) ->
    return next err if err
    return next new Error 'Failed to load user' if not eda

    req.profile = eda
    next()
    return
  return

