<%@ page language="java" import="java.util.*,com.cjmqy.shop.entity.*"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<link  href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />

</head>

<body>
<div  id="content">
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">警告成功</a></div>
      <form action="#">
        <table border="0" cellspacing="0"  class="myshop">
          <tr>
			  <td  style="text-align:center;font-size:15px;">已向被投诉人发出警告！<a href="javaScript:history.back()">返回</a></td>	
             			
			</tr>
        </table>
  </form>
</div>
</body>
</html>
