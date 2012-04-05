should = require 'should'
sinon =  require 'sinon'

require './env'

describe "Events", ->
  EventTest = undefined
  spy       = undefined

  beforeEach ->
    EventTest = Spine.Class.create()
    EventTest.extend(Spine.Events)

    noop = {spy: ->}
    spy = sinon.spy(noop, "spy")


  it "can bind/trigger events", ->
    EventTest.bind("daddyo", spy)
    EventTest.trigger("daddyo")
    
    spy.should.be.called


  it "should trigger correct events", ->
    EventTest.bind("daddyo", spy)
    EventTest.trigger("motherio")
    
    spy.should.not.be.called


  it "can bind/trigger multiple events", ->
    EventTest.bind("house car windows", spy)
    EventTest.trigger("car")
    
    spy.should.be.called


  it "can pass data to triggered events", ->
    EventTest.bind("yoyo", spy)
    EventTest.trigger("yoyo", 5, 10)
    
    spy.calledWith(5, 10).should.be.true