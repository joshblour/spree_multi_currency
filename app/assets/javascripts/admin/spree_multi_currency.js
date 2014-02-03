//= require admin/spree_backend


$(function() {
  $(".set-currency-price-manually").change(function() { 
    $(this).prev("input").prop('disabled', $(this).is(":checked")).focus();
    return false;
  });
  
  $(".set-currency-price-manually").trigger('change');
});
