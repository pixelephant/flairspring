//= require jquery.tooltip
//= require jquery.validate

$(document).ready(function(){
	$('.tooltip').tooltip();

	$("#user_new").validate({
        /*errorPlacement: function(error, element) {
            
        	error.appendTo(element.siblings("label"));
            
        }*/
    });

});