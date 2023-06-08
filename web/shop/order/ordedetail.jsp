<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%org.apache.struts.util.TokenProcessor.getInstance().saveToken(request); %>--%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/shop/order/otherProduct.css"/>

</head>

<body>
<center>
    <div id="content" style="width:530px;">
        <fieldset>
            <legend>购买产品->确认订单</legend>
            <form action="<%=request.getContextPath() %>/order/addOrder.do" method="post">
                <input type="hidden" name="goodsId" value="${good.id }"/>
                <input type="hidden" name="token" value="<%=session.getAttribute("TOKEN")%>" id="TOKEN"/>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>

                        <td width="31%" align="right" bgcolor="#F7F7F7">商品名称：</td>
                        <td width="69%">${good.name }</td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">商品价格：</td>
                        <td>${good.price }元</td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">商品数量：</td>
                        <td>${amount }<input type="hidden" name="amount" value="${amount }"/></td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">金额：</td>
                        <td>${total }<input type="hidden" name="total" value="${total }"/></td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">商家地点：</td>
                        <td>${good.shop.name }</td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">商家昵称：</td>
                        <td>${good.shop.user.callName }</td>
                    </tr>
                </table>


                <option>为了方便商家送货上门，请确认您的联系方式准确无误！</option>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="31%" align="right" bgcolor="#F7F7F7">收货人：</td>
                        <td width="69%" align="left">${receiveAddress.receiverName }<input type="hidden"
                                                                                           name="receiverName"
                                                                                           value="${receiveAddress.receiverName }"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">联系电话：</td>
                        <td align="left">${receiveAddress.phone }<input type="hidden" name="phone"
                                                                        value="${receiveAddress.phone }"/></td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">短号：</td>
                        <td align="left">${receiveAddress.shortPhone }&nbsp;<input type="hidden" name="shortPhone"
                                                                                   value="${receiveAddress.shortPhone }"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" bgcolor="#F7F7F7">送货地址：</td>
                        <td align="left">${receiveAddress.address }<input type="hidden" name="address"
                                                                          value="${receiveAddress.address }"/></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><input type="submit" name="button" id="button" value="确认提交"
                                                              onClick="return confirm('确认提交吗？')"/><input type="button"
                                                                                                         value="返回修改"
                                                                                                         onclick="history.back()"/>
                        </td>
                    </tr>
                </table>

            </form>
        </fieldset>
    </div>
</center>
</body>
</html>