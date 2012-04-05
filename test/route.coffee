should = require 'should'
sinon =  require 'sinon'

require './env'
require '../src/route'

describe "Routing", ->
  Route = Spine.Route
  spy   = undefined
  clock = undefined

  navigate = (str, callback) ->
    window.location.hash = str
    clock.tick(50)
    do callback if (callback)

  beforeEach ->
    Route.setup()

    noop = {spy: ->}
    spy = sinon.spy(noop, "spy")
    
    clock = sinon.useFakeTimers()

    Route.history = false
    Route.routes  = []

  afterEach ->
    Route.unbind()
    window.location.hash = ""
    
    clock.restore()


  it "can navigate", ->
    Route.navigate("/users/1")
    window.location.hash.should.equal "#/users/1"

    Route.navigate("/users", 2)
    window.location.hash.should.equal "#/users/2"


  it "can add regex route", ->
    Route.add(/\/users\/(\d+)/)

    Route.routes.should.be.ok


  it "can trigger routes", ->
    Route.add
      "/users":  spy,
      "/groups": spy

    navigate "/users", -> spy.should.be.called
    navigate "/groups", spy.should.be.called


  it "can call routes with params", ->
    Route.add
      "/users/:id/:id2": spy

    navigate "/users/1/2", ->
      spy.calledWith([{match: ["/users/1/2", "1", "2"], id: "1", id2: "2"}]).should.be.true


  it "can call routes with glob", ->
    Route.add
      "/page/*stuff": spy

    navigate "/page/gah", ->
      spy.lastCall.args.should.eql [{match: ["/page/gah", "gah"]}]


  it "should trigger routes when navigating", ->
    Route.add
      "/users/:id": spy

    Route.navigate("/users/1")

    clock.tick(50)

    spy.should.be.called


  it "has option to trigger routes when navigating", ->
    Route.add
      "/users/:id": spy

    Route.navigate("/users/1", true)

    clock.tick(50)

    spy.should.be.called