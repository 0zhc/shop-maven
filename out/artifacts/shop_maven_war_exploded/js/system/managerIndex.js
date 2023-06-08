// JavaScript Document
$(function(){
		   
		$("a").focus(function(){
		  $(this).blur();
		});   
		   
$("#collect_file").css("background-image","none");	
	$("#trade_record,#collect_file,#,#modifyShop").hover(function(){
			$(this).children("ul").fadeIn(600);	
			$(this).children("a").css("background-image","url("+path+"/images/index/tip1.jpg)");
													},
										function(){
													$(this).children("ul").stop(true,true).hide();	
															$(this).children("a").css("background-image","url("+path+"/images/index/tip.jpg)");
														
														});
	
	$("#search_main_top ul li").click(function(){
			$("#search_main_top ul li").removeClass("search_top_hover");
			$(this).addClass("search_top_hover");
												  
												  });
	
/*	$(".menu_tip").click(function(){
							  
				$(this).next("ul").toggle();			  
							  
							  });*/
	$(".comman ul li a").click(function(){
										$(".comman ul li a").css("background-image","none");
										$(this).css("background-image","url("+path+"/images/sysytem/menu_son_tip.jpg)");
										
										});
	
	
	
})




