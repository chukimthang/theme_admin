$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("#modal-new-group").on("click", ".btn-confirm-save", function() {
      var data = $("#frm-group-new").serialize();
      var url = "/admin/groups";

      onSave(data, url, "POST");
    });

    $("#group-listing").on("click", ".edit", function(){
      var id = $(this).data("id");
      var url = "/admin/groups/" + id + "/edit";

      $.ajax({
        method: "get",
        url: url,
        dataType: "script",
        success: function() {
          $("#modal-edit-group .btn-confirm-save").attr("id", id);
        }
      })
    });

    $("#modal-edit-group").on("click", ".btn-confirm-save", function() {
      var data = $("#frm-group-update").serialize();
      var id = $(this).attr("id");
      var url = "/admin/groups/" + id;
      onSave(data, url, "PUT");
    });

    $("#modal-new-group").on("hidden.bs.modal", function () {
      $(".error-content").html("");
    });

    $("#modal-update-group").on("hidden.bs.modal", function () {
      $(".error-content").html("");
    })
  });

  function onSave(data, url, type) {
    $.ajax({
      url: url,
      data: data,
      cache: false,
      type: type,
      success: function (data) {
        if (data.status) {
          location.reload();
        } else {
          $('.error-content.name').html(data.errors.name[0]);
        }
      }
    });
  }
});
