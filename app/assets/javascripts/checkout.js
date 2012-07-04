$("document").ready(function(){
  if($("#cart-summary").offset() != null ){
  	var top = $('#cart-summary').offset().top - parseFloat($('#cart-summary').css('marginTop').replace(/auto/, 0));
    $(window).scroll(function (event) {
      // what the y position of the scroll is
      var y = $(this).scrollTop();

      // whether that's below the form
      if (y >= top) {
        // if so, ad the fixed class
        $('#cart-summary').addClass('fixed');
      } else {
        // otherwise remove it
        $('#cart-summary').removeClass('fixed');
      }
    });
  }





  $("#payment_same").change(function(){

    if($(this).is(":checked")){
      $("#payment_billing_name").val($("#payment_shipping_name").val());
      $("#payment_billing_zip").val($("#payment_shipping_zip").val());
      $("#payment_billing_city").val($("#payment_shipping_city").val());
      $("#payment_billing_additional").val($("#payment_shipping_additional").val());
    }
    else{
      $("#payment_billing_name").val("");
      $("#payment_billing_zip").val("");
      $("#payment_billing_city").val("");
      $("#payment_billing_additional").val("");
    }

  });


  $("#lazy-registration").click(function(){
    //ajax call
    $.ajax({
      type: 'POST',
      url: "/checkout/regisztralok",
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      success: function(resp){
        if(resp.status == 'true'){
          $("#lazy-registration").remove();
          $(".promo").append("Regisztrációja sikeres! Ideiglenesen a rendeléshez használt email címével tud bejelentkezni. Jelszava szintén az email cím, melyet a megrendeléskor megadott!");
        }
    }});
    return false;
  });

});