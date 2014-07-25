module.exports =
  development:
    app:
      name: 'Vedro Obedov'
    root: require('path').normalize(__dirname + '/..')
    db: process.env.MONGOLAB_URI || process.env.MONGOHQ_URL \
        || 'mongodb://localhost/vedroObedov'