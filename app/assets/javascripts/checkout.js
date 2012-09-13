//= require jquery.validate

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

  $("#checkout-form").validate({
      rules:{
       "payment[last_name]" : {
          required: true
        },
       "payment[first_name]" : {
          required: true
        },
       "payment[email]" : {
          required: true
        },
       "payment[phone]" : {
          required: true
        },
       "payment[shipping_name]" : {
          required: {
            depends: function(element) {
              return ($("#payment_personal_pickup").attr("checked") == undefined);
            }
          }
        },
       "payment[shipping_zip]" : {
          required: {
            depends: function(element) {
              return ($("#payment_personal_pickup").attr("checked") == undefined);
            }
          }
        },
       "payment[shipping_city]" : {
          required: {
            depends: function(element) {
              return ($("#payment_personal_pickup").attr("checked") == undefined);
            }
          }
        },
       "payment[shipping_additional]" : {
          required: {
            depends: function(element) {
              return ($("#payment_personal_pickup").attr("checked") == undefined);
            }
          }
        }
      }
    });

  $("#proceed-to-payment").click(function(){

    if($("#checkout-form").valid()){
      $("#csik").attr("src", "/assets/csik3.png");
      $("h3#top").html("Ellenőrzés &amp; Fizetés");
      $("#shipping-step").removeClass("active");
      $("#payment-step").addClass("active");
      $("#shipping-form").hide();
      $("#payment-form").show();
    }

    $('html, body').animate({scrollTop:500}, 'slow');    
    return false;
  });

  $("#back-to-shipping").click(function(){
    $("#csik").attr("src", "/assets/csik2.png");
    $("h3#top").html("Számlázás &amp; Szállítás");
    $("#shipping-step").addClass("active");
    $("#payment-step").removeClass("active");
    $("#payment-form").hide();
    $("#shipping-form").show();
    $('html, body').animate({scrollTop:500}, 'slow');
    return false;
  });


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
          $(".promo:first p").html("Regisztrációja sikeres! Ideiglenesen a rendeléshez használt email címével tud bejelentkezni. Jelszava szintén az email cím, melyet a megrendeléskor megadott!");
        }
    }});
    return false;
  });

});