$(function() {
  $(document).on('click', '#modal-del', function() {
    if ($('#new_comment') != 0){
      $('#new_comment').submit();
    };
    $('.modal').remove();
  });
  $(document).on('click', '.modal-background', function() {
    if ($('#new_comment') != 0){
      $('#new_comment').submit();
    };
    $('.modal').remove();
  });
});