(require 'source-map-support').install
  handleUncaughtExceptions: false

nib = require 'nib'
stylus = require 'stylus'

module.exports = new class Index

  polvo: true

  type: 'css'
  name: 'stylus'
  ext: /\.styl$/m
  exts: ['.styl']

  compile:( filepath, source, debug, done )->
    stylus( source )
    .set( 'filename', filepath )
    .use( nib() )
    .render (err, css)->
      throw err if err?
      done css, null