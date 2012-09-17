//= require jquery.tooltip
//= require jquery.validate
//= require jquery.maskedinput-1.3.min

$(document).ready(function(){
	$('.tooltip').tooltip();
	$("#user_phone").mask("+99 99 999-99-99");
	
	$("#user_new").validate({
  		rules:{
  			"user[password]" : {
  				required : true,
  				minlength : 6
  			},
    		"user[password_confirmation]":{
      			equalTo: "#user_password",
      			required : true
    		}
  		}
	});

	$("#same").change(function(){
		if($(this).is(":checked")){
			$("#user_addresses_attributes_1_zip").val($("#user_addresses_attributes_0_zip").val());
			$("#user_addresses_attributes_1_city").val($("#user_addresses_attributes_0_city").val());
			$("#user_addresses_attributes_1_additional").val($("#user_addresses_attributes_0_additional").val());
		}
		else{
			$("#user_addresses_attributes_1_zip").val("");
			$("#user_addresses_attributes_1_city").val("");
			$("#user_addresses_attributes_1_additional").val("");
		}
	});

});