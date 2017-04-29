$(document).on('turbolinks:load', function() {
  var message_list = 'message-list'
  var message_input = 'message-input'

  $.fn.flash_message = function(options) {
    options = $.extend({
      text: 'Done',
      time: 1000,
      how: 'before',
      class_name: ''
    }, options);
    
    return $(this).each(function() {
      if ($(this).parent().find('.flash_message').get(0))
      return;
        
        var message = $('<span>', {
          'class': 'flash_message ' + options.class_name,
          text: options.text
        }).hide().fadeIn('fast');
        
        $(this)[options.how](message);
        
        message.delay(options.time).fadeOut('normal', function() {
          $(this).remove();
        });
      });
    };
    
  function scrollToBottomMessageList() {
    $(`.${message_list}`).animate({
      scrollTop: $('.message-list')[0].scrollHeight
    },
      'fast'
    );
  }

  function buildHTML(data) {
    var username = $(`<span class="username">`).append(data.username);
    var date = $(`<span class="date">`).append(data.date);
    var message = $(`<p class="text">`).append(data.message);

    var header = $(`<div class="${message_list}__item--header">`).append(username, date);
    var body = $(`<div class="${message_list}__item--body">`).append(message);
    var html = $(`<li class="${message_list}__item">`).append(header, body);

    return html;
  }

  $(`.${message_input}__new_message`).on('ajax:success', function(event, data, status) {
    var text_area = $(`.${message_input}__new_message--textarea`);
    var html = buildHTML(data);

    $(`.${message_list}`).append(html);
    scrollToBottomMessageList();
    text_area.val('');
    $('.send-message-status__success').flash_message({
      text: 'メッセージが送信されました',
      how: 'append'
    });
  });

  $(`.${message_input}__new_message`).on('ajax:error', function(event, data, status) {
    $('.send-message-status__failure').flash_message({
      text: 'メッセージの送信に失敗しました',
      how: 'append'
    });
  });

  $(`.${message_list}`).ready(function() {
    scrollToBottomMessageList();
  });
});
