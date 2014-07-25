mongoose = require 'mongoose'
passport = require('passport')
User = mongoose.model('User')

LocalStrategy = require('passport-local').Strategy
VkStrategy = require('passport-vkontakte').Strategy
FbStrategy = require('passport-facebook').Strategy
GoogleStrategy = require('passport-google').Strategy

module.exports = (passport) ->

  # Serialize sessions
  passport.serializeUser (user, done) ->
    done(null, user)
  
  passport.deserializeUser (obj, done) ->
    done(null, obj)

  # Define the local auth strategy
  passport.use "local", new LocalStrategy (username, password, done) ->
    User.findOne username: username, (err, user) ->
      if err
        return done err
      if !user
        return done null, false, message: 'Unknown user'
      
      user.comparePassword password, (err, isMatch) ->
        if err
          return done err
        if isMatch
          return done null, user
        else
          return done null, false, message: 'Invalid password'
      
      return
    return

  #---------vk
  passport.use "vk", new VkStrategy(
    clientID: "4464850"
    clientSecret: "oywb6WtH8SRtgbl52yHq"
    callbackURL: "http://localhost:3000" + "/vk/callback"
  ,(accessToken, refreshToken, profile, done) ->

    done null,
      provider: profile.provider
      name: profile.name.givenName
      lastName: profile.name.familyName
      username: profile.username
      social: profile.profileUrl
      photo: profile.photos[0].value,
  )

  #---------fb
  passport.use "fb", new FbStrategy(
    clientID: "501554283311534"
    clientSecret: "7bedd8bb48765bd6fcceaefed4467911"
    callbackURL: "http://localhost:3000/fb/callback"
    profileFields: [
      'name',
      'displayName',
      'profileUrl',
      'photos'
    ]
  , (accessToken, refreshToken, profile, done) ->

    done null,
      provider: profile.provider
      name: profile.name.givenName
      lastName: profile.name.familyName
      social: profile.profileUrl
      photo: profile.photos[0].value
      username: profile.name.givenName,         #username = name
  )

  #-------google
  passport.use "google", new GoogleStrategy(
    returnURL: "http://localhost:3000/google/callback"
    realm: "http://localhost:3000"
  , (identifier, profile, done) ->
    openId: "33364711135"

    process.nextTick ->
      profile.identifier = identifier

    done null,
      provider: 'google'
      email: profile.emails[0].value.split(' ')
      name: profile.name.givenName
      lastName: profile.name.familyName
      username: profile.name.givenName              #username = name

    return
  )
#----------------

return