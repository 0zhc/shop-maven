<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8"%>
<%@page import="com.shop.controller.ShoppingCartController"%>
<%@page import="com.shop.dao.GoodsDao"%>
<%@page import="com.shop.service.impl.GoodsServiceImpl"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%org.apache.struts.util.TokenProcessor.getInstance().saveToken(request); %>--%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>优复用</title>
<meta name="keywords" content="优复用;网上免费开店;网上购物;旅游快递;社区创业创业平台;社区创业综合网" />
<meta name="description" content="优复用——阳江社区校园消费综合网站.优复用更是专属广东海洋大学学子的综合服务平台,为学子提供周边商家购物、旅游、兼职及二手商品交易等服务;同时也为社区提供'免费开店' 的创业平台,让社区小本创业 自主经营。我们的宗旨:顾客至上，服务便民！让社区生活消费更省钱 省力 省时间,让社区创业、兼职更容易!" />
<link href="<%=path %>/css/index/index.css" type="text/css" rel="stylesheet" />
<link href="<%=path %>/css/index/ads.css" type="text/css" rel="stylesheet" />
<link href="<%=path %>/css/index/main_bottom.css" type="text/css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/Validform/css/css.css" />

<script type="text/javascript">
function check(i){
 	var price = document.getElementById("price"+i).value;
	var amount = document.getElementById("amount"+i).value;
	var stock = document.getElementById("stock"+i).value;
	var reg = /^[1-9][0-9]{0,}$/;
	if(amount=="" || amount==null){
		amount=1;
		document.getElementById("amount"+i).value="1";
		}
	if(!reg.test(amount)){
		amount=1;
		document.getElementById("amount"+i).value="1";
		}
	if(Number(amount)>Number(stock)){
		document.getElementById("amount"+i).value=stock;
		amount=stock;
		}
	var total = price*amount;
	document.getElementById("total"+i).innerHTML=total.toFixed(2)+"元";
 }
function checkName(){
reg=/^[\u4E00-\u9FA5]{2,5}$/;
	var receiverName = document.getElementById("receiverName").value;
if(!reg.test(receiverName)){
	alert("请输入正确的中文名！");
	document.getElementById("receiverName").value="";
}
}
function checkshortPhone(){
	reg=/^6\d{5}$/;
	var shortPhone = document.getElementById("shortPhone").value;
	if(shortPhone!=""){
	if(!reg.test(shortPhone)){
		alert("请输入正确的短号！ ");
		document.getElementById("shortPhone").value="";
		}
	}
}

function checkAddress(){
	reg=/^[\u4E00-\u9FA5_a-zA-Z0-9_]{1,30}$/;
	var address = document.getElementById("address").value;
	if(!reg.test(address)){
		alert("请输入送货地址 ");
		document.getElementById("address").value="";
	}
}


</script>

<style>
#container1{ width:980px; position:relative; left:50%; margin-left:-489px; }
#top1{ height:90px; clear:both; border-bottom: #EAEAEA solid 1px;}
#logo1{ float:left; height:90px; width:200px; background:url(<%=path %>/images/logo.jpg) no-repeat center center; }
#top_left1{ float:left; background:url(<%=path %>/images/shop/top_shop.gif) no-repeat left center; height:90px; width:792px; }
#banner1{ clear:both; height:45px; background:url(<%=path %>/images/shop/banner.gif) no-repeat left center; }
#car_img td{height:120px; border-bottom: #D6D6D6 solid 1px; }

#car_img{ background:url(<%=path %>/images/shop/shop_car.gif) no-repeat 250px center ;}
#car_div{ height:120px; width:300px; color:#333333; border: #FFFFFF solid 1px;}
#car_div_top{height:20px; width:300px; margin-top:50px; font-size:14px; font-family:宋体; text-align:left;  border: #FFFFFF solid 1px;}
#car_div_main{height:50px;  width:300px; font-size:13px; font-family:宋体; text-align:left;  border:#FFFFFF solid 1px;}

#title1{ height:20px; text-align:center; color:#333333; font-family:宋体; font-size:14px; font-weight:800;  border-bottom:#e9e9e9 solid 2px;}
.table_top td{ height:40px; color:#333333; font-family:宋体; font-size:15px; border-top: solid 2px #9bd4f5; border-bottom:solid 1px #aacded; background-color:#e9f4fd;}
.table_middle td{height:35px; color:#333333; font-family:宋体; font-size:14px; border-bottom: #D6D6D6 solid 1px; }
.table_foot td{height:40px; color:#333333; font-family:宋体; font-size:16px; border-bottom:solid 1px #9bd4f5; background-color: #EEF7FF;}
#contact{ margin-top:15px; margin-left:300px; margin-bottom:20px;}
a{ color:#208FFF; text-decoration:none;}
a:hover{ text-decoration:underline;}
</style>
    <link href="<%=path %>/css/index/cartOrderEnd_css.css" type="text/css" rel="stylesheet" />
</head>

<body >
<div class="backg2"></div>
   <div id="container">
     <div id="top">
        <ul id="top_left">
          <c:choose>
            <c:when test="${!empty user}">   <li style="margin-left:4px;">您好，欢迎(${user.callName })来到优复用！</li></c:when>
            <c:otherwise>
               <li style="margin-left:4px;">您好，欢迎来到优复用！</li>
              <li class="top_login"><a href="cjmqylogin/login.jsp">请登录</a></li>
               <li class="top_rigister"><a href="cjmqylogin/res.jsp">免费注册</a></li>
             </c:otherwise>
          </c:choose>
            <li class="top_login"><a href="/index.jsp">返回首页</a></li>
        </ul>
        <ul id="top_right" style="margin-left: 250px;">
           <li ><a href="<%=request.getContextPath() %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
          <li><a href="<%=request.getContextPath() %>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
          <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
          <li id="trade_record"  style="padding-right:5px;"><a href="" style="background-image:url(../../images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
              <ul  class="trade_main">
                  <li style="background-position:right center;" ><a href="<%=request.getContextPath()%>/system/manager_index.jsp?type=bought">已买</a></li>
                   <li style="background-position:right center;padding-right:0px;"><a href="<%=request.getContextPath()%>/system/manager_index.jsp?type=sold">已卖</a></li>
              </ul>
          </li>
          
        <li id="collect_file"><a href="#" style="background-image:url(../../images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:8px; ">收藏夹</a>
              <ul class="store_main">
                   <li style="background-position:right center; " ><a href="<%=path %>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                   <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a href="<%=path %>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
              </ul>
          </li>
         <c:if test="${! empty user}">
         <li><a href="<%=path %>/user/loginOut.do">注销</a></li>
         </c:if>
       </ul>
     </div>
    <!-- banner -->
     <div id="banner_top" style="clear:both; height: 40px;width: 974px; ">
          <a href=""><img src="<%=path%>/images/banners/taobao.jpg" /></a> 

     </div>

<div id="container1" >
	 <div id="top1" style="height: 100px;">
    	<div id="logo1" style="width: 180px"></div>
        <div id="top_left1"></div>
    </div>
	<div id="banner1"></div>
  <div id="title1">购物车商品</div>
<div style="margin: 100px;text-align: center; font-size: 18px;">${success } ${errorInfo }</div> 


   
   </div>
  
     
     </div>
 
</body>
</html>
