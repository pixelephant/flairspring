$("document").ready(function(){
	var top = $('#cart-summary').offset().top - parseFloat($('#cart-summary').css('marginTop').replace(/auto/, 0));
  $(window).scroll(function (event) {
    // what the y position of the scroll is
    var y = $(this).scrollTop();

    // whether that's below the form
    if (y >= top) {
      // if so, ad the fixed class
      $('#cart-summary').addClass('fixed');
    } else {
      // otherwise remove it
      $('#cart-summary').removeClass('fixed');
    }
  });
});