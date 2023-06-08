// JavaScript Document

//构造参数对象并初始化 
function QueryString()
{
    var name,value,i; 
    var str=location.href;//获得浏览器地址栏URL串 
    var num=str.indexOf("?") 
    str=str.substr(num+1);//截取“?”后面的参数串 
    var arrtmp=str.split("&");//将各参数分离形成参数数组 
    for(i=0;i < arrtmp.length;i++)
    { 
        num=arrtmp[i].indexOf("="); 
        if(num>0)
        { 
            name=arrtmp[i].substring(0,num);//取得参数名称 
            value=arrtmp[i].substr(num+1);//取得参数值 
            this[name]=value;//定义对象属性并初始化 
        }
    }
}


$(function(){
var getValue = new QueryString();

var type=getValue.type;



switch (type)
   {
   case 'datail':
    
	
	 $("#links_top ul li a").css("background-image","url("+path+"/shop/shop_image/links_a.gif)");
	 $("#links_top ul li a ").eq(0).css("background-image","url("+path+"/shop/shop_image/links_a_home.gif)").css("color","#2D2D2D");
	 $("#links_top ul li a").eq(5).css("background-image","url("+path+"/shop/shop_image/links_hover.gif)").css("color","white");
	  $("#mainRight").attr("src","pro_detail.html");
	  break;
     
   
	
   default:
      $("#mainRight").attr("src","prolist.html");
  
     ;
}


     $("#links_top ul li a").click(function(){
	   
	   if($("#links_top ul li a").index(this)!=5 && $("#links_top ul li a").index(this)!=0 ){
	             $("#links_top ul li a").css("background-image","url("+path+"/shop/shop_image/links_a.gif)");
	         $("#links_top ul li a").eq(0).css("background-image","url("+path+"/shop/shop_image/links_a_home.gif)").css("color","#2D2D2D");
	      	 $("#links_top ul li a").css("color","#2D2D2D");
	  
		   $(this).css("background-image","url("+path+"/shop/shop_image/links_hover.gif)").css("color","white");
	   }
	   else{
	          if($("#links_top ul li a").index(this)==0){
			       	 $("#links_top ul li a").css("color","#2D2D2D");
			      $("#links_top ul li a").css("background-image","url("+path+"/shop/shop_image/links_a.gif)");  
			      $(this).css("background-image","url("+path+"/shop/shop_image/links_hover_home.gif)");
				  $(this).css("color","white");
				  
			  } 
	   }
	   
	   
	 });
	 
	  $("#links_top ul li a").eq(5).mouseover(function(){}).css("cursor","text");
	 
	 



})