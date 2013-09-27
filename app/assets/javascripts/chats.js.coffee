# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.Chat =
  renderChat: (chat) ->
    console.log(chat)
    HandlebarsTemplates['chat'](chat)

  renderMessage: (message) ->
    console.log(message)
    HandlebarsTemplates['message'](message)

$ ->
  if $('#root.index').length
    $('#chats_container ul.chats').on('click', 'li', ->
      $.getScript $(this).data('url')
      $("#new_chat_container").hide();
      $('#messages_container').show();
      $(this).removeClass('unread');
    )
    $(document).on('new_message', (event, data) ->
      console.log(data)
      if $("#chat_container_#{data.chat_id}").length
        $.getJSON("/chats/#{data.chat_id}/messages/#{data.message_id}", (json) ->
          $(Chat.renderMessage(json)).appendTo($("#chat_container_#{data.chat_id} .messages"));
        )
      else
        unless $("#chat_#{data.chat_id}").length
          $("<div id='chat_#{data.chat_id}'></div>").appendTo($("#chats_container .chats"))

        $.getJSON("/chats/#{data.chat_id}", (json) ->
          $("#chat_#{data.chat_id}").replaceWith($(Chat.renderChat(json)))
        )
    )
