mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

#
# User Schema
#
Schema = mongoose.Schema

UserSchema = new Schema
  photo:
    type: String
    required: false
  name:
    type: String
    required: true
  lastName:
    type: String
    required: false
  birth:
    type: String
    required: false
  social:
    type: String
    required: false
  email:
    type: String
    required: true
  username:
    type: String
    required: true
    unique: true
  password:
    type: String
    required: true
  created:
    type: Date
    default: Date.now

UserSchema.path('email').validate (value) ->
  return /^[a-zA-Z0-9_\-\.]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-\.]+$/.test(value)
  'Invalid email'

#
# Hash password before saving
#
UserSchema.pre 'save', (next) ->
  user = this
  SALT_WORK_FACTOR = 10

  if !user.isModified 'password'
    console.log 'Password not modified'
    return next()

  return next() unless user.isModified 'password'

  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
    return next err if err
    bcrypt.hash user.password, salt, (err, hash) ->
      return next err if err
      user.password = hash
      next()
      return

    return

#
# Compare password method for authentication
#
UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, this.password, (err, isMatch) ->
    if err
      return cb err
    cb(null, isMatch)

UserSchema.statics =
  list: (cb) ->
    this.find().sort
      username: 1
    .exec(cb)
    return

#
# Eda schema
#
EdaSchema = new Schema
  name:
    type: String
    required: true
  money:
    type: String
    required: true
  number:
    type: String
    required: true

#EdaSchema.statics =
#  list: (cb) ->
#    this.find()
#    .exec(cb)
#    return

User = mongoose.model 'User', UserSchema
Eda = mongoose.model 'Eda', EdaSchema