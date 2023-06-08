<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script type="text/javascript">

	$(function(){
		
		//如果店铺公告全部为空，隐藏填写公告内容的表单,隐藏修改按钮
		if('${empty friendlinkList[0].urlText && empty friendlinkList[1].urlText && empty friendlinkList[2].urlText && empty friendlinkList[0].url && empty friendlinkList[1].url && empty friendlinkList[2].url}'=='true'){

			$("#addComplete").hide();
			$("#updateDecorate").hide();
			
		}else{
		//否则隐藏“马上添加”，,隐藏添加按钮
			$("#if_add").hide();
			$("#addDecorate").hide();
		}
		
		//如果修改成功，显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
		if('${!empty updateLinkSuccess}'=='true'){

			$("#modifyLinkSuccess").show();
		}else{
		//否则不显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
			$("#modifyLinkSuccess").hide();
		}
		
		//如果添加成功，显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
		if('${!empty AddLinkSuccess}'=='true'){

			$("#addFriendLinkSuccess").show();
		}else{
		//否则不显示 “添加信息成功,请先关闭窗口当前窗口，然刷新页面”
			$("#addFriendLinkSuccess").hide();
		}	
	})
	
	//点击马上添加，秀出填写公告内容的表单
	$(function(){
		$("#add").click(function(){
			$("#addComplete").show();
			$("#if_add").hide();
		})
	})	



    //使用jq,使商家填写友情链接时显示提示内容
    $(function(){
		$(".new").focus(function(){
			  $(this).addClass("focus");
			  $(this).next("span").show(); 
			  $(this).next("span").next("span").html("");
		}).blur(function(){
			 $(this).removeClass("focus");
			 $(this).next("span").hide();
		});
    })
    
   
	 $(function(){
		$(".new_ul").focus(function(){
			  $(this).addClass("focus"); 
			  $(this).next("span").show();
			  $(this).next("span").next("span").html("");   
		}).blur(function(){
			 $(this).removeClass("focus");
			 $(this).next("span").hide();
		})	
    })
    
    //验证商家第一条友情链接名称
	function validateoneLinkName(){
	
		//将中文字符转换为两个字符
		String.prototype.len= function (){                  
			return this .replace(/[^\x00-\xff]/g, "rr" ).length;           
		}   
	
		var oneLinkName=document.getElementById("oneLinkNameId").value;
		var reg=/^[\u4E00-\u9FA5\a-zA-Z0-9]{0,}$/;
		
		if(oneLinkName==""){//第一条友情链接名称不能为空
			document.getElementById("oneLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接不能为空</font>";
			return false;
		}else if(oneLinkName.len()<4){
			document.getElementById("oneLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接小于4个字符</font>";
			return false;
		}else if(oneLinkName.len()>30){
			document.getElementById("oneLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接大于于30个字符</font>";
			return false;
		}else if(!reg.test(oneLinkName)){
			document.getElementById("oneLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接含有特殊字符</font>";
			return false;
		}else{
			document.getElementById("oneLinkNameSpan").innerHTML="";
			return true;
		}
	}
	
	//验证商家第一条友情链接网址
	function validateoneLinkUrl(){//第一条友情链接网址不能为空
		var oneLinkUrl=document.getElementById("oneLinkUrlId").value;
		var reg=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		
		 if(oneLinkUrl==""){
			document.getElementById("oneLinkUrlSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入网址不能为空</font>";
			return false;
		}else if(!reg.test(oneLinkUrl)){
			document.getElementById("oneLinkUrlSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入网址格式不正确</font>";
			return false;
		}else{
			document.getElementById("oneLinkUrlSpan").innerHTML="";
			return true;
		}
	}
	
	//验证商家第二条友情链接名称
	function validatetwoLinkName(){
	
		//将中文字符转换为两个字符
		String.prototype.len= function (){                  
			return this .replace(/[^\x00-\xff]/g, "rr" ).length;           
		}   
	
		var twoLinkName=document.getElementById("twoLinkNameId").value;
		var reg=/^[\u4E00-\u9FA5\a-zA-Z0-9]{0,}$/;
		
		if(twoLinkName==""){
			document.getElementById("twoLinkNameSpan").innerHTML="";
			return true;
		}else if(twoLinkName.len()<4){
			document.getElementById("twoLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接小于4个字符</font>";
			return false;
		}else if(twoLinkName.len()>30){
			document.getElementById("twoLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接大于于30个字符</font>";
			return false;
		}else if(!reg.test(twoLinkName)){
			document.getElementById("twoLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接含有特殊字符</font>";
			return false;
		}else{
			document.getElementById("twoLinkNameSpan").innerHTML="";
			return true;
		}
	}
	
	//验证商家第二条友情链接网址
	function validatetwoLinkUrl(){
		var twoLinkUrl=document.getElementById("twoLinkUrlId").value;
		var reg=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		
		 if(twoLinkUrl==""){
			document.getElementById("twoLinkUrlSpan").innerHTML="";
			return true;
		}else if(!reg.test(twoLinkUrl)){
			document.getElementById("twoLinkUrlSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入网址格式不正确</font>";
			return false;
		}else{
			document.getElementById("twoLinkUrlSpan").innerHTML="";
			return true;
		}
	}
	
	//验证商家第三条友情链接名称
	function validatethreeLinkName(){
	
		//将中文字符转换为两个字符
		String.prototype.len= function (){                  
			return this .replace(/[^\x00-\xff]/g, "rr" ).length;           
		}   
	
		var threeLinkName=document.getElementById("threeLinkNameId").value;
		var reg=/^[\u4E00-\u9FA5\a-zA-Z0-9]{0,}$/;
		
		if(threeLinkName==""){
			document.getElementById("threeLinkNameSpan").innerHTML="";
			return true;
		}else if(threeLinkName.len()<4){
			document.getElementById("threeLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接小于4个字符</font>";
			return false;
		}else if(threeLinkName.len()>30){
			document.getElementById("threeLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接大于于30个字符</font>";
			return false;
		}else if(!reg.test(threeLinkName)){
			document.getElementById("threeLinkNameSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入友情链接含有特殊字符</font>";
			return false;
		}else{
			document.getElementById("threeLinkNameSpan").innerHTML="";
			return true;
		}
	}
	
	//验证商家第三条友情链接网址
	function validatethreeLinkUrl(){
		var threeLinkUrl=document.getElementById("threeLinkUrlId").value;
		var reg=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
		
		 if(threeLinkUrl==""){
			document.getElementById("threeLinkUrlSpan").innerHTML="";
			return true;
		}else if(!reg.test(threeLinkUrl)){
			document.getElementById("threeLinkUrlSpan").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入网址格式不正确</font>";
			return false;
		}else{
			document.getElementById("threeLinkUrlSpan").innerHTML="";
			return true;
		}
	}
    
    //第一次按修改按钮，提交表单增加友情链接内容
	  function addFriendLink() {
	  
		  with (document.getElementById("regForm")) {
			 action="<%=request.getContextPath()%>/addFriendLink.do?userId=${userId}";
			 method="post";
			 
			 if(validateForm()){
			 	submit();
			 	}
		 }
		}
	
	//按修改按钮，提交表单修改公告内容
	  function modifyFriendLink() {
	  
		  with (document.getElementById("regForm")) {
			 action="<%=request.getContextPath()%>/modifyFriendlink.do?userId=${userId}";
			 method="post";
			 
			 if(validateForm()){
			 	submit();
			 	}
		 }
		}
	
	//表单提交验证
	function validateForm(){
    	return validateoneLinkName()&&validateoneLinkUrl()&&validatetwoLinkName()&&validatetwoLinkUrl()&&validatethreeLinkName()&&validatethreeLinkUrl();
	}
	
</script>

<style type="text/css">
	*{margin: 0px; padding: 0px; }
	#modify_link{margin-top:20px; margin-left:33px;}
	#if_add{ width:700px; margin-top:15px; margin-left:20px; font-family:宋体; font-size:14px; color:#424242; }
	#addComplete{width:700px; margin-left:20px; }
	#addComplete div{ margin-top:8px; font-family:宋体; font-size:14px; color:#424242; }
	#modifyLinkSuccess,#addFriendLinkSuccess{height:30px; margin-top:12px; margin-left:40px; font-family:宋体; font-size:14px; color:#FF7D7D;}
		
	#addDecorate,#updateDecorate{ margin-left:180px;}
	
	.new{ width:200px; color:#2D2D2D;}
	.new_ul{ width:200px; color:#2D2D2D;}
	#decorate{ margin-left:100px;}
	#if_add{ padding-left:12px;}
	#if_add a{ text-decoration:none; color:#969696;}
	#if_add a:hover{color:#424242;}
	.link_name{color: #CC0000; display:none;}
	.link_url{color: #CC0000; display:none;}
	.focus { border:#60C8FD 1px solid; background:#CEEFFF;} 
		
</style>

</head>
  
  <body>



  <div id="modify_link">
<form action="" method="post" id="regForm">
		<fieldset>
			<legend>友情链接</legend>
            	<div id="if_add"><span>你还没有添加最新动态信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><a id="add" href="#">马上添加</a></div>
				<div id="addComplete">
				<div>
					<label  >1、友情链接网站名称：<span style="color: red;">*</span></label>
					<input class="new" id="oneLinkNameId" type="text" maxlength="35" name="oneLinkName" value="${friendlinkList[0].urlText}" onBlur="validateoneLinkName()" />&nbsp;<span class="link_name">不能为空、只能用中文、英文、数字、4-30个字符</span><span id="oneLinkNameSpan"></span>
				</div>
                <div>
					<label  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网站网址：<span style="color: red;">*</span></label>
                	<input class="new_ul" id="oneLinkUrlId" type="text" maxlength="60" name="oneLinkUrl" value="http://${fn:substringAfter(friendlinkList[0].url,'http://')}" onBlur="validateoneLinkUrl()"/>&nbsp;<span class="link_url">第一条友情链接网址不能为空</span><span id="oneLinkUrlSpan"></span>
				</div>
                <div>
					<label >2、友情链接网站名称：&nbsp;</label>
					<input class="new" id="twoLinkNameId" type="text" maxlength="35" name="twoLinkName" value="${friendlinkList[1].urlText}" onBlur="validatetwoLinkName()"  />&nbsp;<span class="link_name">只能用中文、英文、数字、4-30个字符</span><span id="twoLinkNameSpan"></span>
				</div>
                <div>
					<label  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网站网址：</label>
                	<input class="new_ul" id="twoLinkUrlId" type="text" maxlength="60" name="twoLinkUrl"  value="http://${fn:substringAfter(friendlinkList[1].url,'http://')}" onBlur="validatetwoLinkUrl()"/>&nbsp;<span class="link_url">请输入正确的网址</span><span id="twoLinkUrlSpan"></span>
                </div>
                <div>
					<label >3、友情链接网站名称：&nbsp;</label>
					<input class="new" id="threeLinkNameId" type="text" maxlength="35" name="threeLinkName" value="${friendlinkList[2].urlText}" onBlur="validatethreeLinkName()" />&nbsp;<span class="link_name">只能用中文、英文、数字、4-30个字符</span><span id="threeLinkNameSpan"></span>
				</div>
                <div>
					<label  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网站网址：</label>
                	<input class="new_ul" id="threeLinkUrlId" type="text" maxlength="60" name="threeLinkUrl"  value="http://${fn:substringAfter(friendlinkList[2].url,'http://')}" onBlur="validatethreeLinkUrl()" />&nbsp;<span class="link_url">请输入正确的网址</span><span id="threeLinkUrlSpan"></span>
                </div>
                <div>
					<input id="addDecorate"  type="button" value="添加" onClick="addFriendLink()"/> 
					<input id="updateDecorate"  type="button" value="修改" onClick="modifyFriendLink()"/>
				</div>
			</div>
			<div id="modifyLinkSuccess">
				<span>修改信息成功,请先关闭窗口当前窗口，然刷新页面</span>
			</div>
			<div id="addFriendLinkSuccess">
				<span>添加信息成功,请先关闭窗口当前窗口，然刷新页面</span>
			</div>
		</fieldset>
</form>
</div>
  </body>
</html>
