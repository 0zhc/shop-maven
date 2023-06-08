<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <legend>购买产品->购物车</legend>
            <form action="<%=request.getContextPath() %>/order/addOrder.do" method="post">
                <input type="hidden" name="goodsId" value="${good.id }"/>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>

                        <td align="center" height="100">已添加到购物车！</td>
                    </tr>

                    <tr>
                        <td align="center"><a href="javaScript:void(0)"
                                              onclick="window.open('<%=request.getContextPath() %>/cart/findAllGoodsInCart.do','_parent')">去购物车结算</a>
                        </td>
                    </tr>

                </table>

            </form>
        </fieldset>
    </div>
</center>
</body>
</html>