should = require 'should'
sinon =  require 'sinon'

require './env'

describe "Model", ->
  Asset = undefined

  beforeEach ->
    Asset = Spine.Model.setup("Asset", ["name"])


  it "can create records", ->
    asset = Asset.create({name: "test.pdf"})
    Asset.first().should.eql asset


  it "can update records", ->
    asset = Asset.create({name: "test.pdf"})

    Asset.first().name.should.eql "test.pdf"

    asset.name = "wem.pdf"
    asset.save()

    Asset.first().name.should.eql "wem.pdf"


  it "can destroy records", ->
    asset = Asset.create({name: "test.pdf"})

    Asset.first().should.eql asset
    asset.destroy()
    should.not.exist Asset.first()


  it "can find records", ->
    asset = Asset.create({name: "test.pdf"})
    
    Asset.find(asset.id).should.eql asset
    asset.destroy()
    (-> Asset.find(asset.id)).should.throw()


  it "can check existence", ->
    asset = Asset.create({name: "test.pdf"})

    asset.exists().should.be.ok
    Asset.exists(asset.id).should.be.ok

    asset.destroy();

    asset.exists().should.be.false
    Asset.exists(asset.id).should.be.false