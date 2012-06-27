//= require zoom
//= require jquery.easing
//= require carousel
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
	else{
		$("#picture-list a").click(function(){
			var $this = $(this);
			$this.siblings().removeClass("zoomThumbActive").end().addClass("zoomThumbActive");
			$("#current-picture a").fadeOut(300,function(){
				$(this).remove();
				var rel = eval('(' + $this.attr("rel") + ')');
			
			var a = $("<a>").attr("href",rel.largeimage);
			var i = $("<img>").attr("src",rel.smallimage);
			a.hide();
			a.append(i);
			a.appendTo("#current-picture").fadeIn();
			});
			return false;
		});
	}
});