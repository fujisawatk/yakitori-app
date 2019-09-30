$(function(){
  var url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
  var params = {
    keyid: "6cb1c14076c18f29de7a45fad296478e",
    name: ""
  };
  var counts = []
  var showResult = function(result){
    result.rest.map(function(ele, index){
      $("#ul").append(`<li id="list"><input type="checkbox" data-id=${index} id="checkbox">${ele.name}</li>`);
      ele.num = index;
      counts.push(ele);
    });
  }
  $(document).on("click", "#search", function(){
    counts.length = 0;
    $("#ul").empty();
    params.name = $("#key").val();
    $.getJSON(url, params, function(result){
      showResult(result);
    });
  });
  $(document).on("change", "#checkbox", function(){
      var sel = $('#checkbox:checked').data('id');
      $("#rest_name").val("");
      $("#rest_url").val("");
      $.each(counts, function(index, count){
        if (sel == count.num){
          $("#rest_name").val(count.name);
          $("#rest_url").val(count.url);  
        }
      })
  })
})