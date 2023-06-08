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
<style type="text/css">
#content {
	
	font-size:14px;
}
table td {
	border-right: 1px solid #CCC;
	border-bottom: 1px solid #CCC;
}
table {
	border-top: 1px solid #CCC;
	border-left: 1px solid #CCC;
}
table th { background-color:#CCC;
border-right: 1px solid #999;
	border-bottom: 1px solid #999;
}
/*a { color:#666; text-decoration:none;}*/
a:hover {top:1px; left:1px; position:relative;}

</style>

</head>

<body>
<div  id="content" style="width:950px;margin-left: 35px;" >
      <form action="#">
     <table  class="myshop" style="width: 100%;">
         <tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
           <th colspan="2">首页<span>>></span>店铺装修<span>>></span>最新设置>>查看商品详细信息</td>
           
         </tr>

		   <tr >
           <td width="75" style="padding-left:10px; padding-right:10px;">商品成色</td>
		   <td>
		   <c:choose>
		     <c:when test="${goods.goodsIsNew==1}">
		                  全新
		     </c:when>
             <c:otherwise>
                                            二手
             </c:otherwise>
		   </c:choose>
		   
		  </td>
		   </td>
       </tr>
  
		 <tr >
           <td width="75" style="padding-left:10px; padding-right:10px;">商品名称</td><td>${goods.name}&nbsp;</td>
          
           
       </tr>


        
          <tr>
            <td width="75"  style=" padding-left:10px; padding-right:10px;">商品地址</td><td> <%=basePath %>${goods.url}</td>           
       </tr>
         
		 <tr>
           <td width="75"  rowspan=3 style=" padding-left:10px; padding-right:10px;">商品信息</td>
		   <td  style="padding-left:5px;">
		   商品价格：${goods.price}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品类别：${goods.goodsType}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品品牌：${goods.brand}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        商品颜色：${goods.color}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        商品数量：${goods.amount}${goods.amountUnit}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        商品大小：${goods.size}${goods.sizeUnit}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        商品产生地：${goods.origin}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        商品产生商：${goods.productAdd}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   </td>      
       </tr>
         
         <tr>
		   <td  style="padding-left:5px;">
		   商品尺寸：${goods.size}英寸&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品数量：${goods.amount}件&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品颜色：${goods.color}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   </td>      
         </tr>
         
		 <tr>
		   <td  style="padding-left:5px;">
		   商品产地：${goods.origin}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品毛重：${goods.weight}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   生产厂家：${goods.productAdd}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   </td>      
         </tr>
		  
   
         <tr>
            <td width="75"  style=" padding-left:10px; padding-right:10px;">商品描述</td><td>${goods.description}&nbsp;</td>
           
       </tr>
          <tr>
            <td width="75"  style=" padding-left:10px; padding-right:10px;">商品图片</td><td><img src="<%=path %>/${goods.url}" width="369px" height="246px"/></td>           
       </tr>
         <tr style="text-align:center;">
           <td colspan="2">
           <a href="javascript:history.back()" style="font-size: 17px;">返回</a></td>
         
           
         </tr>
     </table>
     </form>
</div>
</body>
</html>
