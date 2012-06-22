// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require modernizr
//= require jquery
//= require jquery.fancybox

$(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
        settings.data = (settings.data ? settings.data + "&" : "")
            + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
    }
});

$("document").ready(function(){
	
  // The following is adapted from...
 
/*
 * TypeHelpers version 1.0
 * Zoltan Hawryluk, Nov 24 2009.  
 * 
 * Released under the MIT License. http://www.opensource.org/licenses/mit-license.php
 * 
 */
 
Modernizr.addTest('fontsmoothing', function() {
    // IE has screen.fontSmoothingEnabled - sweet!      
    if (typeof(screen.fontSmoothingEnabled) != "undefined") {
        return screen.fontSmoothingEnabled;
    } else {
        try {
            // Create a 35x35 Canvas block.
            var canvasNode = document.createElement("canvas")
              , test = false
              , fake = false
              , root = document.body || (function () {
                    fake = true;
                    return document.documentElement.appendChild(document.createElement('body'));
              }());
 
            canvasNode.width = "35";
            canvasNode.height = "35"
 
            // We must put this node into the body, otherwise 
            // Safari Windows does not report correctly.
            canvasNode.style.display = "none";
            root.appendChild(canvasNode);
            var ctx = canvasNode.getContext("2d");
 
            // draw a black letter "O", 32px Arial.
            ctx.textBaseline = "top";
            ctx.font = "32px Arial";
            ctx.fillStyle = "black";
            ctx.strokeStyle = "black";
 
            ctx.fillText("O", 0, 0);
 
            // start at (8,1) and search the canvas from left to right,
            // top to bottom to see if we can find a non-black pixel.  If
            // so we return true.
            for (var j = 8; j <= 32; j++) {
                for (var i = 1; i <= 32; i++) {
                    var imageData = ctx.getImageData(i, j, 1, 1).data;
                    var alpha = imageData[3];
 
                    if (alpha != 255 && alpha != 0) {
                        test = true; // font-smoothing must be on.
                        break;
                    }
                }
            }
 
            //clean up
            root.removeChild(canvasNode);
            if (fake) {
                document.documentElement.removeChild(root);
            }
 
            return test;
        }
        catch (ex) {
            root.removeChild(canvasNode);
            if (fake) {
                document.documentElement.removeChild(root);
            }
            // Something went wrong (for example, Opera cannot use the
            // canvas fillText() method.  Return false.
            return false;
        }
    }
});



  $("#properties-box input[type='submit']").click(function(){
    $.fancybox({
      href : "#alert-wrap",
      openEffect  : 'elastic',
      closeEffect : 'elastic',
      autoSize: true
    });
    return false;
  });

	$("a.tooltip").click(function(){
		return false;
	})
});
