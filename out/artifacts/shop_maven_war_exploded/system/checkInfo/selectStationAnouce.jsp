<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8"%>
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
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">查看站内公告</a></div>
      <form action="<%=request.getContextPath() %>/stationAnnouce/modifyStationAnnouces.do" id="annouce" method="post" onSubmit="return isSubmit()">
     <input type="hidden" name="id" value="${stationAnnouce.id }"/>
     <table width="90%"  class="myshop">
         <tr >
           <td width="10%" align="center" style="padding-left:10px;">标题</td>
           <td colspan="3">
             ${stationAnnouce.title }
           </td>
         </tr>
         <tr>
           <td align="center" style=" padding-left:10px;">公告人</td>
           <td width="40%">${stationAnnouce.user.callName }</td>
           <td width="12%" align="center"><span style="padding-left:10px;">公告时间</span></td>
           <td width="38%">${stationAnnouce.inTime } </td>
         </tr>
         <tr>
           <td align="center" style=" padding-left:10px;">公告内容</td><td colspan="3">${stationAnnouce.content }</td>
         </tr>
         <tr style="text-align:center;">
          <td colspan="4"> <input type="button" value="返回" onClick="javaScript:history.back()"/></td>
         </tr>
        
     </table>
     </form>
</div>
</body>
</html>
