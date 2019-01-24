$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("#user_profile_attributes_description").froalaEditor();

    $("#seach-form-user").on("click", ".reset", function() {
      $("#q_email_cont").val("");
      $("#q_profile_full_name_cont").val("");
      $("#q_status_eq").val("");
    });

    $("#user-listing").on("change", ".change-status", function() {
      changeActiveUser(this);
    });
  });

  function changeActiveUser(this_field) {
    var status = $(this_field).prop("checked");
    var id = $(this_field).data("id");
    var url = "/admin/users/" + id + "/change_status";

    $.ajax({
      method: "post",
      data: {status: status},
      url: url,
      success: function (data) {
        if (data.status) {
          var str = "<div class='alert alert-success fade in'>";
          str += "Update status success";
          str += "</div>";
          $(".flash-message").html(str);
        } else {
          var str = "<div class='alert alert-danger fade in'>";
          str += "Update status fail";
          str += "</div>";
          $(".flash-message").html(str);
        }
      }
    });
  }
});
