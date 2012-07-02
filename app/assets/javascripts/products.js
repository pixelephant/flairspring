//= require zoom
//= require jquery.fancybox

$(window).load(function(){
	
	$("#add-to-whishlist").click(function(){
		//ajax call
		$.ajax({
		  type: 'POST',
		  url: "/products/add_to_wishlist",
			data: {id : $("#product-title").data("product")},
			dataType: "json",
			headers: {
    		'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  		},
		  success: function(resp){
		  	if(resp.status == 'true'){
		  		$("#add-to-whishlist").addClass("added").find("span").html("Kívánságlistán");
		  	}
		}});
		return false;
	});

	$(".fancybox").fancybox({
			openEffect	: 'elastic',
			closeEffect	: 'elastic',
			autoSize: true,
			arrows: true,
			openEffect: 'elastic',
			closeEffect: 'elastic',
			nextEffect: 'none',
			prevEffect: 'none'			
		});

	if (!Modernizr.touch){
		$("#current-picture").css("paddingLeft", (440 - ($("#current-picture img")[0].width))/2);
		$("#current-picture").css("paddingTop", (300 - ($("#current-picture img")[0].height))/2);
	   	$('.zoomable').jqzoom({
			title: false,
			zoomType: 'reverse',
			zoomWidth: 478,  
			zoomHeight:300, 
	        yOffset:38,
			preloadText: ''
		});
	}
});