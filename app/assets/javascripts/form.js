$(function() {
  $('.reoccuring').hide();
  $('#outgoing_reoccuring').click(
    function(e) {
      e.preventDefault();
      $('.reoccuring').fadeToggle();
    }
  )
});
