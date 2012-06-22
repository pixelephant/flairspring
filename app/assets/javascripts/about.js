$(document).ready(function(){

	$.each(".employee img",function(){
		var image1 = $('<img />').attr('src', $(this).data("hover"));
	});

	$(".employee img").mouseenter(function(){
		$(this).attr("src",$(this).data("hover"));
	});

});