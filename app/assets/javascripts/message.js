$(function() {
  function scrollToBottomMessageList() {
    $('.message-list').animate({ scrollTop: $('.message-list')[0].scrollHeight }, 'normal');
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
    text_area.val('');
    $('.message-list').append(html);
    scrollToBottomMessageList();
  });

  });
});
