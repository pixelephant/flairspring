//= require jquery.easing
//= require carousel
//= require jquery.fancybox


/**
 * jQuery.ScrollTo - Easy element scrolling using jQuery.
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 5/25/2009
 * @author Ariel Flesler
 * @version 1.4.2
 *
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 */
;(function(d){var k=d.scrollTo=function(a,i,e){d(window).scrollTo(a,i,e)};k.defaults={axis:'xy',duration:parseFloat(d.fn.jquery)>=1.3?0:1};k.window=function(a){return d(window)._scrollable()};d.fn._scrollable=function(){return this.map(function(){var a=this,i=!a.nodeName||d.inArray(a.nodeName.toLowerCase(),['iframe','#document','html','body'])!=-1;if(!i)return a;var e=(a.contentWindow||a).document||a.ownerDocument||a;return d.browser.safari||e.compatMode=='BackCompat'?e.body:e.documentElement})};d.fn.scrollTo=function(n,j,b){if(typeof j=='object'){b=j;j=0}if(typeof b=='function')b={onAfter:b};if(n=='max')n=9e9;b=d.extend({},k.defaults,b);j=j||b.speed||b.duration;b.queue=b.queue&&b.axis.length>1;if(b.queue)j/=2;b.offset=p(b.offset);b.over=p(b.over);return this._scrollable().each(function(){var q=this,r=d(q),f=n,s,g={},u=r.is('html,body');switch(typeof f){case'number':case'string':if(/^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(f)){f=p(f);break}f=d(f,this);case'object':if(f.is||f.style)s=(f=d(f)).offset()}d.each(b.axis.split(''),function(a,i){var e=i=='x'?'Left':'Top',h=e.toLowerCase(),c='scroll'+e,l=q[c],m=k.max(q,i);if(s){g[c]=s[h]+(u?0:l-r.offset()[h]);if(b.margin){g[c]-=parseInt(f.css('margin'+e))||0;g[c]-=parseInt(f.css('border'+e+'Width'))||0}g[c]+=b.offset[h]||0;if(b.over[h])g[c]+=f[i=='x'?'width':'height']()*b.over[h]}else{var o=f[h];g[c]=o.slice&&o.slice(-1)=='%'?parseFloat(o)/100*m:o}if(/^\d+$/.test(g[c]))g[c]=g[c]<=0?0:Math.min(g[c],m);if(!a&&b.queue){if(l!=g[c])t(b.onAfterFirst);delete g[c]}});t(b.onAfter);function t(a){r.animate(g,j,b.easing,a&&function(){a.call(this,n,b)})}}).end()};k.max=function(a,i){var e=i=='x'?'Width':'Height',h='scroll'+e;if(!d(a).is('html,body'))return a[h]-d(a)[e.toLowerCase()]();var c='client'+e,l=a.ownerDocument.documentElement,m=a.ownerDocument.body;return Math.max(l[h],m[h])-Math.min(l[c],m[c])};function p(a){return typeof a=='object'?a:{top:a,left:a}}})(jQuery);

function change_slide(){
	// if($("#slide-6-thumb").hasClass("active")){
 //   		$('#slide-1-thumb').trigger("click");
 //   }else{
 //   		$(".active").next().trigger("click");
 //   }
}

function main_slide(){
	// main_slider_inter = setInterval(function(){change_slide()}, 12000);
}

$(document).ready(function(){

var main_slider_inter = setInterval(function(){change_slide()}, 12000); // 100 milliseconds

$("#slider, #slider-thumbs, #fancybox-overlay, .fancybox-wrap").hover(
  // function () {
  //   clearInterval(main_slider_inter);
  // }, 
  // function () {
  //   main_slide();
  // }
);

var sdiv = $("#newest-products .slider-inner");

    // increase the scroll position by 10 px every 10th of a second
    var inter = setInterval(function() { 
         sdiv.scrollLeft(sdiv.scrollLeft()+1);
    }, 100); // 100 milliseconds

    $("#newest-products .left,#newest-products .right").click(function(){
    	clearInterval(inter);
    })

    $("#newest-products li").mouseenter(function(){
    	clearInterval(inter);
    })


	$(".fancybox").fancybox({
			type : 'ajax',
			openEffect	: 'elastic',
			closeEffect	: 'elastic',
			width:"980px",
			arrows: true,
			nextEffect: "none",
			prevEffect: "none"
		});
	
	// var myPlayer = _V_("example_video_1");
	// _V_("example_video_1").ready(function(){
	// 	var myPlayer = this;
	// });

	// myPlayer.addEvent("ended",function(){
	// 	$(myPlayer.posterImage.el).show();
	// });

	// var myPlayer2 = _V_("example_video_2");
	// _V_("example_video_2").ready(function(){
	// 	var myPlayer2 = this;
	// });

	// myPlayer2.addEvent("ended",function(){
	// 	$(myPlayer2.posterImage.el).show();
	// });

	$("#slider-thumbs li").click(function(){
		clearInterval(main_slider_inter);
		var $this = $(this);
		$this.siblings().removeClass("active").end().addClass("active");
		$("#slider").scrollTo($this.find("a").attr("href"),300,function(){
			if($this.find("a").attr("href") == "#slide-3"){
				// myPlayer.play();
				// myPlayer2.pause();
			}
			else if($this.find("a").attr("href") == "#slide-4"){
				// myPlayer2.play();
				// myPlayer.pause();
			}
		else{			
				// myPlayer.pause();
				// myPlayer2.pause();
		}
		},300);
		
		return false;
	});
	
});