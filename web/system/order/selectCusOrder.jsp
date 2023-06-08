<%@ page language="java" import="java.util.*,com.shop.entity.*"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的店铺</title>
    <link href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<div id="content">
    <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">查看顾客订单</a>
    </div>
    <form action="<%=request.getContextPath() %>/order/deliverGoods.do?id=${goodsOrder.id }" method="post">
        <table border="0" cellspacing="0" class="myshop">
            <c:if test="${goodsOrder.tag==1}">
            <tr>


                <td colspan="8" style="text-align:center; font-size:15px; height:30px;">
                    <input type="hidden" name="complaintId" value="${goodsOrder.id }">
                    <table width="100%" border="0" cellspacing="0">
                        <tr>
                            <td width="37%" align="right">订单号：</td>
                            <td width="63%" align="left">${goodsOrder.orderNum }</td>
                        </tr>
                        <tr>
                            <td align="right">商家店铺：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${goodsOrder.good.shop.name }</td>
                        </tr>
                        <tr>
                            <td align="right">商家昵称：</td>
                            <td align="left"
                                style="text-align:left;font-size:15px;">${goodsOrder.good.shop.user.callName }</td>
                        </tr>
                        <tr>
                            <td align="right">商品名称：</td>
                            <td align="left" style="font-size:15px;">${goodsOrder.good.name }</td>
                        </tr>
                        <tr>
                            <td align="right">商品价格：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${goodsOrder.good.price }元</td>
                        </tr>
                        <tr>
                            <td align="right">订购数量：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${goodsOrder.amount }</td>
                        </tr>
                        <tr>
                            <td align="right">订单金额：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${goodsOrder.total }</td>
                        </tr>
                        <tr>
                            <td align="right">订单状态：</td>
                            <c:if test="${goodsOrder.state==1 }">
                                <td align="left" style="text-align:left;font-size:15px;">未发货</td>
                            </c:if>
                            <c:if test="${goodsOrder.state==2 }">
                                <td align="left" style="text-align:left;font-size:15px;">发货中</td>
                            </c:if>
                            <c:if test="${goodsOrder.state==3 }">
                                <td align="left" style="text-align:left;font-size:15px;">完成交易</td>
                            </c:if>
                        </tr>
                        <tr>
                            <td align="right">订货时间：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${goodsOrder.tradeTime }</td>
                        </tr>
                        <tr>
                            <td align="right">收货人：</td>
                            <td align="left"
                                style="text-align:left;font-size:15px;">${receiveAddress.receiverName }</td>
                        </tr>
                        <tr>
                            <td align="right">联系电话：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${receiveAddress.phone }</td>
                        </tr>
                        <tr>
                            <td align="right">短号：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${receiveAddress.shortPhone }
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right">送货地址：</td>
                            <td align="left" style="text-align:left;font-size:15px;">${receiveAddress.address }</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <c:if test="${goodsOrder.state==1 }">
                                    <input type="submit" value="发货" onClick="return confirm('是否发货？')"/>
                                </c:if>
                                <input type="button" value="返回" onClick="javaScript:history.back()"/></td>
                        </tr>
                        </c:if>
                        <tr>
                            <td colspan="6" align="center" height="50" valign="middle">
                                <c:if test="${goodsOrder.tag==2}">对不起！订单已删除！<a href="javaScript:history.back()">返回</a></c:if>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>
