$('.bounce-cat').on('click', function(){    //.bounce-catをクリックしたとき
  $(this).addClass('animate__animated animate__bounce shake-cat');    //その要素にクラス付与
  $(this).on('animationend', function(){    //その要素のアニメーションが終わったとき
    $(this).removeClass('animate__animated animate__bounce bounce-cat');    //その要素からクラス除去
    $('.shake-cat').on('click', function(){     //.shake-catをクリックしたとき
      $(this).addClass('animate__animated animate__shakeX exit-cat');     //その要素にクラス付与
      $(this).on('animationend', function(){    //その要素のアニメーションが終わったとき
        $(this).removeClass('animate__animated animate__shakeX');     //その要素からクラス除去
        $('.exit-cat').on('click', function(){    //.exit-catをクリックしたとき
          $(this).addClass('animate__animated animate__lightSpeedOutRight');    //その要素にクラス付与
          $(this).on('animationend', function(){    //その要素のアニメーションが終わったとき
            $('.admin-link').css('display','inline-block');     //.admin-linkのcssを変更
            $('.admin-link').addClass('animate__animated animate__fadeInUp');     //さらにクラス
          });
        });
      });
    });
  });
});