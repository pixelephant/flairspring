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
						$("#cart").append("<p>Üres</p>");
					}
					recalculate_sum();
					});
		  	}
		}});
		return false;
	});

	$("#coupon a").click(function(){
		//$.ajax({
		//  type: 'POST',
		//  url: "/cart/coupon",
		//	data: {code : $("#coupon-code").val()},
		//  success: function(resp){
			//vissza, hogy ok, nem ok, hogy módosítja az árat, ha el van fogadva akkor többet nem lehet beváltani (disable,törlés?)
		//}});
		return false;
	});

});