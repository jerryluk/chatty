# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe "/users/#{Chatty.edmodo_id}", (data) ->
    console.log data
    $(document).trigger data.event, data

  if $('#topbar-content').length
    console.log('home')

    $(document).on('new_message', (data)->
      unless $('#apps-canvas iframe').length
        alert 'You got a new Message!'
    )
