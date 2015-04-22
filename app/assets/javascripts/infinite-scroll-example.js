$(function(){
  if($('.pagination').length){
    $(window).scroll(function(){
    var url = $('.pagination .next_page').attr('href')
    var isBottomReach = $(window).scrollTop() > $(document).height() - $(window).height() - 50
    if(url && isBottomReach){
      $('.pagination').text("Fetching more products")
      $.getScript(url)
    }
    })
    $(window).scroll() //trigger for the first time
  }

})

//then in the index.js.erb
$('#products').append('<%= j render(@products %>;)
<%if @products.netx %>
  $('.pagination').raplaceWith('<%= j will_paginate(@products)%>')
<%else%>
  $('.pagination').remove();
<%end%>
sleep(1) #see the pagination effect
