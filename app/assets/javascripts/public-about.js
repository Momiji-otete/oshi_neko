  //スクロールをしたら1度だけアニメーションをする設定
  $('.fadeInDownTriggerOnce').on('inview', function(event, isInView) {
    if (isInView) {//表示領域に入った時
      $(this).addClass('animate__animated animate__fadeInDown');//クラス名が付与
    }
  });

  //スクロールをしたら1度だけアニメーションをする設定
  $('.fadeInTriggerOnce').on('inview', function(event, isInView) {
    if (isInView) {//表示領域に入った時
      $(this).addClass('animate__animated animate__fadeIn');//クラス名が付与
    }
  });
