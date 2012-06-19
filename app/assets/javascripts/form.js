$(function() {
  $('.reoccurring').hide();
  $('.custom_range').hide();

  $('#income_reoccurring, #outgoing_reoccurring, #transaction_reoccurring').click(
    function(e) {
      $('.reoccurring').fadeToggle();
    }
  )
  $('#transaction_custom_range, #ncome_custom_range, #outgoing_custom_range').click(
    function(e) {
      $('.custom_range').fadeToggle();
    }
  );
});
