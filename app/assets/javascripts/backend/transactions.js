$(document).on("turbolinks:load", function() {
  $(document).ready(function () {
    $("#transaction_kind_income").on("ifChecked", function () {
      $(".transaction-category").hide();
      $(".gr-validation-errors").hide();
      $(".field_with_errors input").css("border-color", "#d2d6de");
      $(".field_with_errors textarea").css("border-color", "#d2d6de");
    });

    $("#transaction_kind_income").on("ifUnchecked", function () {
      $(".transaction-category").show();
      $(".gr-validation-errors").hide();
      $(".field_with_errors input").css("border-color", "#d2d6de");
      $(".field_with_errors textarea").css("border-color", "#d2d6de");
    });

    var check_income = $("#transaction_kind_income").prop('checked');
    if (check_income) {
      $(".transaction-category").hide();
    }

    $(".transaction-edit .icheck-me").iCheck("disable");

    $("#seach-form-transaction").on("click", ".reset", function() {
      $("#category_id").val("");
      $("#q_created_at_gteq").val("");
      $("#q_created_at_lteq").val("");
      $("#q_description_cont").val("");
      $("#q_amount_gteq").val("");
      $("#q_amount_lteq").val("");
    });
  });
});
