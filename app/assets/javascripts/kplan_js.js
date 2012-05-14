$(document).ready(function(){
	$('#add_welcome').live('click',function(){
		$('#info_to_hide').css('display','none');
		$('#show_welcome').css('display','block');
	});
	
	$("form").keypress(function(e) {
  		if (e.which == 13) {
    		return false;
  		}
	});

	$(".tr_form").live('blur',function(){
		 alert("Welcome to RubyDev.ru!")
	});


});

