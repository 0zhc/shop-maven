<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>cjmqy_system_login</title>
<style type="text/css">
   input{ width:200px;}
</style>
</head>

<body>
   <center>优复用系统管理员登录界面</center>
   <hr />
   <center>
         <form action="<%=request.getContextPath()%>/login.do?" method="post">
            账号: <input type="text"  name="userName" /><br />
            密码: <input type="password" name="userPassword" /><br />
             <input type="submit"  value="登录" style="width:50px;"/> <input type="reset"  value="重置" style="width:50px;"/>
             <input type="hidden" name="userType" value="2" />
         </form>
   </center>
    <hr />
</body>
</html>
