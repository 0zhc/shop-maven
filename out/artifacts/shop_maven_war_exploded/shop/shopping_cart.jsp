<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8" %>
<%@page import="com.shop.controller.ShoppingCartController" %>
<%@page import="com.shop.dao.GoodsDao" %>
<%@page import="com.shop.service.impl.GoodsServiceImpl" %>
<%@ page import="com.shop.entity.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%org.apache.struts.util.TokenProcessor.getInstance().saveToken(request); %>--%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="<%=path%>/css/loginAndrex/top_foot.css" rel="stylesheet"/>
    <link href="<%=path%>/css/loginAndrex/login2.css" rel="stylesheet"/>
    <link href="<%=path%>/css/loginAndrex/shopping_cart_css.css" rel="stylesheet"/>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/Validform/css/css.css"/>
    <title>购物车</title>
    <script src="<%=path%>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path%>/js/system/managerIndex.js"></script>
    <script src="<%=path%>/js/system/car_js.js"></script>
    <script type="text/javascript">
        var path = '<%=path%>';

        function check(i) {
            var price = document.getElementById("price" + i).value;
            var amount = document.getElementById("amount" + i).value;
            var stock = document.getElementById("stock" + i).value;
            var reg = /^[1-9][0-9]{0,}$/;
            if (amount == "" || amount == null) {
                amount = 1;
                document.getElementById("amount" + i).value = "1";
            }
            if (!reg.test(amount)) {
                amount = 1;
                document.getElementById("amount" + i).value = "1";
            }
            if (Number(amount) > Number(stock)) {
                document.getElementById("amount" + i).value = stock;
                amount = stock;
            }
            var total = price * amount;
            document.getElementById("total" + i).innerHTML = total.toFixed(2) + "元";
        }

        function checkName() {
            reg = /^[\u4E00-\u9FA5]{2,5}$/;
            var receiverName = document.getElementById("receiverName").value;
            if (!reg.test(receiverName)) {
                // alert("请输入正确的中文名！");
                this.nextElementSibling.innerHTML = ' 格式不正确，请从新输入 ';
                document.getElementById("receiverName").value = "";
            }
        }

        function checkshortPhone() {
            reg = /^6\d{5}$/;
            var shortPhone = document.getElementById("shortPhone").value;
            if (shortPhone != "") {
                if (!reg.test(shortPhone)) {
                    alert("请输入正确的短号！ ");
                    document.getElementById("shortPhone").value = "";
                }
            }
        }

        function checkAddress() {
            reg = /^[\u4E00-\u9FA5_a-zA-Z0-9_]{1,30}$/;
            var address = document.getElementById("address").value;
            if (!reg.test(address)) {
                alert("请输入送货地址 ");
                document.getElementById("address").value = "某校某楼某宿舍号";
            }
        }


    </script>

    <style>
        #container1 {
            width: 1200px;
        }

        #top1 {
            height: 90px;
            clear: both;
            border-bottom: #EAEAEA solid 1px;
        }

        #logo1 {
            float: left;
            height: 90px;
            width: 200px;
            background: url(<%=path %>/images/logo.jpg) no-repeat center center;
        }

        #top_left1 {
            float: left;
            background: url(<%=path %>/images/shop/top_shop.gif) no-repeat left center;
            height: 90px;
            width: 792px;
        }

        #banner1 {
            clear: both;
            height: 45px;
            background: url(<%=path %>/images/shop/banner.gif) no-repeat left center;
        }

        #car_img td {
            height: 120px;
            border-bottom: #D6D6D6 solid 1px;
        }

        #car_img {
            background: url(<%=path %>/images/shop/shop_car.gif) no-repeat 250px center;
        }

        #car_div {
            height: 120px;
            width: 300px;
            color: #333333;
            border: #FFFFFF solid 1px;
            margin-left: 380px;
        }

        #car_div_top {
            height: 20px;
            width: 304px;
            margin-top: 50px;
            font-size: 14px;
            font-family: 宋体;
            text-align: left;
            border: #FFFFFF solid 1px;
        }

        #car_div_main {
            height: 50px;
            width: 300px;
            font-size: 13px;
            font-family: 宋体;
            text-align: left;
            border: #FFFFFF solid 1px;
        }

        #title1 {
            height: 20px;
            text-align: center;
            color: #333333;
            font-family: 宋体;
            font-size: 14px;
            font-weight: 800;
            border-bottom: #e9e9e9 solid 2px;
        }

        .table_top td {
            height: 40px;
            color: #333333;
            font-family: 宋体;
            font-size: 15px;
            border-top: solid 2px #9bd4f5;
            border-bottom: solid 1px #aacded;
            background-color: #e9f4fd;
        }

        .table_middle td {
            height: 35px;
            color: #333333;
            font-family: 宋体;
            font-size: 14px;
            border-bottom: #D6D6D6 solid 1px;
        }

        .table_foot td {
            height: 40px;
            color: #333333;
            font-family: 宋体;
            font-size: 16px;
            border-bottom: solid 1px #9bd4f5;
            background-color: #EEF7FF;
        }

        #contact {
            margin-top: 15px;
            margin-bottom: 20px;
        }

        a {
            color: #208FFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .backg2 {
            position: absolute;
            width: 100%;
            height: 30px;
            background-color: #f1f1f1;
        }

        .line2 {
            position: absolute;
            z-index: 3;
            top: 569px;
            left: 496px;
        }

        .line2 ul li {
            float: left;
            margin-right: 99px;
            height: 14px;
            width: 1px;
            border-left: 1px solid #d7d7d7;
        }

        .line3 {
            position: absolute;
            z-index: 2;
            top: 7px;
            left: 843px;
        }

        .line3 ul li {
            float: left;
            margin-right: 63px;
            height: 14px;
            width: 1px;
            border-left: 1px solid #d7d7d7;
        }

        .line4 {
            position: absolute;
            z-index: 2;
            top: 8px;
            left: 862px;
            width: 210px;
            height: 12px;
        }

        .line4 ul li {
            float: left;
            margin-left: 101px;
            height: 14px;
            width: 1px;
            border-left: 1px solid #d7d7d7;
        }

        .line5 {
            position: absolute;
            width: 2px;
            z-index: 3;
            top: 8px;
            left: 235px;
        }

        .line5 ul li {
            float: left;
            margin-right: 63px;
            height: 14px;
            width: 1px;
            border-left: 1px solid #d7d7d7;
        }
    </style>

</head>


<body>
<div class="backg2"></div>

<div id="contain" style="padding-right:0px;">
    <div id="top" class="pos" style="width: 1200px;">
        <ul id="top_left" style="padding: 0px;margin: 0px;width:430px;">
            <li style="padding-left: 8px;">${user.userName }你好，欢迎来到优复用！</li>
            <li class="top_login"><a href="<%=path%>/index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right" style="padding: 0px;margin: 0px;">
            <li><a href="<%=path%>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath()%>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path%>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
            <li id="trade_record" style="padding-right:5px;"><a href="#"
                                                                style="background-image:url(../images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
                <ul class="trade_main">
                    <li style="background-position:right center;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=bought">已买</a></li>
                    <li style="background-position:right center;padding-right:0px;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=sold">已卖</a></li>
                </ul>
            </li>

            <li id="collect_file"><a href="#"
                                     style="background-image:url(../images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:8px; ">收藏夹</a>
                <ul class="store_main">
                    <li style="background-position:right center; "><a
                            href="<%=path%>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="<%=path%>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>
            <c:if test="${! empty user}">
                <li><a href="<%=path%>/user/loginOut.do">注销</a></li>
            </c:if>
        </ul>

    </div>

    <div id="content" style="margin-bottom:10px;">
        <div id="container1" class="pos" style="margin-left: 137px">
            <div id="top1" style="height: 100px;">
                <div id="logo1" style="width: 180px"></div>
                <div id="top_left1"></div>
            </div>

            <div id="banner1"></div>

            <div id="title1">购物车商品</div>
            <form action="<%=request.getContextPath() %>/order/addOrderInCart.do" method="post" class="registerform">
                <div>

                    <%
                        User user = (User) session.getAttribute("user");
                        if (session.getAttribute("cart" + user.getId()) == null) { %>
                    <div id="car_img">
                        <div id="car_div">
                            <div id="car_div_top">你的购物车里面没有还没有商品，赶紧行动吧！</div>
                            <div id="car_div_main">你现在也可以马上去 &nbsp;<a
                                    href="<%=request.getContextPath() %>/index.jsp">购物</a></div>
                        </div>
                    </div>
                    <%} else { %>
                    <input type="hidden" name="token" value="<%=session.getAttribute("TOKEN")%>" id="TOKEN"/>
                    <table width="100%" cellspacing="0">
                        <tr class="table_top">
                            <td align="center">序号</td>
                            <td align="center">产品名称</td>
                            <td align="center">店铺名称</td>
                            <td align="center">价格</td>
                            <td align="center">购买数量</td>
                            <td align="center">库存量</td>
                            <td align="center">总金额</td>
                            <td align="center">操作</td>
                        </tr>
                        <c:forEach items="${cartOrder}" var="cartOrder" varStatus="status">
                            <tr class="table_middle">
                                <%--序号--%>
                                <td align="center">${status.count }</td>
                                <%--产品名称--%>
                                <td align="center">${cartOrder.good.name }<input type="hidden" name="goodId"
                                                                                 value="${cartOrder.good.id }"/></td>
                                <%--店铺名称--%>
                                <td align="center">${cartOrder.good.shop.name }</td>
                                <%--单价--%>
                                <td align="center">${cartOrder.good.price }元
                                    <input type="hidden" id="price${status.count }" name="price${status.count }" value="${cartOrder.good.price }"/>
                                </td>
                                <%--购买数量--%>
                                <td align="center">
                                    <input type="text" value="${cartOrder.amount }" name="amountId"
                                                          id="amount${status.count }" onblur="check(${status.count })"
                                                          style="width=30px; text-align: center;"/>
                                </td>
                                <%--库存量--%>
                                <td align="center">${cartOrder.good.amount }
                                    <input type="hidden" name="stock" id="stock${status.count }"
                                           value="${cartOrder.good.amount }">
                                </td>
                                <%--总金额--%>
                                <td align="center">
                                    <span id="total${status.count }" value="${cartOrder.total }" >${cartOrder.total }</span>

                                </td>

                                <td align="center"><a
                                        href="<%=request.getContextPath() %>/cart/deleteGoodInCart.do?cartId=${status.count-1}">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr class="table_foot">
                            <td align="center" colspan="8"><a href="<%=path%>/index.jsp">继续购物</a></td>

                        </tr>
                    </table>
                </div>
                <div id="contact" style="float: left; padding-left:381px;">
                    <table width="423" cellspacing="0" style="border: 1px solid #C1C1C1;">

                        <tr class="table_top">
                            <td colspan="3" style="text-align:center;">请填写您的联系方式</td>
                        </tr>

                        <tr class="table_middle">
                            <td width="118">
                                <div align="right">收货人：</div>
                            </td>
                            <td width="168">
                                <input type="text" name="receiverName" id="receiverName" onBlur="checkName()"
                                       datatype="*2-5" errormsg="请输入您的名字！"/>

                            </td>

                            <td width="129">
                                <div align="left"><span style="color:red;">*</span>（中文名）</div>
                            </td>
                        </tr>

                        <tr class="table_middle">
                            <td>
                                <div align="right">手机号码：</div>
                            </td>
                            <td><input type="text" name="phone" id="phone" datatype="m" errormsg="请输入您的手机号码！"/></td>
                            <td>
                                <div align="left"><span style="color:red;">*</span></div>
                            </td>
                        </tr>

                        <tr class="table_middle">
                            <td>
                                <div align="right">短号：</div>
                            </td>
                            <td>
                                <input type="text" name="shortPhone" id="shortPhone" datatype="n" ignore="ignore"
                                       errormsg="请输入您的短号！" onBlur="checkshortPhone()"/>
                            </td>
                            <td>
                                <div align="left"></div>
                            </td>
                        </tr>

                        <tr class="table_middle">
                            <td>
                                <div align="right">送货地址：</div>
                            </td>
                            <td><input type="text" name="address" id="address" width="250px" onBlur="checkAddress()"
                                       datatype="*1-30" errormsg="请输入送货地址！"/></td>
                            <td>
                                <div align="left"><span style="color:red;">*</span>（限制30个字符）</div>
                            </td>
                        </tr>

                        <tr class="table_foot">
                            <td></td>
                            <td>
                                <input type="submit" name="input" style="width:60px;" value="结算"/>
                                <input type="reset" style="width:60px;" value="重置"/>
                            </td>
                            <td></td>
                        </tr>

                    </table>

                </div>
                <%} %>


            </form>


        </div>
    </div>

</div>
<div id="footer" style="clear:both;">
    <div id="foot_main">
        <ul>
            <li><a href="<%=path %>/help/help.jsp?menu=newMember&menuType=1">新手上路</a></li>
            <li><a href="<%=path %>/help/help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
            <li><a href="<%=path %>/help/help.jsp?menu=law&menuType=3">法律声明</a></li>
            <li><a href="<%=path %>/help/help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
        </ul>
    </div>
    <div style="position:absolute;top:60px; left: 729px;z-index: 9;clear:both; text-align:center;color:#9b9b9b; font-size:12px;">
        优复用
    </div>
    <div class="line2">
        <ul>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <div class="backg3"></div>
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/Validform/js/Validform_min.js"></script>

<script type="text/javascript">
    $(function () {
        $(".registerform").Validform();
    })
</script>
</body>
</html>
