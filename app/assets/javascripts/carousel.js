$(document).ready(function(){
	
	$(".slider .left").click(function(){
		var $this = $(this).parents(".slider");
		var itemWidth = $this.find("li").eq(0).outerWidth();
		var $slider = $this.find(".slider-inner");
		$slider.animate({
			"scrollLeft" : $slider.scrollLeft() - itemWidth*4
		},300,"easeOutQuad");
		return false;
	});

	$(".slider .right").click(function(){
		var $this = $(this).parents(".slider");
		var itemWidth = $this.find("li").eq(0).outerWidth();
		var $slider = $this.find(".slider-inner");
		$slider.animate({
			"scrollLeft" : $slider.scrollLeft() + itemWidth*4
			},300,"easeOutQuad");
		return false;
	});

});