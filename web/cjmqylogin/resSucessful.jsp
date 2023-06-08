<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="<%=path%>/css/loginAndrex/top_foot.css" rel="stylesheet"/>
    <link href="../css/loginAndrex/resSuccess.css" rel="stylesheet"/>
    <link href="../css/loginAndrex/resSuccess2.css" rel="stylesheet"/>
    <script type="text/javascript" src="../js/jquery-1.2.6.min.js"></script>
    <script src="../js/system/managerIndex.js"></script>
    <title>注册成功</title>

</head>

<body>
<div class="backg2"></div>
<div id="contain" style=" width:1200px;">
    <div id="top">
        <ul id="top_left">
            <li>你好，欢迎来到优复用！</li>
            <li class="top_login"><a href="../index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right">
            <li><a href="../system/manager_index.html?type=freeopenshop">免费开店</a></li>
            <li><a href="#" id="shop_car">购物车</a></li>
            <li><a href="../system/manager_index.html?type=freeopenshop">我要卖</a></li>
            <li id="trade_record" style="padding-right:5px;"><a href="#"
                                                                style="background-image:url(../images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
                <ul class="trade_main">
                    <li style="background-position:right center;"><a
                            href="../system/manager_index.html?type=bought">已买</a></li>
                    <li style="background-position:right center;padding-right:0px;"><a
                            href="../system/manager_index.html?type=sold">已卖</a></li>
                </ul>
            </li>

            <li id="collect_file"><a href="#"
                                     style="background-image:url(../images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:8px; ">收藏夹</a>
                <ul class="store_main">
                    <li style="background-position:right center; "><a href="../system/manager_index.html?type=soreShop">店铺</a>
                    </li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="../system/manager_index.html?type=soregoods">宝贝</a></li>
                </ul>
            </li>
        </ul>

    </div>

    <div id="logo"/>
    <p style="padding-left:30px; margin:0px;">
        <img src="<%=path%>/images/logo.jpg"/>
    </p>
</div>

<div id="banner" style="width:1200px;">
    <p style="margin:0px;"><img src="img/banner.gif"/></p>
</div>

<div id="back_ground" style=" background:url(img/bg2.gif) repeat;">
    <table style="width:980px; height:70px; padding-left:20px;">
        <tr>
            <td align="center">
                您在优复用内购物消费、旅游、找旅店住宿或是二手货买卖，都可享受到比任何代理商还要低优惠价格，大大节约您的日常消费开支。赶快注册吧！
            </td>
        </tr>
    </table>
</div>

<div id="content">
    <div id="reg_steps">
        注册步骤：<img src="img/1.gif"/>填写注册信息<img src="img/2_2.gif"/>注册成功
    </div>
    <div id="reg_success">
        <img src="img/jt.gif"/>恭喜您注册成功，请保管好您的信息&nbsp;<a href="login.jsp">登录</a>
    </div>
</div>

<%
    //去掉用户名和昵称的全局会话
    if (request.getSession().getAttribute("userName") != null && request.getSession().getAttribute("userName") != null) {
        request.getSession().setAttribute("userName", "null");
        request.getSession().setAttribute("callName", "null");
    }

%>
<div id="footer" style="border-top:#999999 dashed 1px; width: 1200px;">
    <div id="foot_main">
        <ul>
            <li><a href="#">新手上路</a></li>
            <li><a href="#">买家须知</a></li>
            <li><a href="#">法律声明</a></li>
            <li><a href="#">联系我们</a></li>
        </ul>
    </div>
    <div style="clear:both; text-align:center; margin-top:40px; color:#9b9b9b; font-size:12px;">&nbsp;优复用&nbsp;</div>

</div>

</div>

</body>
</html>
