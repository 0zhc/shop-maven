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
  <script type="text/javascript">
     function goPrompt(){
          window.location.href='<%=path %>/system/shop/prompt.do?type=prompt';  
     }
     function remove_loading() {

     var targelem = document.getElementById('loader_container');
     targelem.style.display = 'none';
     targelem.style.visibility = 'hidden';
     }
  </script>
<style type="text/css">
   *{padding: 0px; margin: 0px;}

</style>
  </head>
  <!-- onload="goPrompt()" -->
  <body  onload="remove_loading()">
   <iframe src="<%=path %>/shop/selectRollingGoods.do?shopId=${user.shop.id }&typeJsp=selecSecondGoods"  width="100%" marginwidth="0" height="100%" marginheight="0" frameborder="0" ></iframe>
<div id="loader_container" style="text-align: center; position: absolute; left: 300px; top: 100px;"><img src="<%=path %>/system/shop/myshop/loading.gif"/></div>
  </body>
</html>
