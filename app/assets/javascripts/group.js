$(document).on('turbolinks:load', function() {
  var user_list_selected = 'user-list-selected';
  var user_list_result = 'user-list-result';

  $('form').attr('autocomplete', 'off');

  function getUsernamesByButtons(buttons) {
    var usernames = [];

    $.each(buttons, function() {
      usernames.push($(this).attr('id').replace('button-', '').replace('-selected', ''));
    });

    return usernames
  };

  $(`#${user_list_selected}`).on('click', 'button', function() {
    $(this).remove();
  });

  $(`#${user_list_result}`).on('click', 'button', function() {
    var id = $(this).attr('id');

    $(this).attr('id', `${id}-selected`).appendTo(`#${user_list_selected}`);
  });

  $('form').on('submit', function() {
    var usernames = getUsernamesByButtons($(`#${user_list_selected} button`));
    $('<input>').attr('type', 'hidden').attr('name', 'usernames').attr('value', usernames).appendTo(this);
  });

  $('#user-list-input').on('keyup', function() {
    var preFunc = null;
    var preInput = '';
    var input = '';
    input = $.trim($(this).val());
    
    if (preInput !== input) {
      clearTimeout(preFunc);
      preFunc = setTimeout($.ajax({
        url: 'ajax_user_list',
        type: 'GET',
        data: (`q=${input}`)
      }), 500);
    }
    
    preInput = input;
  });

  $(`#${user_list_result}`).on('DOMSubtreeModified propertychange', function() {
    var resultUsernames = getUsernamesByButtons($(`#${user_list_result} button`));
    var selectedUsernames = getUsernamesByButtons($(`#${user_list_selected} button`));
    
    $.each(resultUsernames, function(index, value) {
      if ($.inArray(value, selectedUsernames) != -1) {
        $(`#button-${value}`).remove();
      }
    });
  });
});
