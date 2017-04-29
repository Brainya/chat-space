$(document).on('turbolinks:load', function() {
  $.fn.flashMessage = function(options) {
    options = $.extend({
      text: 'Done',
      time: 1000,
      how: 'before',
      class_name: ''
    },
    options
    );
    
    return $(this).each(function() {
      if ($(this).parent().find('.flash_message').get(0))
      return;
      
      var message = $(`<span class="flash_message ${options.class_name}">`).append(options.text).hide().fadeIn('fast');
      
      $(this)[options.how](message);
      
      message.delay(options.time).fadeOut('normal', function() {
        $(this).remove();
      });
    });
  };
    
  function scrollToBottomMessageList() {
    $('.message-list').animate({
      scrollTop: $('.message-list')[0].scrollHeight
    },
      'fast'
    );
  }

  function buildHTML(data) {
    var username = $(`<span class="username">`).append(data.username);
    var date = $(`<span class="date">`).append(data.date);
    var message = $(`<p class="text">`).append(data.message);

    var header = $(`<div class="message-list__item--header">`).append(username, date);
    var body = $(`<div class="message-list__item--body">`).append(message);
    var html = $(`<li class="message-list__item">`).append(header, body);

    return html;
  }

  $('.message-input__new_message').on('ajax:success', function(event, data, status) {
    var text_area = $('.message-input__new_message--textarea');
    var html = buildHTML(data);

    $('.message-list').append(html);
    scrollToBottomMessageList();
    text_area.val('');
    $('.send-message-status__success').flashMessage({
      text: 'メッセージが送信されました',
      how: 'append'
    });
  });

  $('.message-input__new_message').on('ajax:error', function(event, data, status) {
    $('.send-message-status__failure').flashMessage({
      text: 'メッセージの送信に失敗しました',
      how: 'append'
    });
  });

  $('.message-list').ready(function() {
    scrollToBottomMessageList();
  });
});
