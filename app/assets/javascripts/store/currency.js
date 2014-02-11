$(function() {
  var current_currency = $("#currency-select select").val();
  return $("#currency-select select").change(function() {
    var newVal = $(this).val();
    if ($(this).data('line-items') && !confirm("Changing currencies will empty your cart. Continue?")) {
      $(this).val(current_currency); //set back
      return;                           //abort!
    } else {
      $.ajax({
        type: "POST",
        url: $(this).data("href"),
        data: {
          currency: $(this).val()
        }
      }).done(function() {
        return window.location.reload();
      });
    }
  });
});