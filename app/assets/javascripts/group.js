$(document).on('ready turbolinks:load', function() {
  $('.user-list-input').select2({
    placeholder: '追加するメンバーを選んでください',
    allowClear: true,
    minimumInputLength: 1,
    language: {
      inputTooShort: null
    }
  });
});
