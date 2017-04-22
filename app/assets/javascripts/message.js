$(function() {
  function buildHTML(message) {
    var html = $('<li class="message-list__item">').append(message.content);
    return html;
  }

  $('.message-input__new_message').on('submit', function(e) {
    var textField = $('.message-input__new_message--textarea');
    var message = textField.val();

    $.ajax({
      type: 'POST',
      url: 'messages',
      data: {
        message: {
          content: message
        }
      },
      dataType: 'json',
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.message-list').append(html);
      textField.val('');
    })
    .fail(function() {
      textField.val(message);
    });
  });
});
