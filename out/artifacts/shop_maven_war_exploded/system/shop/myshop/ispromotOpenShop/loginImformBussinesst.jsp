<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<link  href="<%=path %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />

</head>

<body>
<div  id="content">
      <form action="<%=path %>/system/businessActiveCode.do">
        <table  class="myshop">
          <tr style="line-height:21px;">
            <td colspan="3" ><a href="../../../../index.html" target="_parent">首页</a><span>>></span><a href="../../../manager_index.html" target="_parent">后台管理</a><span>>></span>我的店铺商家开店登陆</td>
          </tr>
         
		 
       	  <tr >            
			
			<td  style="text-align:center;">
              激活码
            </td>
            <td  style="text-align:center;">
              <input type="text" name="activeCode"/>
            </td>
         
          </tr>
          
          
      
          <tr >            
			
			
            <td  style="text-align:center;" colspan="2">
              <c:if test="${!empty error}">
                <font style="color: red; font-size: 13px;">  你的激活码不正确或者不存在，请重新输入</font>
              </c:if>
              <input type="submit" value="激活" />
              <a href="contraUS.jsp">没有激活码么？</a>
              </td>
         
          </tr>
 		  
        </table>
      </form>
</div>
</body>
</html>
