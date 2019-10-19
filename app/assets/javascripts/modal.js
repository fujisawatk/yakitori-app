$(function() {
  /*モーダルのURL、アンカー表示*/
  $('.post-item').click(function(e){
    e.preventDefault();
    location.hash = $(this).attr('href');
  });
  /*モーダルを閉じた時の処理*/
  var comment = function(){
    if ($('#comment-area[type=text]').val() != 0){
      $('form#new_comment').submit();
    }else{
      location.href = '';
    }
    $('.modal').remove();
  }
  $(document).on('click', '#modal-del', function(i) {
    comment(i);
  });
  $(document).on('click', '.modal-background', function(i) {
    comment(i);
  });
  $(document).on('click', '#modal-user', function(i) {
    comment(i);
  });
  $(document).on('click', '.modal-icon', function(i) {
    comment(i);
  });
});