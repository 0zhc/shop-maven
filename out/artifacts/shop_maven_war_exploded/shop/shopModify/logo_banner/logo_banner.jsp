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
<title>修改商标和店招</title>
<style type="text/css">
body { background-color:#fafafa;}
#logo_banner {
	width: 500px;
	font-size: 14px;
}
table td {
	border-right: 1px solid #CCC;
	border-bottom: 1px solid #CCC;
}
table {
	border-top: 1px solid #CCC;
	border-left: 1px solid #CCC;
}
legend { margin-bottom: 10px;}
</style>

</head>

<body>
  <c:set value="${userNew.shop}" var="shop"></c:set>
<center>
<div id="logo_banner"  style="width: 1060px; height: 300px; margin-top: 20px;">
<fieldset>
<legend>店标&#8226;招牌设置</legend>
<table width="100%" border="0" cellspacing="0">

  <tr>
    <td  height="20" rowspan="2">店标图片：</td>
    <td align="center">
     <c:choose>
       <c:when test="${! empty shop.logoUrl}">
             <img src="<%=path %>/${shop.logoUrl}" width="131" height="88" />
       </c:when>
       <c:otherwise>
              你还没有logo请点击添加
       </c:otherwise>
     </c:choose>


     <br /></td>
  </tr>
  <tr>
    <td align="center">
     
      <c:choose>
         <c:when test="${! empty shop.logoUrl}">
               
             <a href="<%=path%>/shop/shopModify/logo_banner/shopDetail.do?shopId=${userNew.shop.id }&jspType=logo" >修改</a>
         </c:when>
         <c:otherwise>
             
              <a href="<%=path%>/shop/shopModify/logo_banner/addLogo.jsp" >添加</a>
         
         </c:otherwise>
      </c:choose>
 
     
      
      </td>     
  </tr>

 
  <tr>
    <td height="20" rowspan="2" >店铺招牌：</td>
      <td align="center"> 
       <c:choose>
           <c:when test="${! empty userNew.shop.bannerUrl}">
                <img src="<%=path %>/${shop.bannerUrl}" width="892px" height="92px" />
           </c:when>
           <c:otherwise>
               你没有添加banner请添加
           </c:otherwise>
       </c:choose>
    
      </td>
  </tr>
  <tr>
    <td align="center">
    
      <c:choose>
         <c:when test="${! empty userNew.shop.bannerUrl}">
               
             
            <a href="<%=path%>/shop/shopModify/logo_banner/shopDetail.do?shopId=${userNew.shop.id }&jspType=banner" >修改</a>
         </c:when>
         <c:otherwise>
             
              <a href="<%=path%>/shop/shopModify/logo_banner/addBanner.jsp" >添加</a>
         
         </c:otherwise>
      </c:choose>
     </td>
  </tr> 
  <tr>
      <td colspan="2" style="height: 100px;font-size: 14px;">温馨提示：添加/修改成功后，请重新筛新一些游览器或者按 F5即可看到查看店铺装修后的效果</td>
        </tr>
</table>
</fieldset>
</div>
</center>
</body>
</html>
