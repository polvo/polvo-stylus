(require 'source-map-support').install
  handleUncaughtExceptions: false

path = require 'path'

stylus = require 'stylus'
nib = require 'nib'
clone = require 'regexp-clone'

module.exports = new class Index

  type: 'style'
  name: 'stylus'
  output: 'css'

  ext: /\.styl$/m
  exts: ['.styl']

  partials: on

  has_import = /^\s*(?!\/\/)@import\s/m
  match_all = /^\s*(?:(?!\/\/).?)@import\s+(?:"|')(\S+)(?:"|')/mg

  is_partial:( filepath )->
    /^_/m.test path.basename filepath

  compile:( filepath, source, debug, error, done )->
    stylus( source )
    .set( 'filename', filepath )
    .use( nib() )
    .import( 'nib' )
    .set('linenos', debug is true)
    .render (err, css)->
      if err?
        error err
        done ''
      else
        done css

  resolve_dependents:( filepath, files )->
    dependents = []

    for each in files
      [has, all] = [clone(has_import), clone(match_all)]
      continue if not has.test each.raw

      dirpath = path.dirname each.filepath
      name = path.basename each.filepath
      
      while (match = all.exec each.raw)?
        impor7 = match[1]
        impor7 = impor7.replace(@ext, '') + '.styl'
        impor7 = path.join dirpath, impor7

        if impor7 is filepath
          if not @is_partial name
            dependents.push each
          else
            sub = @resolve_dependents each.filepath, files
            dependents = dependents.concat sub

    dependents