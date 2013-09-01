(require 'source-map-support').install
  handleUncaughtExceptions: false

path = require 'path'

stylus = require 'stylus'
nib = require 'nib'

module.exports = new class Index

  type: 'style'
  name: 'stylus'
  output: 'css'

  ext: /\.styl$/m
  exts: ['.styl']

  partials: on
  is_partial:(filepath)-> /^_/m.test path.basename filepath

  compile:( filepath, source, debug, error, done )->
    stylus( source )
    .set( 'filename', filepath )
    .use( nib() )
    .render (err, css)->
      if err?
        error err
      else
        done css, null

  resolve_dependents:(file, files)->
    dependents = []
    has_import_calls = /^\s*(?!\/\/)@import\s/m

    for each in files

      continue if not has_import_calls.test each.raw

      dirpath = path.dirname each.filepath
      name = path.basename each.filepath
      match_all = /^\s*(?!\/\/)@import\s+(?:"|')(\S+)(?:"|')/mg
      
      while (match = match_all.exec each.raw)?

        short_id = match[1]
        short_id += '.styl' if '' is path.extname short_id

        full_id = path.join dirpath, short_id

        if full_id is file.filepath
          if not @is_partial name
            dependents.push each
          else
            dependents = dependents.concat @resolve_dependents each, files

    dependents