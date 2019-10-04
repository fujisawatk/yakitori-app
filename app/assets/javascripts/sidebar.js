$(document).on('turbolinks:load', function() { 
  $('#sidebar').hover(function(){
    $('.hover').hide();
    $('#menu').show(500);
    $(this).stop(true).animate({width:'200px'},500);
  },function(){
      $('#menu').hide();
      $('.hover').show();
      $(this).animate({width:'35px'},0);
  }).trigger('mouseleave');
});
