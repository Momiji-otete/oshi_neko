//画像ファイルが選択された際に発火し、画像のプレビューを表示
  // 初期状態では非表示にする
  $("#image-preview").hide();

  // 画像が選択された際に実行される関数
  function showPreview(event) {
    var file = event.target.files[0];
    var reader = new FileReader();

    // アップロードした画像をセットし、表示する
    reader.onload = function(e) {
      var previewElement = $("#image-preview");
      previewElement.attr("src", e.target.result);
      previewElement.show(); // 画像を表示する
    }

    // ファイルをデータURL形式で読み込む
    if (file) {
      reader.readAsDataURL(file);
    }
  }

  // 再度別画像が読み込まれた時にプレビューを変更する
  if (document.URL.match(/posts/)) {
    var fileInput = $("#post_image");
    fileInput.on("change", showPreview);
  } else {
    var fileInput = $("#cat_cat_image");
    fileInput.on("change", showPreview);
  }