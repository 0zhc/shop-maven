<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

<style type="text/css">
td{height:20px;}

</style>

</head>

<body>
<div  id="content">
      <form action="#">
     <table width="500"  class="myshop">
     <tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
           <td colspan="2" ><a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">会员信息管理</a></td>           
         </tr>
         
         <tr >
           <td width="204"  style="padding-left:10px; width:100px;">账号</td>
		   <td  align="center" width="559">${userNew.userName }</td>   
       </tr>

		<tr >
           <td style="padding-left:10px; width:100px;">昵称</td>
		   <td align="center" width="559" >${userNew.callName }</td>            
       </tr>
         
         <tr>
           <td style=" padding-left:10px; width:100px;">邮箱</td>
           <td align="center" width="559" >${userNew.email }</td>
       </tr>
         
	     <tr>
           <td style=" padding-left:10px; width:100px;">QQ</td>
           <td align="center" width="559">${userNew.qq }</td>
       </tr>
		 
	    <tr>
           <td style=" padding-left:10px; width:100px;">注册时间</td>
           <td align="center" width="559">${userNew.createDateStr}</td>
       </tr
		 
         ><tr style="text-align:center;">
           <td colspan="2" style="text-align:center;">
		   <a href="javascript:history.go(-1);">返回</a></td>
         </tr>
     </table>
  </form>
</div>
</body>
</html>
