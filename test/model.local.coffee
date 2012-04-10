should = require 'should'
sinon =  require 'sinon'
zombie = require 'zombie'

describe "Model.Local", ->
  $ = jQuery = undefined

  before (done) ->
    browser = new zombie.Browser()

    browser.visit("file://localhost#{__dirname}/index.html", ->
      global.document      ?= browser.document
      global.window        ?= browser.window
      global.window.jQuery ?= require('jQuery').create(window)
      global.localStorage  ?= browser.localStorage('test')

      global.Spine ?= require '../src/spine'
      require '../src/local'
      $ = jQuery = Spine.$

      done()
    )

  after ->
    delete global[key] for key in ['document', 'window', 'localStorage', 'Spine']

  User = undefined

  beforeEach ->
    User = Spine.Model.setup("User", ["name"])

  it "should persist attributes", ->
    User.extend(Spine.Model.Local)
    User.create({name: "Bob"})
    User.fetch()

    User.first().should.be.ok
    User.first().name.should.equal "Bob"


  it "should reset ID counter", ->
    User.refresh([{name: "Bob", id: 1}])

    User.idCounter.should.equal 2