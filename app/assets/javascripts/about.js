$(document).ready(function(){

	$.each(".employee img",function(){
		var image1 = $('<img />').attr('src', $(this).data("hover"));
	});

	$(".employee img").mouseenter(function(){
		$(this).attr("src",$(this).data("hover"));
	});

	$('.more').click(function() {

		if($(this).parent().parent().css("height") == "680px"){
			$(this).parent().parent().animate({
		    height: 318
		  }, 1500, function() {
		    // Animation complete.
		  });
		}else{
			$(this).parent().parent().animate({
		    height: 680
		  }, 1500, function() {
		    // Animation complete.
		  });
		}
	});

});