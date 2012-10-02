//= require jquery.easing
//= require carousel
//= require jquery.fancybox
//= require custom_categories
//= require jquery.easytabs.min

var pathname = window.location.pathname;

$("document").ready(function(){

		var tab = "";

		if(pathname == "/tukrok"){
			tab = "#tab-1-li";
		}

		if(pathname == "/faldekor"){
			tab = "#tab-3-li";
		}

		if(pathname == "/kiegeszitok"){
			tab = "#tab-4-li";
		}

		if(pathname == "/lampak"){
			tab = "#tab-5-li";
		}

		$('#tab-wrap').easytabs({defaultTab: tab});
});