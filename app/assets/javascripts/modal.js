$(function() {
  $(document).on('click', '#modal-del', function() {
    $('.modal').remove();
  });
  $(document).on('click', '.modal-background', function() {
    $('.modal').remove();
  });
});