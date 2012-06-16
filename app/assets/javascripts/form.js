$(function() {
  $('.reoccurring').hide();
  $('#income_reoccurring, #outgoing_reoccurring, #transaction_reoccurring').click(
    function(e) {
      e.preventDefault();
      $('.reoccurring').fadeToggle();
    }
  )
});
