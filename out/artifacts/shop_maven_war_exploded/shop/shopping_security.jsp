<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
<title>购物保障</title>
<%
     String template=request.getParameter("template");
     if(template!=null){
        if("1".equals(template)){
        %><link href="<%=request.getContextPath()%>/shop/shop_css/pro_scope.css" rel="stylesheet" /><!--这个是蓝色--><% 
        }
        else{
          %><link href="<%=request.getContextPath()%>/shop/shop_css/red/pro_red_scope.css" rel="stylesheet" /><!--这个是红色--><% 
        }
     }
         
 %>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>
<style type="text/css">
      .modifytip{ float:right; color:#0000FF; font-weight:bolder; font-size:14px; display:none; background-color:#FFFFFF;} 
	  .mymodify{ border:#FF0000 solid 1px;}
</style>
<script type="text/javascript">
     $(function(){
	     var isMoidfy='${param.isModify }';
	     if(isMoidfy==1){
	    
	     $("#shoppingcontianer").hover(function(){
		       $(this).css("border","red solid 1px");
			  $(this).children("a").show();
			
		 },function(){
		      $(this).css("border","none");
			  $(this).children(".modifytip").hide();
		 }).css("cursor","pointer"); 
               }
			
	 });
</script>
<script>
	
	function ShowSecurity(){
      var path='<%=request.getContextPath()%>/shop/shopModify/security/modify_securityMidd.jsp?userId='+'${userId}'+'&keepThis=true&TB_iframe=true&height=370&width=800';
       window.parent.ShowSecurity(path);
     }
</script>

<style type="text/css">
	#modify{  height:420px; }
	#modify_left,#modify_middle,#modify_right{float:left;  height:420px;}

	#modify_left{ width:12px; background: url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/modify_left.gif) no-repeat;}
	#modify_middle{ width:700px; background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/modify_middle.jpg) repeat-x; position:relative;}
	#modify_right{ width:12px; background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/modify_right.gif) no-repeat;}

	#close{float:right;position:absolute; top:8px; left:680px; }
	#close img{ border:none;}
</style>
</head>
  
<body>
<div id="shoppingcontianer" style="height:800px; width:922px; position:relative; overflow:hidden;">
        <a href="javascript:void(0)" title="Securiy" onclick="ShowSecurity()" class="modifytip" style="display:none;  position:absolute; left:730px; top:10px;">修改</a>

  		<div id="shoppingtip" style="font-size:16px;"><span style="margin-left:20px;">购物保障</span></div>

  		<div  style=" background-image:url(<%=request.getContextPath()%>/shop/shop_image/goodsdescripTipmiddle.jpg);width:922px; background-size: 922px; height: 20px; background-repeat:repeat-y; padding-left:10px; padding-right:10px;">
              ${shop.secureShop}
    	</div>

  		<div style="background-image:url(<%=request.getContextPath()%>/shop/shop_image/goodsdescripTipbottom.jpg); background-repeat:no-repeat; background-size: 922px; width:922px; height:19px;"></div>
</div>


</body>
</html>
