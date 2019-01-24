$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("#user_profile_attributes_description").froalaEditor();

    $("#seach-form-user").on("click", ".reset", function() {
      $("#q_email_cont").val("");
      $("#q_profile_full_name_cont").val("");
    });
  });
});
