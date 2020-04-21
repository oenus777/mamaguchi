$(document).on('turbolinks:load', function(){
  $('#upload_area').on('change', function(e){
  // 画像が選択された時プレビュー表示、inputの親要素のdivをイベント元に指定

    //ファイルオブジェクトを取得する
    let files = e.target.files;
    $.each(files, function(index, file) {
      let reader = new FileReader();

      //画像でない場合は処理終了
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
      //アップロードした画像を設定する
      reader.onload = (function(file){
        return function(e){
          let imageLength = $('#preview').children('li').length;
          // 表示されているプレビューの数を数える

          let labelLength = $("#upload_area>label").eq(-1).data('label-id');
          // #image-inputの子要素labelの中から最後の要素のカスタムデータidを取得

          // プレビュー表示
          $('#upload_area').before(`<li class="upload-list" id="upload_image_${labelLength}" data-image-id="${labelLength}">
                                      <figure class="upload-figure ml-3 mb-3">
                                        <img src='${e.target.result}' title='${file.name}' style="width:150px; height:150px;" >
                                      </figure>
                                      <div class="upload-buttons">
                                        <a class="btn btn-link">編集</a>
                                        <a class="preview-delete btn btn-link" data-image-id="${labelLength}">削除</a>
                                      </div>
                                    </li>`);
          $("#upload_area>label").eq(-1).css('display','none');
          // 入力されたlabelを見えなくする

          if (imageLength < 2) {
            // 表示されているプレビューが９以下なら、新たにinputを生成する
            $("#upload_area").append(`<label for="post_images_${labelLength+1}" class="upload-label" data-label-id="${labelLength+1}">
                                        <input multiple="multiple" class="upload-fields" id="post_images_${labelLength+1}" style="display: none;" type="file" name="post[images][]">
                                        <i class="fas fa-camera fa-lg"></i>
                                      </label>`);
          };
        };
      })(file);
      reader.readAsDataURL(file);
    });
  });
      //削除ボタンが押された時
  $(document).on('click', '.preview-delete', function(){
    let targetImageId = $(this).data('image-id');
    // イベント元のカスタムデータ属性の値を取得
    $(`#upload_image_${targetImageId}`).remove();
    //プレビューを削除
    $(`[for=post_images_${targetImageId}]`).remove();
    //削除したプレビューに関連したinputを削除

    let imageLength = $('#preview').children('li').length;
    // 表示されているプレビューの数を数える
    if (imageLength ==2) {
      let labelLength = $("#upload_area>label").eq(-1).data('label-id');
      // 表示されているプレビューが３枚なら,#image-inputの子要素labelの中から最後の要素のカスタムデータidを取得
      $("#upload_area").append(`<label for="post_images_${labelLength+1}" class="upload-label" data-label-id="${labelLength+1}">
                                  <input multiple="multiple" class="upload-fields" id="post_images_${labelLength+1}" style="display: none;" type="file" name="post[images][]">
                                  <i class="fas fa-camera fa-lg"></i>
                                </label>`);
    };
  });
});