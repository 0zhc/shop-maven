<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%String path = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <link href="<%=path%>/css/loginAndrex/top_foot.css" rel="stylesheet"/>
    <link href="<%=path%>/css/loginAndrex/login.css" rel="stylesheet"/>

    <link href="<%=path%>/css/loginAndrex/login3.css" rel="stylesheet"/>
    <script type="text/javascript" src="../js/jquery-1.2.6.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/login/jquery.cookie.js"></script>
    <script src="<%=path %>/js/system/managerIndex.js"></script>
    <script src="<%=path %>/js/login/login.js"></script>
    <title>优复用登录</title>

    <script>

        var path = '<%=path%>';

        //表单提交
        function submitForm() {

            if (userPasswordCheck() == false)
                return false;

            if (userPasswordCheck() == false)
                return false;

            $.ajax({
                type: "post",
                url: "<%=request.getContextPath()%>/login.do?" + escape(new Date()),
                data: $("#login").serialize(),
                dataType: "html",//(可以不写,默认)
                beforeSend: function (XMLHttpRequest) {
                    $("#loading").css("visibility", "visible");
                },
                success: function (data, textStatus) {
                    //登录成功

                    if (data == 'ok') {
                        window.location.href = '<%=request.getContextPath()%>/index.jsp';
                    } else {
                        //登录失败
                        $("#errorTip").css("visibility", "visible");
                        $("#userNameTip").html("");
                        $("#un_pw_error").html("<span style='color: #FFFFFF;'>空空空空空空</span><span>用户名或者密码不正确</span>");
                        $("#loading").css("visibility", "hidden");
                    }
                },
                complete: function (XMLHttpRequest, textStatus) {
                    //HideLoading();
                },
                error: function () {
                    //请求出错处理
                }
            });
        }

    </script>
</head>


<body>
<div class="backg2"></div>
<h2 class="denglu" style="font-weight: 400; position: absolute; top: 164px; left: 968px;">登&nbsp;&nbsp;录</h2>
<div id="contain">
    <div id="top">
        <ul id="top_left" style="padding: 0px;margin: 0px;width:530px;">
            <li style="padding-left: 8px;">${user.userName }你好，欢迎来到优复用！</li>
            <li class="top_login"><a href="<%=path %>/index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right" style="padding: 0px;margin: 0px;">
            <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath() %>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
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
                            href="<%=path %>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="<%=path %>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>
            <c:if test="${! empty user}">
                <li style="position: relative; left:-28px"><a href="<%=path %>/loginOut.do">注销</a></li>
            </c:if>
        </ul>

    </div>

    <div id="logo">
        <img src="<%=path%>/images/logo.jpg"/>
    </div>

    <div id="content">

        <div id="bg"><img src="../images/bg.jpg"/></div>

        <div id="log" style="background:url() no-repeat;">

            <form action="" id="login">
                <div id="errorTip">
                    <span id="un_pw_error"></span>
                    <span id="userNameTip"></span>
                </div>

                <div class="user">
                    <span id="name">账户名&nbsp;&nbsp;</span>
                    <span><input type="text" name="userName" id="userName" onblur="userNameChect();"/><input
                            type="hidden" name="userType" value="1"/></span>
                </div>

                <div class="pw">
                    <span id="pass">密<span style="color:#FFFFFF;">空</span>码&nbsp;&nbsp;</span>
                    <span><input type="password" id="userPassword" name="userPassword"
                                 onblur="userPasswordCheck();"/></span>
                </div>

                <div id="userPasswordTip"></div>

                <div id="remember_name">
                    <input type="checkbox" name="checkPW" id="checkPW"/>&nbsp;记住密码
                    <input type="hidden" name="rememberPW" id="rememberPW"/>
                </div>

                <div id="dl">
                 	<span id="myloding">
						<img src="../images/load/loading.gif" id="loading"/>
					</span>
                    <span id="login_forpass">
						<a href="javascript:void(0)" onclick="submitForm()"><img src="../images/buttom.gif"
                                                                                 style="border: none;"/></a>
						<a href="#" target="_blank" id="forget_pass">忘记密码？</a>
					</span>
                </div>

                <div id="reg_foot">
                    <a href="res.jsp" id="reg_members">免费注册会员</a>
                    <a href="<%=path %>/system/manager_index.jsp?type=freeopenshop" id="setup_shop">免费开店</a>
                </div>

            </form>
        </div>
    </div>

    <div id="footer" style=" clear:both;">
        <div id="foot_main">
            <ul>
                <li><a href="<%=path %>/help/help.jsp?menu=newMember&menuType=1">新手上路</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=law&menuType=3">法律声明</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
            </ul>
        </div>
        <div style="    clear: both;
    text-align: center;
    margin-top: 40px;
    margin-left: 553px;
    color: #9b9b9b;
    font-size: 12px;">&nbsp;优复用&nbsp;
        </div>

    </div>
    <div class="line2">
        <ul>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
<div class="backg3"></div>
</body>
</html>
