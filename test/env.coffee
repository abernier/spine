global.document      ?= require('jsdom').jsdom("<html><head></head><body></body></html>")
global.window        ?= document.createWindow()
global.window.jQuery ?= require('jQuery').create(window)

global.Spine ?= require '../src/spine'