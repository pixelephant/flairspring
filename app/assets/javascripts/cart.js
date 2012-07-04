//= require jquery.easing
//= require carousel
//= require mousewheel
//= require modal

var shipping_threshold = 1000;
var shipping_fee = 4500;

$("document").ready(function(){

	function recalculate_sum(){
		var subtotal = 0;
		$.each($(".sum-price-cell span"),function(){
			subtotal += parseInt($(this).html());
		});

		var shipping = subtotal > shipping_threshold ? 0 : 4500;

		var total = subtotal + shipping;

		$(".subtotal").html(subtotal);
		$(".shipping-cost").html(shipping);
		$(".total-price").html(subtotal + shipping)
	}

	$(".quantity-cell input[type='number']").bind("input",function(){
		var $this = $(this);
		var price = parseInt($this.parents("tr").find(".price-cell span").html());
		$this.parents("tr").find(".sum-price-cell span").html(price * parseInt($this.val()));
		recalculate_sum();
	});

	$(".delete").click(function(){
		var $this = $(this);
		var prodId = $(this).parents("tr").data("id")
		$.ajax({
		  type: 'POST',
		  url: "/cart/remove_item",
			data: {id : prodId},
		  success: function(resp){
		  	if(resp == true){
		  		$this.parents("tr").fadeOut(300, function(){
					$(this).remove();
					if(!$("#cart-table tbody tr").length){
						$("#cart-table,#cart-bottom,form").remove();
						$("#cart").append("<p></p>");
					}
					recalculate_sum();
					});
		  	}
		}});
		return false;
	});

	$("#personal-discount").click(function(){
		$.ajax({
			type: 'POST',
			url: "/cart/personal",
			data: {action : "personal"},
			headers: {
	      'X-Transaction': 'POST Example',
	      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    	},
			success: function(resp){
				if(resp.status == "true"){
					$("#personal-discount").addClass("active");
					val = parseInt($(".total-price").html()) - parseInt(resp.value);
					$(".total-price").html(val);
				}else{
					$("#personal-discount").removeClass("active");
					val = parseInt($(".total-price").html()) + parseInt(resp.value);
					$(".total-price").html(val);
				}
				//Ár levonása
		}});
		return false;
	});

	$("#use-coupon").click(function(){
		$.ajax({
			type: 'POST',
			url: "/cart/coupon",
			data: {
				action : "coupon",
				code : $("#coupon-code").val()
			},
			headers: {
	      'X-Transaction': 'POST Example',
	      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    	},
			success: function(resp){
				if(resp.status == "true"){
					$("#use-coupon").addClass("active");
					val = parseInt($(".total-price").html()) - parseInt(resp.value);
					$(".total-price").html(val);
				}else{
					$("#use-coupon").removeClass("active");
					val = parseInt($(".total-price").html()) + parseInt(resp.value);
					$(".total-price").html(val);
				}
				//Ár levonása
		}});
		return false;
	});

});