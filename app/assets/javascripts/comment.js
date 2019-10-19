$(function(){

  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href="/users/${comment.user_id}">${comment.user_name}</a>
                    <span>：
                  </strong>
                  ${comment.comment}
                </p>`;;
    return html;                 
  }
  $(document).on('turbolinks:load', function() {
    $('#new_comment').on('submit', function(e){
      $('.comment-error').empty();
      e.preventDefault();
      var formData = new FormData(this);
      if ($('#comment-area').val().length == 0){
        var empty = `<p>コメントを入力してください</p>`;
        $('.comment-error').empty();
        $('.comment-error').append(empty);
        return false;
      }else if ($('#comment-area').val().length >= 141){
        var empty = `<p>140文字以内で入力してください</p>`;
        $('.comment-error').empty();
        $('.comment-error').append(empty);
        return false;
      }else{
        var url = $(this).attr('action');

        $.ajax({
          url: url,
          type: "POST",
          data: formData,
          dataType: 'json',
          processData: false,
          contentType: false
          })

        .done(function(data){
          var html = buildHTML(data);
          $('.comment-index').append(html);
          $('#comment-area').val('');
          $('#comment-button').prop('disabled',false);
        })

        .fail(function(){
          alert('コメントを送信できませんでした');
          $('#comment-button').prop('disabled',false);
        });
      };
    });
  });
});
