// JavaScript Document

 jQuery.fn.selectCity = function(targetId) {
	var _seft = this;
	var targetId = $(targetId);

	this.click(function(){
		var A_top = $(this).offset().top + $(this).outerHeight(true)+3;  //  1
		var A_left =  $(this).offset().left-300;
		targetId.bgiframe();
		targetId.show().css({"position":"absolute","top":A_top+"px" ,"left":A_left+"px"});
	});

	targetId.find("#selectItemClose").click(function(){
		targetId.hide();
	});

	targetId.find("#selectSub :checkbox").click(function(){		
		targetId.find(":checkbox").attr("checked",false);
		$(this).attr("checked",true);	
		_seft.val( $(this).val() );
	//	$("#key").val( $(this).val());
		targetId.hide();
	});

	$(document).click(function(event){
		if(event.target.id!=_seft.selector.substring(1)){
			targetId.hide();	
		}
	});

	targetId.click(function(e){
		e.stopPropagation(); //  2
	});

    return this;
}
 
$(function(){

	$("#address").selectCity("#selectItem");
	
	$("#address").css("cursor","pointer");
});