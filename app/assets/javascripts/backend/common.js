$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("body").click(function(){
      $(".alert").alert("close");
    });

    $("#datepicker").datepicker({
      autoclose: true,
      format: 'yyyy-mm-dd',
    });

    $("#file-upload-image").change(function() {
      readURL(this);
    });

    icheck();
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        if($('#image-show').length) {
          $('#preview-image').attr('src', e.target.result);
        } else {
          $('#preview-image').attr('src', e.target.result);
        }
      };

      reader.readAsDataURL(input.files[0]);
    }
  }

  function icheck(){
    if($(".icheck-me").length > 0){
      $(".icheck-me").each(function(){
        var $el = $(this);
        var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
          color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
        var opt = {
          checkboxClass: 'icheckbox' + skin + color,
          radioClass: 'iradio' + skin + color,
        };
        $el.iCheck(opt);
      });
    }
  }
});
