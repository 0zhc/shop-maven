<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'promptMiddle.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
  <script type="text/javascript">
     function goPrompt(){
          window.location.href='<%=path %>/system/shop/prompt.do?type=prompt';  
     }
     function remove_loading() {

     var targelem = document.getElementById('loader_container');
     targelem.style.display = 'none';
     targelem.style.visibility = 'hidden';
     }
     function RollingSet(){
      window.parent.RollingSet();
      }
       function ShowHotGoodsSet(){
  window.parent.ShowHotGoodsSet();
 }
  function ShowNewGoodsSet(){
 window.parent.ShowNewGoodsSet();
 }
  function ShowSecondSet(){
   window.parent.ShowSecondSet();
 }
  function ShowOtherSet(){
  window.parent.ShowOtherSet();
 }
 function ShowOrder(urlPath){
     window.parent.ShowOrder(urlPath);
 }
 function ShowCart(urlPath){
     window.parent.ShowCart(urlPath);
 }
</script>

<script type="text/javascript" language="javascript">
	//wuyixin
	//iframe自适应高度 
	function iFrameHeight() { 
		var ifm= document.getElementById("mainRight"); 
		var subWeb = document.frames ? document.frames["mainRight"].document : ifm.contentDocument; 
		if(ifm != null && subWeb != null) { 
		ifm.height = subWeb.body.scrollHeight; 
	} 
} 
</script>

<style type="text/css">
   *{padding: 0px; margin: 0px;}

</style>
  </head>
  <!-- onload="goPrompt()" -->
  <body  onload="remove_loading()">
   <iframe src="<%=path %>/shop/pro_detail.do?goodsId=${param.goodsId }&template=${param.template}"  width="942" marginwidth="0" marginheight="0" frameborder="0"  scrolling="no" name="mainRight" id="mainRight" onLoad="iFrameHeight()"></iframe>
<div id="loader_container" style="text-align: center; position: absolute; left: 300px; top: 100px;"><img src="<%=path %>/system/shop/myshop/loading.gif"/></div>
  </body>
</html>
