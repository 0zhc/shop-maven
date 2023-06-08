<%@ page language="java" import="java.util.*,com.shop.entity.*"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<script src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link  href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">

function checkStartDate(){
	var time = document.getElementById("startTime").value;
	if(time == "" || time == null){
			alert("请先选择起始日期!");
			orderForm.startTime.focus();
			return false;
		}else{
			return true;
			}	
}
function checkDate() {
	var startTime = document.getElementById("startTime").value;
	var endTime = document.getElementById("endTime").value;
	if(startTime !="" && endTime==""){
			alert("请选择结束日期!")
			orderForm.endTime.focus();
			return false;
		}
	if(endTime < startTime){
			alert("结束日期不能小于起始日期");
			orderForm.endTime.value="";
			return false;
	}
	if(endTime !=""){
		return checkStartDate();

	}
	return true;
	
}
function isSubmit(){
	return checkDate();
}


</script>
</head>

<body>
<div  id="content">
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">查看顾客订单</a></div>
      <form action="<%=request.getContextPath() %>/order/searchCusOrders.do" method="post" name="orderForm">
        <table border="0" cellspacing="0"  class="myshop">
          <tr >
            <td style="text-align:center; font-size:15px; height:30px;" colspan="9">订单号：
              <input type="text" name="orderNum"/>&nbsp;&nbsp;
订货时间：
<input type="text" name="startTime" id="startTime" style="width: 80px;" readonly="readonly" onClick="WdatePicker()"/>
——
<input type="text" name="endTime" style="width: 80px;" readonly="readonly" onClick="WdatePicker()" onFocus="checkStartDate()" />
&nbsp;&nbsp;状态：
<select name="state">
  <option value="0"></option>
  <option value="1">未发货</option>
  <option value="2">发货中</option>
  <option value="3">已交易</option>
</select></td>
          </tr>
          <tr >
           <td style="text-align:center; font-size:15px; height:30px;" colspan="9"><input type="submit" value="搜索" onFocus="checkDate()" />
            <input type="reset" name="button" id="button" value="重置" /></td>
          </tr>
          <c:if test="${page.num!=0}">
          <tr>
			  <td style="text-align:center;font-size:15px;" >订单号</td>	
              <td style="text-align:center;font-size:15px;" >商品名称</td>
              <td style="text-align:center;font-size:15px;" >订购数量</td>
              <td style="text-align:center;font-size:15px;" >订单金额</td>
              <td style="text-align:center;font-size:15px;" >顾客昵称</td>
              <td  style="text-align:center;font-size:15px;" >订货时间</td>	
              <td style="text-align:center;font-size:15px;" >订单状态</td>
              <td  style="text-align:center;font-size:15px;" >操作</td>				
			</tr>
		<c:forEach items="${goodsOrder}" var="goodsOrder" varStatus="status">
       	  <tr >
            <td style="text-align:center;font-size:15px;">${goodsOrder.orderNum }</td>
            <td style="text-align:center;font-size:15px;">${goodsOrder.good.name }</td>
            <td style="text-align:center;font-size:15px;" >${goodsOrder.amount }</td>
              <td style="text-align:center;font-size:15px;" >${goodsOrder.total }</td>
              <td style="text-align:center;font-size:15px;" >${goodsOrder.user.callName }</td>
            <td style="text-align:center;font-size:15px;">${goodsOrder.tradeTime }</td>
            <c:if test="${goodsOrder.state==1 }">
               <td align="left" style="text-align:left;font-size:15px;">未发货</td>
               </c:if>
               	<c:if test="${goodsOrder.state==2 }">
               <td align="left" style="text-align:left;font-size:15px;">发货中</td>
               </c:if>
               <c:if test="${goodsOrder.state==3 }">
               <td align="left" style="text-align:left;font-size:15px;">完成交易</td>
               </c:if>
            <td style="text-align:center;font-size:15px;"><a href="<%=request.getContextPath()%>/order/selectOrders.do?id=${goodsOrder.id}">查看</a>
            <c:if test="${goodsOrder.state==1 }">
            <a href="<%=request.getContextPath()%>/order/deliverGoods.do?id=${goodsOrder.id }" onClick="return confirm('是否发货？')">发货</a>
            </c:if>
            <c:if test="${goodsOrder.state!=1 }">
         	   已发货
            </c:if>
            <c:if test="${goodsOrder.state!=2 }">
            </c:if>
            <c:if test="${goodsOrder.state!=2 }">
            <a href="<%=request.getContextPath()%>/order/deleteOrder.do?id=${goodsOrder.id }" onClick="return confirm('是否删除?')">删除</a>
            </c:if>
            </td>
          </tr>
          </c:forEach>
           	  <tr>
			<td colspan="8" align="center">
			共${page.total}条记录 |  
			<c:if test="${!page.hasPrePage}"> 首页  | 上一页 |</c:if>
			<c:if test="${page.hasPrePage}">
			<a href="<%=request.getContextPath()%>/order/searchCusOrders.do?page=1">首页</a> | 
			<a href="<%=request.getContextPath()%>/order/searchCusOrders.do?page=${page.currentPage-1 }">上一页</a> |
			</c:if>
			<c:if test="${!page.hasNextPage}">下一页  | 尾页  | </c:if>
			<c:if test="${page.hasNextPage}">
			<a href="<%=request.getContextPath()%>/order/searchCusOrders.do?page=${page.currentPage+1 }">下一页</a> | 
			<a href="<%=request.getContextPath()%>/order/searchCusOrders.do?page=${page.num }">尾页</a> | 
			</c:if>
			 当前第${page.currentPage }页   | 共${page.num }页
			 
			</td> 
		</tr>
  		</c:if>
		<tr>
			<td colspan="8" align="center" height="50" valign="middle">
				<c:if test="${page.num==0}">记录为空！</c:if>
			</td>
			</tr>
        </table>
  </form>
</div>
</body>
</html>
