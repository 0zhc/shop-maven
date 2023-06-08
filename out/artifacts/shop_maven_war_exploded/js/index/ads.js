// JavaScript Document

 $(function(){
     var len  = $(".num > li").length;
	 var index = 0;
	 var adTimer;
	 $(".num li").mouseover(function(){
		index  =   $(".num li").index(this);
		showImg(index);
	 }).eq(0).mouseover();
	 $(".num li").mouseover(function(){}).css("cursor","pointer");
	 	
	 //滑入 停止动画，滑出开始动画.
	 $('.ad').hover(function(){
			 clearInterval(adTimer);
		 },function(){
			 adTimer = setInterval(function(){
			    showImg(index)
				index++;
				if(index==len){index=0;}
			  } , 3000);
	 }).trigger("mouseleave");
})
// 通过控制top ，来显示不同的幻灯片
function showImg(index){
        var adHeight = $(".ad").height();
		$(".slider").stop(true,false).animate({top : -adHeight*index},1000);
		$(".num li span").addClass("begeinColor");
		$(".num li span").removeClass("on")
			.eq(index).addClass("on").removeClass("begeinColor");;
}