//= require jquery.easing
//= require carousel
//= require mousewheel
//= require jquery.fancybox
//= require jquery.slider.min


$("document").ready(function(){
	
	$("#back-to-top").click(function(){
		$('html,body').animate({scrollTop: $($(this).attr("href")).offset().top -10},'slow');
		return false;
	});
	
	$.each($("input[type='slider']"),function(){
		var $this = $(this);
		$this.slider({
			skin: "blue",
			from: $this.data("from"),
			to: $this.data("to"),
			step: 0.1,
			dimension: '&nbsp;' + $this.data("unit")
			});	
	});
/*	
	$.prettyLoader({
		loader: '/assets/prettyLoader/ajax-loader.gif',
		bind_to_ajax: true
	});

/*	$("#last-viewed .carousel").jCarouselLite({
	        btnPrev: "#last-viewed .left",
	        btnNext: "#last-viewed .right",
		    mouseWheel: true,
		    visible: 6,
		    scroll: 2
	}); */

	
	$(".fancybox").fancybox({
			type : 'ajax',
			openEffect	: 'elastic',
			closeEffect	: 'elastic',
			autoSize: true,
			arrows: true,
			nextEffect: 'none',
			prevEffect: 'none'
		});
	
/*	$(".quicklook").click(function(){
		var id = $(this).parents(".product").data("id");
		$(this).parents(".product").addClass("opened");
		$("#product-modal").data("next-id",$(this).parents(".product").next().data("id"));
		$("#product-modal").data("prev-id",$(this).parents(".product").prev().data("id"));
		/*$("#product-modal").modal({
			onClose: function (dialog) {
				$("#product-grid .opened").removeClass("opened");
				dialog.data.fadeOut('slow', function () {
					dialog.container.slideUp('slow', function () {
						dialog.overlay.fadeOut('slow', function () {
							$.modal.close(); // must call this!
						});
					});
				});
			},
			onOpen: function (dialog) {
				dialog.overlay.fadeIn('slow', function () {
					$.ajax({
					  type: 'POST',
					  url: "/products/quicklook",
						data: {id : id},
					  success: function(resp){
						$("#product-modal .clearfix").html(resp);
						dialog.container.slideDown('slow', function () {
							dialog.data.fadeIn('slow');
						});
					}});

				});
			}
		});
		
		return false;
	});

	$("#modal-next,#modal-prev").click(function(){
		if($(this).attr("id") == "modal-prev"){
			if(!$("#product-grid .opened").prev().length) { return false;}
			var id = $("#product-modal").data("prev-id");
			$("#product-grid .opened").removeClass("opened").prev().addClass("opened");
		}
		else{
			if(!$("#product-grid .opened").next().length) { return false;}
			var id = $("#product-modal").data("next-id");
			$("#product-grid .opened").removeClass("opened").next().addClass("opened");
		}
		$.ajax({
		  type: 'POST',
		  url: "/products/quicklook",
			data: {id : id},
		  success: function(resp){
			$("#product-modal .clearfix").html(resp);

			$("#product-modal").data("next-id",$("#product-grid .opened").next().data("id"));
			$("#product-modal").data("prev-id",$("#product-grid .opened").prev().data("id"));
		}});
		return false;
	});*/

});
