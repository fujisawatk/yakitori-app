$(function(){
  $(document).on('click', '#dummy-button', function(){
    var formData = $('#dummy-area').val();
    if (formData.length == 0){
      var empty = `<p>コメントを入力してください</p>`;
      $('.comment-error').empty();
      $('.comment-error').append(empty);
    }else if ( formData.length >= 141){
      var empty = `<p>140文字以内で入力してください</p>`;
      $('.comment-error').empty();
      $('.comment-error').append(empty);
    }else{
      var c_u_id = gon.current_user_id;
      var c_u_name = gon.current_user_name
      var html = `<p>
                    <strong>
                      <a href="/users/${c_u_id}">${c_u_name}</a>
                      ：
                    </strong>
                    ${formData}
                  </p>`;
      $('.comment-index').append(html);
      $('#comment-area[type=text]').val(formData);
      $('#dummy-area').val('');
      $('.comment-error').empty();  
    }
  });
});
