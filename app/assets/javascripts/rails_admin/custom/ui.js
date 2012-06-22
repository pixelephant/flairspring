$("document").ready(function(){

		$(".ui-menu-item").live('click', function(){
			var category_id = $("#product_category_id_field option").val();
			
			var product_properties = new Array();

			$("#product_property_ids_field .ra-multiselect-right .ra-multiselect-selection option").each(function(i){
				product_properties.push(parseInt(this.value));
			});

			$.post("/admin_ajax/getcategoryproperties",{
    		category_id : category_id
    	},function(resp){
				if(resp.error == "none"){
//					$("#product_property_ids_field  .ra-multiselect-left  .ra-multiselect-collection").html("");
					var html = "";

			console.log(product_properties);

					$.each(resp.prop_ids, function(i, item){
						console.log(item);
						if($.inArray(item, product_properties) == -1){
							html += createOption(item, resp.prop_names[i]);
						}
					});
					$("#product_property_ids_field  .ra-multiselect-left  .ra-multiselect-collection").html(html);
				}
    	}, "json");
		});

});

function createOption(value, text){
	return '<option value="' + value + '">' + text + '</option>';
}
