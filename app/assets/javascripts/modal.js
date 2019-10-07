$(function() {
  $(document).on('click', '#modal-del', function() {
    if ($('#comment-area[type=text]').val() != 0){
      debugger
      $('form#new_comment').submit();
    };
    $('.modal').remove();
  });
  $(document).on('click', '.modal-background', function() {
    if ($('#comment-area[type=text]').val() != 0){
      debugger
      $('form#new_comment').submit();
    };
    $('.modal').remove();
  });
  $(document).on('click', '#modal-user', function() {
    if ($('#comment-area[type=text]').val() != 0){
      $('form#new_comment').submit();
    };
    $('.modal').remove();
  });
  $(document).on('click', '.modal-icon', function() {
    if ($('#comment-area[type=text]').val() != 0){
      $('form#new_comment').submit();
    };
    $('.modal').remove();
  });
});