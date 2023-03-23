$(document).on('turbolinks:load', function() {
    $('.images-field').on('click','.btn-delete', function(e){
       e.preventDefault();
       $(this).parent().remove();
    });
 $('#item_images').on('change',function(e){
    var files = e.target.files;
    var d = (new $.Deferred()).resolve();
    $.each(files,function(i,file){
      d = d.then(function() {
          return Uploader.upload(file)
      }).then(function(data){
          return previewImage(file, data.image_id);
      });
    });
    $('#item_images').val('');
  });


  var previewImage = function(imageFile, image_id){
    var reader = new FileReader();
    var img = new Image();
    var def =$.Deferred();
    reader.onload = function(e){
      var image_box = $('<div>',{class: 'image-box'});
      image_box.append(img);
      image_box.append($('<p>').html(imageFile.name));
      image_box.append($('<input>').attr({
            name: "product[images][]",
            value: image_id,
            style: "display: none;",
            type: "hidden",
            class: "product-images-input"}));
      image_box.append('<a href="" class="btn-delete">Delete</a>');
      $('.images-field').append(image_box);
      img.src = e.target.result;
      def.resolve();
    };
    reader.readAsDataURL(imageFile);
    return def.promise();
  }

  var Uploader = {
    upload: function(imageFile){
      var def =$.Deferred();
      var formData = new FormData();
      formData.append('image', imageFile);
      $.ajax({
        type: "POST",
        url: '/products/upload_image',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false,
        success: def.resolve
      })
      return def.promise();
    }
  }
  
 })
  