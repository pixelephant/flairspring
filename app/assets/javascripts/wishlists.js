//= require users.js

$(document).ready(function(){
	$(".buy-from-wishlist").click(function(){
		var id = $(this).data("product");
		console.log(id);
		//ajax call
		$.ajax({
		  type: 'POST',
		  url: "/products/buy_from_wishlist",
			data: {id : id},
			headers: {
	  		'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
			},
		  success: function(resp){
		  	if(resp.status == 'true'){
		  		location.reload();
		  	}
		}});
		return false;
	});
});