$(document).on('turbolinks:load', function() {
  function getUsernamesByButtons(buttons) {
    var usernames = [];

    $.each(buttons, function() {
      usernames.push($(this).attr('id').replace('button-', '').replace('-selected', ''));
    });

    return usernames;
  };

  $('#user-list-selected').on('click', 'button', function() {
    $(this).remove();
  });

  $('#user-list-result').on('click', 'button', function() {
    var id = $(this).attr('id');

    $(this).attr('id', `${id}-selected`).appendTo('#user-list-selected');
  });

  $('form').on('submit', function() {
    var usernames = getUsernamesByButtons($('#user-list-selected button'));
    $('<input>').attr('type', 'hidden').attr('name', 'usernames').attr('value', usernames).appendTo(this);
  });

  $('#user-list-input').on('keyup', function() {
    var preFunc = null;
    var preInput = '';
    var input = '';
    input = $.trim($(this).val());
    
    if (preInput !== input) {
      clearTimeout(preFunc);
      preFunc = setTimeout(
        $.ajax({
          url: location.href,
          type: 'GET',
          data: {'q': input},
          dataType: 'script'
        }),
        500
        );
    }
    
    preInput = input;
  });

  $('#user-list-result').on('DOMSubtreeModified propertychange', function() {
    var resultUsernames = getUsernamesByButtons($('#user-list-result button'));
    var selectedUsernames = getUsernamesByButtons($('#user-list-selected button'));
    
    $.each(resultUsernames, function(index, value) {
      if ($.inArray(value, selectedUsernames) != -1) {
        $(`#button-${value}`).remove();
      }
    });
  });
});
