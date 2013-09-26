# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe '/messages/new', (data) ->
    console.log data

