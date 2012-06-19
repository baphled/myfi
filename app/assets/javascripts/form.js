$(function() {
  $('.reoccurring').hide();
  $('#income_reoccurring, #outgoing_reoccurring, #transaction_reoccurring').click(
    function(e) {
      $('.reoccurring').fadeToggle();
    }
  )
});
