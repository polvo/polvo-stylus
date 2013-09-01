path = require 'path'
fs = require 'fs'
fsu = require 'fs-util'

should = require('chai').should()
stylus = require '../../'

fixtures = path.join __dirname, '..', 'fixtures'

paths = 
  base: path.join fixtures, 'base.styl'
  _a: path.join fixtures, '_a.styl'
  _d: path.join fixtures, 'sub', '_d.styl'

contents = 
  base: fs.readFileSync(paths.base).toString()
  _d: fs.readFileSync(paths._d).toString()

describe '[polvo-stylus]', ->

  backup = []
  before ->
    for file in fsu.find fixtures, /.+/
      backup.push path: file, raw: fs.readFileSync(file).toString()

  after ->
    for file in backup
      fs.writeFileSync file.path, file.raw

  it 'should rise error and return empty string when stylus returns an error', ->
    count =  err: 0, out: 0
    error =(msg)->
      count.err++
      /failed to locate @import .+non\/existent\.styl/.test(msg).should.be.true
    done =( compiled )->
      count.out++
      compiled.should.equal ''

    stylus.compile paths.base, contents.base, false, error, done
    count.out.should.equal 1
    count.err.should.equal 1

  it 'should compile file without any surprise - release mode', ->
    @timeout 5000
    count =  err: 0, out: 0
    error = (msg)-> count.err++
    done = ( compiled )->
      count.out++
      sample = """.a {
        font-family: 'a';
      }
      .b {
        font-family: 'b';
      }
      .d {
        font-family: 'd';
      }
      .c {
        font-family: 'c';
      }
      .base {
        font-family: 'base';
      }

      """

      compiled.should.equal sample

    # remove inexistent import
    broken = fs.readFileSync(paths._a).toString()
    fixed = broken.replace '@import "sub/non/existent"', ''
    fs.writeFileSync paths._a, fixed

    stylus.compile paths.base, contents.base, false, error, done
    count.out.should.equal 1
    count.err.should.equal 0

  it 'should compile file without any surprise - dev mode', ->
    @timeout 5000
    count =  err: 0, out: 0
    error = (msg)-> count.err++
    done = ( compiled )->
      count.out++
      compiled.match(/\/\* line [0-9]+ : /g).length.should.be.above 25

    # remove inexistent import
    broken = fs.readFileSync(paths._a).toString()
    fixed = broken.replace '@import "sub/non/existent"', ''
    fs.writeFileSync paths._a, fixed

    stylus.compile paths.base, contents.base, true, error, done
    count.out.should.equal 1
    count.err.should.equal 0

  it 'should return all file dependents, independently on how nested it is', ->
    list = []
    for file in fsu.find fixtures, /\.styl$/m
      list.push filepath:file, raw: fs.readFileSync(file).toString()

    dependents = stylus.resolve_dependents paths._d, list
    dependents.length.should.equal 1
    dependents[0].filepath.should.equal paths.base