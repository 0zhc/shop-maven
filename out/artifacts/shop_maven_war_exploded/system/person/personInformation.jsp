<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link  href="<%=request.getContextPath()%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=request.getContextPath()%>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />
<title>个人信息修改</title>
<style type="text/css">
  table tr{text-align:center;}
</style>
</head>
  
  <body>
<div  id="content">

	  <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">修改个人信息</a></div>
      <form action="#">
        <table  class="myshop">

           <tr >      
				 <td>用户名</td>
				 <td>昵称</td>
			     <td>邮箱</td>
                 <td>性别</td>
                 <td>用户类型</td>       
          </tr>

           <tr >      
			 <td>${userRe.userName}</td>
			<td>${userRe.callName}</td>
             <td>${userRe.email}</td>
             <td>
             <c:choose>
             	<c:when test="${userRe.sex==1}">男</c:when>
				<c:otherwise>女</c:otherwise>
             </c:choose>
			 </td>
			 <td>${userRe.userType}</td>
          </tr>
           
          <tr >      
				 <td colspan="5" style="text-align: center;"  ><a href="<%=request.getContextPath()%>/updateByUserId.do?userId=${user.id}" target="mainContent">修改个人信息</a></td>
                 
          </tr>
        </table>
      </form>
</div>
</body>
</html>
