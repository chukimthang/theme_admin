$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("#user_profile_attributes_description").froalaEditor();

    $("#user-listing").on("click", ".remove", function () {
      var id = $(this).data("id");
      $('#btn-confirm-delete').attr('href', "/admin/users/" + id);
    });

    $("#seach-form-user").on("click", ".reset", function() {
      $("#q_email_cont").val("");
      $("#q_profile_full_name_cont").val("");
    });
  });
});
