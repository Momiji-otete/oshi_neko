$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0 //最上部に移動
    }, 500);  //0.5秒間かけて
    event.preventDefault(); //aタグの機能を無効化
  });
});