//スクロールをしたら1度だけアニメーションをする設定
  $('.fadeInTrrigerOnce').on('inview', function(event, isInView) {
    if (isInView) {//表示領域に入った時
      $(this).addClass('animate__animated animate__fadeIn');//クラス名が付与
    }
  });