should = require 'should'
sinon =  require 'sinon'

require './env'
require '../src/local'

describe "Model.Local", ->
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