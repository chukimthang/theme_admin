$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("#user_profile_attributes_description").froalaEditor();

    $("#user-listing").on("click", ".remove", function () {
      var id = $(this).data("id");
      $('#btn-confirm-delete').attr('href', "/admin/users/" + id);
    });
  });
});
