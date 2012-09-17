// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require modernizr
//= require jquery
//= require jquery.fancybox

$(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
        settings.data = (settings.data ? settings.data + "&" : "")
            + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
    }
});

$("document").ready(function(){

  $("#properties-box input[type='submit']").click(function(){
    $.fancybox({
      href : "#alert-wrap",
      openEffect  : 'elastic',
      closeEffect : 'elastic',
      autoSize: true
    });
    return false;
  });

	$("a.tooltip").click(function(){
		return false;
	});

  $("#wishlist-not-signed-in").click(function(){
    $.fancybox({
      href : "#wishlist-message",
      openEffect  : 'elastic',
      closeEffect : 'elastic',
      autoSize: true
    });
    return false;
  });

});
