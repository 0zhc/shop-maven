// JavaScript Document

//构造参数对象并初始化 



$(function(){



     $("#links_top ul li a").click(function(){
	   
	   if($("#links_top ul li a").index(this)!=5 && $("#links_top ul li a").index(this)!=0 ){
	             $("#links_top ul li a").css("background-image","url("+path+"/shop/shop_image/red/links_a.gif)");
	         $("#links_top ul li a").eq(0).css("background-image","url("+path+"/shop/shop_image/red/links_a_home.gif)").css("color","#2D2D2D");
	      	 $("#links_top ul li a").css("color","#2D2D2D");
	  
		   $(this).css("background-image","url("+path+"/shop/shop_image/red/links_hover.gif)").css("color","white");
	   }
	   else{
	          if($("#links_top ul li a").index(this)==0){
			       	 $("#links_top ul li a").css("color","#2D2D2D");
			      $("#links_top ul li a").css("background-image","url("+path+"/shop/shop_image/red/links_a.gif)");  
			      $(this).css("background-image","url("+path+"/shop/shop_image/red/links_hover_home.gif)");
				  $(this).css("color","white");
				  
			  } 
	   }
	   
	   
	 });
	 
	  $("#links_top ul li a").eq(5).mouseover(function(){}).css("cursor","text");
	 
	 



})