$(function(){
		    var timeId;


           $("#main_right_top_top>ul>li>a").each(function(index){
		    var nodethis=$(this);
		   $(this).mouseover(function(){
		    
	    
		     
		     timeId=setTimeout(function(){
			  
		      $("#main_right_top_middle>div").hide();
		     $("#main_right_top_middle>div").eq(index).show();
			 $("#main_right_top_top>ul>li>a").css("background-image","none");
			 $(nodethis).css("background-image","url(images/index/main_right_hover.jpg)");
			  
			 
			  },0);
			 }).css("cursor","pointer").mouseout(function(){
			   clearTimeout(timeId);
			 
			 });
	      });
		   
		   
		   
		   
		   })