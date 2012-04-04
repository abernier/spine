should = require 'should'
sinon =  require 'sinon'

jsdom    = require('jsdom').jsdom
global.document = jsdom("<html><head></head><body></body></html>")
window   = document.createWindow()
$        = jQuery = require('jQuery').create(window)

Spine = require '../src/spine'

