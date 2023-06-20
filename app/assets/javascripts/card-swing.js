//スクロールをするたびにアニメーションを行う設定
$('.swing').on('inview', function(event, isInView) {
  if (isInView) {//表示領域に入った時
  $(this).addClass('animate__animated animate__swing');//クラス名が付与
  } else {//表示領域から出た時
    $(this).removeClass('animate__animated animate__swing');//クラス名が除去
  }
});

//スクロールをしたら1度だけアニメーションをする設定
  $('.swingOnce').on('inview', function(event, isInView) {
    if (isInView) {//表示領域に入った時
      $(this).addClass('animate__animated animate__swing');//クラス名が付与
    }
  });