//= require jquery.easing
//= require carousel
//= require mousewheel
//= require jquery.fancybox
//= require jquery.slider.min


$("document").ready(function(){

$.each($("input[type='slider']"),function(){
		var $this = $(this);
		$this.slider({
			skin: "blue",
			from: parseFloat($this.val().split(";")[0]),
			to: parseFloat($this.val().split(";")[1]),
			step: 0.1,
			dimension: '&nbsp;' + $this.data("unit")
			});	
	});
	
	$(".fancybox").fancybox({
			type : 'ajax',
			openEffect	: 'elastic',
			closeEffect	: 'elastic',
			autoSize: true,
			arrows: true,
			nextEffect: 'none',
			prevEffect: 'none'
		});
});