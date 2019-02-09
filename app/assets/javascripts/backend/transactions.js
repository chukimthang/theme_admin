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
  });
});
