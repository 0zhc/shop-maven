<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/shop/order/otherProduct.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/Validform/css/css.css" />
  
<script type="text/javascript">
function total(){
	var price = $("#price").val();
	var amount = $("#amount").val();
	var total = (price*amount).toFixed(2);
	document.getElementById("total").value=total+"元";
}
function check(){
 	var price = $("#price").val();
	var amount = $("#amount").val();
	var stock = document.getElementById("stock").value;
	var reg = /^[1-9][0-9]{0,}$/;
	if(amount=="" || amount==null){
		amount=1;
		document.getElementById("amount").value="1";
		}
	if(!reg.test(amount)){
		amount=1;
		document.getElementById("amount").value="1";
		}
	if(Number(amount)>Number(stock)){
		document.getElementById("amount").value=stock;
		amount=stock;
		}
	var total = price*amount;
	document.getElementById("total").value=total.toFixed(2)+"元";
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
		document.getElementById("address").value="某校某楼某宿舍号";
	}
}


</script>

</head>

<body onload="total()">
<center>
<div  id="content" style=" width:550px;">
<fieldset>
<legend>购买产品->下订单</legend>
      <form action="<%=request.getContextPath() %>/order/confirmOrder.do" class="registerform" name="orderForm" method="post">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="31%" align="right">产品名称：</td>
    <td width="69%" align="left">${good.name}&nbsp;</td>
    <input type="hidden" name="goodsId" id="goodsId" value="${good.id }"/>
  </tr>
  <tr>
    <td align="right">单价：</td>
    <td align="left">${good.price }元</td>
     <input type="hidden" name="price" id="price" value="${good.price }" />
  </tr>
  <tr>
    <td align="right">购买数量：</td>
    <td align="left"><input type="text" name="amount" id="amount" class="inputxt" value="${amount }" onBlur="check()"/><span style="color:red;">*</span>(库存量有${good.amount }件)
    <input type="hidden" name="stock" id="stock" value="${good.amount }">
    </td>
  </tr>
  <tr>
    <td align="right">总额：</td>
    <td align="left"><input type="text" name="total" id="total" value="" readonly="readonly"   /></td>
  </tr>
  <tr>
    <td align="right">收货人：</td>
    <td align="left"><input type="text" name="receiverName" id="receiverName" onBlur="checkName()" datatype="*2-5" errormsg="请输入您的名字！"/><span style="color:red;">*</span>(中文名)</td>
  </tr>
  <tr>
    <td align="right">手机电话：</td>
    <td align="left"><input type="text" name="phone" id="phone" style="width:150px"  datatype="m" errormsg="请输入您的手机号码！" /><span style="color:red;">*</span></td>
  </tr>
  <tr>
    <td align="right">短号：</td>
    <td align="left"><input type="text" name="shortPhone" id="shortPhone" style="width:150px"  datatype="n" ignore="ignore" errormsg="请输入您的短号！" onBlur="checkshortPhone()"/></td>
  </tr>
  <tr>
    <td align="right">送货地址：</td>
    <td align="left"><input type="text" name="address" id="address" style="width:220px" onBlur="checkAddress()" datatype="*1-30" errormsg="请输入送货地址！" /><span style="color:red;">*</span>(限制30个字符)</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="submit" value="提交" /></td>
    </tr>
</table>

      </form>
  </fieldset>
  
<script type="text/javascript" src="<%=request.getContextPath() %>/Validform/js/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/Validform/js/Validform_min.js"></script>
<script type="text/javascript">
$(function(){
	$(".registerform").Validform();
})
	</script>
</div>
</center>
</body>
</html>
