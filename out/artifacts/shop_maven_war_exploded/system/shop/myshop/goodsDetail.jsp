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
<link href="../../../css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link href="../../../css/sysytem/myshop.css" type="text/css" rel="stylesheet" />

</head>

<body>
<div  id="content">
      <form action="#">
     <table  class="myshop">
         <tr style="line-height:21px;">
           <td colspan="2" ><a >首页</a><span>>></span><a >后台管理</a><span>>></span><a >我的商品</a></td>
           
         </tr>

		   <tr >
           <td style="padding-left:10px; padding-right:10px;">商品成色</td>
		   <td>
		   <c:choose>
		     <c:when test=" ${goods.goodsIsNew==1}">
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
           <td style="padding-left:10px; padding-right:10px;">商品名称</td><td>${goods.name}</td>
          
           
         </tr>


         <tr>
            <td  style=" padding-left:10px; padding-right:10px;">商品图片</td><td>${goods.goodsUrl}</td>           
         </tr>
         
		 <tr>
           <td  rowspan=3 style=" padding-left:10px; padding-right:10px;">商品信息</td>
		   <td  style="padding-left:5px;">
		   商品价格：${goods.price}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品类别：${goods.goodsType}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   商品品牌：${goods.brand}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
            <td  style=" padding-left:10px; padding-right:10px;">商品描述</td><td>${goods.description}！</td>
           
         </tr>
         
         <tr style="text-align:center;">
           <td>
           <a href="myproduct.html"></a></td><td><a href="../modiGoods.html">返回</a></td>
           </td>
           
         </tr>
     </table>
     </form>
</div>
</body>
</html>
