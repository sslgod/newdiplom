$(document).ready(function(){
	$('#add_welcome').live('click',function(){
		$('#info_to_hide').css('display','none');
		$('#show_welcome').css('display','block');
	});

	$('#submit_lib').live('click',function(){
		$.ajax({
			type: "POST",
			url: "/plan/save_lib",
			data: {table:$("#i17").attr("id")},
			success: function(html){
				$("body").append(html)
			}
		});

	});


	$("#exMenu #Save").live('click',function(){
		var d = mr("#formCreate");
		$.ajax({
			type: "POST",
			data: {data: d, table: $("#ex").attr("data-table")},
			url: "/act/save",
		});
		$("#ex").remove();
		$("#bg").remove();
		window.location = "" + window.location;
	});





});

