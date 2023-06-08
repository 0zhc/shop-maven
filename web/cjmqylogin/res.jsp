<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%String path = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="<%=path%>/css/loginAndrex/top_foot.css" rel="stylesheet"/>
    <link href="../css/loginAndrex/res.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/comm/ps_strength.css" type="text/css" rel="stylesheet"/>
    <link href="../css/loginAndrex/res2.css" rel="stylesheet"/>
    <script type="text/javascript" src="../js/jquery-1.2.6.min.js"></script>
    <script src="../js/system/managerIndex.js"></script>
    <title>新会员免费注册</title>
    <script>

        //填写账号，昵称，密码,确认密码，电子邮箱时显示提示内容
        $(function () {

            $(".userInfo").focus(function () {
                $(this).addClass("focus");
                $(this).parent("td").next("td").children("span").eq(0).show();
                $(this).parent("td").next("td").children("span").eq(1).html("");
            }).blur(function () {
                $(this).removeClass("focus");
                $(this).parent("td").next("td").children("span").eq(0).hide();
            });
        })


        //填写验证码显示提示内容
        $(function () {

            $("#checkcodeId").focus(function () {
                $(this).addClass("focus");
                $(this).parent("td").next("td").children("span").eq(2).show();
                $(this).parent("td").next("td").children("span").eq(3).html("");
            }).blur(function () {
                $(this).removeClass("focus");
                $(this).parent("td").next("td").children("span").eq(2).hide();
            });
        })


        //验证用户名格式是否正确并且验证用户名的唯一性
        function registerUserNamer() {

            var userName = $("#userName").val();

            var reg = /^[a-zA-Z0-9_]{6,16}$/;

            if (userName == "") {
                $("#userNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员名不能为空</font>");
                return false;
            } else if (userName.length < 6 || userName.length > 16) {
                $("#userNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员名在6-16个字符内</font>");
                return false;
            } else if (!reg.test(userName)) {
                $("#userNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员名只能用英文、数字或下划线</font>");
                return false;
            } else {
                //异步交互
                $("#userNameTip").html('');
                $.ajax({
                    type: "post",
                    url: "<%=request.getContextPath()%>/registerUserName.do?" + escape(new Date()),
                    data: {"userName": $("#userName").val()},
                    dataType: "html",//(可以不写,默认)
                    beforeSend: function (XMLHttpRequest) {
                        $("#load").show();
                    },
                    success: function (data, textStatus) {

                        //alert(data);//data是一个字符串对象
                        if (data == 'ok') {//此用户名不存在,可以用
                            $("#userNameTip").html("<img src='<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/correct.gif'/>");
                        } else {
                            //  用户名已经存在
                            $("#userNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员名已存在</font>");
                        }

                    },
                    complete: function (XMLHttpRequest, textStatus) {
                        //HideLoading();
                        $("#load").hide();

                    },

                    error: function () {

                        //请求出错处理
                    }

                });
            }
        }


        //昵称验证(只能用中文、英文、数字或下划线,1-10字符)
        function callNameCheck() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var callName = $("#callName").val();

            var reg = /^[\u4E00-\u9FA5\uf900-\ufa2d\w]{1,10}$/

            if (callName.len() == 0) {

                $("#callNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员昵称不能为空</font>");
                return false;

            } else if (callName.len() > 10) {

                $("#callNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员昵称在10个字符内</font>");
                return false;

            } else if (!reg.test(callName)) {

                $("#callNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员昵称只能用中文、英文、数字或下划线</font>");
                return false;
            } else {
                $("#callNameTip").html("<img src='<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/correct.gif'/>");

                return true;
            }
        }

        //密码验证
        function userPasswordCheck() {

            //失去焦点时隐藏密码强度的图
            document.getElementById("passwordStrength").style.display = "none";

            var userPassword = $("#userPassword").val();

            var reg = /^[a-zA-Z0-9_]{6,16}$/;

            if (userPassword.length == 0) {

                $("#userPasswordTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;密码不能为空</font>");
                return false;

            } else if (userPassword.length < 6 || userPassword.length > 16) {

                $("#userPasswordTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;密码在6-16个字符内</font>");
                return false;

            } else if (!reg.test(userPassword)) {

                $("#userPasswordTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;密码只能用英文、数字或下划线</font>");
                return false;

            } else {

                $("#userPasswordTip").html("<img src='<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/correct.gif'/>");
                return true;
            }

        }


        //确认密码验证
        function confirmPasswordCheck() {

            var userPassword = $("#userPassword").val();
            var PasswordAagin = $("#confirmPassword").val();
            var reg = /^[a-zA-Z0-9_]{6,16}$/;

            if (PasswordAagin != userPassword) {

                $("#userPasswordAgain").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;用户密码与再次输入密码不一致</font>");
                return false;

            } else if (!reg.test(PasswordAagin)) {

                $("#userPasswordAgain").html("");
                return false;

            } else {
                $("#userPasswordAgain").html("<img src='<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/correct.gif'/>");
                return true;
            }

        }


        //邮箱验证
        function emailCheck() {

            var email = $("#email").val();

            var reg = /^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/;

            if (email == "") {

                $("#emailTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;Email地址不能为空</font>");
                return false;

            } else if (!reg.test(email)) {

                $("#emailTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;Email格式错误，请重新填写</font>");
                return false;

            } else {

                $("#emailTip").html("<img src='<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/correct.gif'/>");
                return true;

            }
        }


        //失去焦点时校验验证码是否正确

        var isCorrect = false;//验证码是否正确 ,全局的

        function testCode() {

            var str = $("#checkcodeId").val();

            if (str == "") {

                $("#msgcode").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;验证码不能为空</font>");
                return false;
            } else {

                $.ajax({
                    type: "post",
                    url: "<%=request.getContextPath()%>/validateCode.do?" + escape(new Date()),
                    data: {'checkcode': str},
                    dataType: "html",//(可以不写,默认)
                    success: function (data, textStatus) {

                        if (data == "true") {

                            isCorrect = true;
                            $("#msgcode").html("<img src='<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/correct.gif'/>");

                        } else {

                            $("#msgcode").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;验证码输入有误，请重新输入</font>");

                        }
                    }
                });

            }
        }

        //点击换一张刷新验证码
        function changeCode() {


            var v_randimg = document.getElementById("rand_img");
            v_randimg.innerHTML = "";
            v_randimg.innerHTML = "<img src='<%=request.getContextPath() %>/image.jsp'/>";
            $("#exchange_img").html("<a href='javascript:void(0);' id='exchang_code_img' onclick='changeCode()'>换一张</a>");

        }


        //是否同意显示协议

        $(function () {

            $("#myAgree").click(function () {

                $("#agreeText").toggle();

            })

        });


        //表单提交

        function submitForm() {

            //提交表单是提交的按钮（图片）变为不可以点击的
            $("#submitImg").html('<a style="text-decoration:none;"><img src="img/sub.gif" style="border:none;"/></a><span style="color: #FFFFFF;">空空</span><input type="image" src="img/res.gif"/>');

            if (callNameCheck() == false)
                return false;
            if (userPasswordCheck() == false)
                return false;
            if (confirmPasswordCheck() == false)
                return false;
            if (emailCheck() == false)
                return false;

            //提交时判断验证码是否正确
            testCode();//调用验证码函数


            if (isCorrect == false) {//判断全局的isCorrect是否为false，若为false，则直接跳出函数，不给提交
                return false;
            }

            //判读是否同意玛奇园服务条款
            if (!$("#isagree").is(":checked")) {

                $("#donot_gree").html("抱歉，您必须同意玛奇园的服务条款后，才能提交注册。");
                return false;

            }


            //ajax的register.do进行添加用户是先进行用户唯一性的验证(服务器端验证，防止用户禁掉js)，如果返回来的数据不是ok，这说明用户已存在
            $.ajax({
                type: "post",
                url: "<%=request.getContextPath()%>/register.do?" + escape(new Date()),
                data: $("#resgirster").serialize(),
                dataType: "text",//(可以不写,默认)
                beforeSend: function (XMLHttpRequest) {
                    $("#loading").show();
                },
                success: function (data, textStatus) {

                    if (data == 'ok') {
                        window.location.href = '<%=request.getContextPath()%>/cjmqylogin/resSucessful.jsp';
                    } else {
                        //注册失败（用户名重复了）

                        $("#userNameTip").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;会员名已存在</font>");

                    }

                },
                complete: function (XMLHttpRequest, textStatus) {
                    //HideLoading();
                    $("#loading").hide();

                },

                error: function () {

                    //请求出错处理
                }

            });

        }


        //下面为密码强度的js

        //CharMode函数
        //测试某个字符是属于哪一类.
        function CharMode(iN) {
            if (iN >= 48 && iN <= 57) //数字
                return 1;
            if (iN >= 65 && iN <= 90) //大写字母
                return 2;
            if (iN >= 97 && iN <= 122) //小写
                return 4;
            else
                return 8; //特殊字符
        }

        //bitTotal函数
        //计算出当前密码当中一共有多少种模式
        function bitTotal(num) {
            modes = 0;
            for (i = 0; i < 4; i++) {
                if (num & 1) modes++;
                num >>= 1;
            }
            return modes;
        }

        //checkStrong函数
        //返回密码的强度级别

        function checkStrong(sPW) {
            if (sPW.length <= 7)
                return 0; //密码太短，小于7位
            Modes = 0;
            for (i = 0; i < sPW.length; i++) {
                //测试每一个字符的类别并统计一共有多少种模式.
                Modes |= CharMode(sPW.charCodeAt(i)); //charCodeAt()方法请详细参见《charCodeAt方法详解》

            }

            return bitTotal(Modes);
        }

        //pwStrength函数
        //当用户放开键盘时,根据不同的级别显示不同的颜色

        function pwStrength(pwd) {
            //填写密码时使PWAgain_condition,userPasswordTip的内容清空
            document.getElementById("PWAgain_condition").innerHTML = "";
            document.getElementById("userPasswordTip").innerHTML = "";

            //填写密码时显示密码强度的图
            document.getElementById("passwordStrength").style.display = "block";

            O_color = "#eeeeee"; //密码为空时显示的颜色（灰白色）
            L_color = "#FB88B0"; //密码弱时显示的颜色    （红色）
            M_color = "#FF9900"; //密码中时显示的颜色    （橘黄色）
            H_color = "#62FFB0"; //密码强时显示的颜色     （绿色）
            if (pwd == null || pwd == "") {
                Lcolor = Mcolor = Hcolor = O_color;
            } else {
                S_level = checkStrong(pwd);
                switch (S_level) {
                    case 0:
                        Lcolor = Mcolor = Hcolor = O_color;
                    case 1:
                        Lcolor = L_color;
                        Mcolor = Hcolor = O_color;
                        break;
                    case 2:
                        Lcolor = Mcolor = M_color;
                        Hcolor = O_color;
                        break;
                    default:
                        Lcolor = Mcolor = Hcolor = H_color;
                }
            }
            document.getElementById("strength_L").style.background = Lcolor;
            document.getElementById("strength_M").style.background = Mcolor;
            document.getElementById("strength_H").style.background = Hcolor;
            return;
        }

    </script>

</head>

<body onload="changeCode();">
<div class="backg2"></div>
<div id="contain" style=" width:1235px;">
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
                <li style="position: relative; left:-28px"><a href="<%=path %>/user/loginOut.do">注销</a></li>
            </c:if>
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

<div id="back_ground" style="background:url(img/bg2.gif) repeat;">
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
        注册步骤：<img src="img/1.gif"/>填写注册信息<img src="img/2.gif"/>注册成功
    </div>
    <div id="personinfo">
        <img src="img/jt.gif"/>请设置您的个人信息（注<img src="img/xing.gif"/>为必填）
    </div>

    <form action="" method="post" id="resgirster">
        <input type="hidden" name="TOKEN" value='<%=session.getAttribute("org.apache.struts.action.TOKEN")%>'
               id="TOKEN"/>
        <table class="from1" style="width: 1000px;">

            <tr>
                <td style="text-align:right; width: 400px;">
                    <span id="imformation" style="color: red;">*</span>会员帐号：
                </td>
                <td style="text-align:left; width:187px;">
                    <input type="text" style="width:180px; height:18px;" maxlength="60" name="userName" id="userName"
                           class="userInfo" onblur="registerUserNamer()"/>

                </td>
                <td style="text-align:left; width:393px;">
                    <span class="userInfo_condition">只能用英文、数字或下划线,6—16个字符</span>
                    <span id="userNameTip"></span>
                    <img src="../images/load/loading.gif" id="load" style="display: none;"/>
                </td>
            </tr>

            <tr>
                <td style="text-align:right; width:400px;">
                    <span id="imformation" style="color: red;">*</span>会员昵称：
                </td>
                <td style="text-align:left; width:187px;">
                    <input type="text" style="width:180px; height:18px;" maxlength="60" name="callName" id="callName"
                           class="userInfo" onblur="callNameCheck()"/>
                </td>
                <td style="text-align:left; width:393px;">
                    <span class="userInfo_condition">只能用中文、英文、数字或下划线,1—10字符，一个汉字为两个字符</span>
                    <span id="callNameTip"></span>
                </td>
            </tr>

            <tr>
                <td style="text-align:right; width:400px;">
                    <span style="color: red;">*</span>用户密码：
                </td>
                <td style="text-align:left; width:187px;">
                    <input type="password" style="width:180px; height:18px;" maxlength="60" name="userPassword"
                           id="userPassword" class="userInfo" onkeyup="pwStrength(this.value)"
                           onblur="userPasswordCheck()"/>
                </td>
                <td style="text-align:left; width:393px;">
                    <span class="userInfo_condition" id="PWAgain_condition">只能用英文、数字或下划线,6—16字符</span>
                    <span id="userPasswordTip"></span>
                    <div id="passwordStrength">
                        <ul>
                            <li id="strength_L">弱</li>
                            <li id="strength_M">中</li>
                            <li id="strength_H">强</li>
                        </ul>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align:right; width:400px;">
                    <span style="color: red;">*</span>确认密码：
                </td>
                <td style="text-align:left; width:187px;">
                    <input type="password" style="width:180px; height:18px;" maxlength="60" name="confirmPassword"
                           id="confirmPassword" class="userInfo" onblur="confirmPasswordCheck()"/>
                </td>
                <td style="text-align:left; width:393px;">
                    <span class="userInfo_condition">请再次输入您设置的密码</span>
                    <span id="userPasswordAgain"></span>
                </td>
            </tr>

            <tr>
                <td style="text-align:right; width: 400px;">
                    <span style="color: red;">*</span>电子邮箱：
                </td>
                <td style="text-align:left; width:187px;">
                    <input type="text" style="width:180px; height:18px;" maxlength="60" name="email" id="email"
                           class="userInfo" onblur="emailCheck()"/>
                </td>
                <td style="text-align:left; width:393px;">
                    <span class="userInfo_condition">请输入您常用的Email地址</span>
                    <span id="emailTip"></span>
                </td>
            </tr>

            <tr>
                <td style="text-align:right; width:400px;">
                    <span style="color: red;">*</span>性别：
                </td>
                <td colspan="2" style="text-align:left;">
                    <input type="radio" name="sex" value="1" checked="checked"/>男<input type="radio" name="sex"
                                                                                        value="2"/>女
                </td>
            </tr>

            <tr>
                <td style="text-align:right; width: 400px;">
                    <span style="color: red;" id="codeTip">*</span>验证码：
                </td>
                <td style="text-align:left; width:187px;">
                    <input type="text" style="width:110px; height:18px;" name="checkcode" id="checkcodeId"
                           onblur="testCode()"/>
                    <span id="rand_img"></span>
                </td>
                <td style="text-align:left; width:393px;">
                    <span style=" color: #878787;">看不清楚？</span>
                    <span id="exchange_img"></span>
                    <span class="userInfo_condition">&nbsp;请输入正确的验证码</span>
                    <span id="msgcode"></span>
                </td>
            </tr>


            <tr>
                <td style=" text-align:right; width: 400px;">
                    <span style=" margin-top: 5px; "><input type="checkbox" id="isagree" checked="checked"/></span>
                </td>
                <td style="text-align:left; width:187px; ">
                    <a href="javascript:void(0);" id="myAgree">我接受并同意优复用服务条款</a>
                </td>
                <td style="text-align:left; width:393px;">
                    <span id="donot_gree" style="color: #ec4501;"></span>
                </td>
            </tr>

            <tr>
                <td colspan="3" style="text-align:left; height:5px; ">
                    <div id="agreeText"
                         style="width:500px; height:300px; color:#333333; border:#C7C7C7 solid 1px; padding:10px; margin-left:250px; overflow:hidden; overflow-y:auto; display: none; ">
                        <br/>
                        <p><strong>优复用服务协议（试行）</strong><br/><br/>
                            优复用（以下简称"本网站"）依据《优复用服务协议》（以下简称"本协议"）的规定提供服务，本协议中协议双方合称协议方，优复用在协议中亦称为“优复用”，本协议具有合同效力。注册会员时，请您认真阅读本协议，审阅并接受或不接受本协议。<br/>
                            <br/>
                            <strong>若您已经注册为本网站会员，即表示您已充分阅读、理解并同意自己与本网站订立本协议，且您自愿受本协议的条款约束。本网站有权随时变更本协议并在本网站上予以公告。经修订的条款一经在本网站的公布后，立即自动生效。如您不同意相关变更，必须停止使用本网站。本协议内容包括协议正文及所有优复用已经发布的各类规则。一旦您继续使用本网站，则表示您已接受并自愿遵守经修订后的条款。</strong><br/>


                            <br/>第一条、协议内容及签署<br/>
                            1.本协议内容包括协议正文及所有优复用已经发布的或将来可能发布的各类规则。所有规则
                            为本协议不可分割的组成部分，与协议正文具有同等法律效力。除另行明确声明外，任何优复用及其关联公司提供的服务（以下称为优复用服务）均受本协议约束。<br/>
                            2.您应当在使用优复用服务之前认真阅读全部协议内容，对于协议中以加粗字体显示的内容，您应重点阅读。如您对协议有任何疑问的，应向玛奇园咨询。但无论您事实上是否在使用优复用服务之前认真阅读了本协议内容，只要您使用优复用服务，则本协议即对您产生约束，届时您不应以未阅读本协议的内容或者未获得优复用对您问询的解答等理由，主张本协议无效，或要求撤销本协议。<br/>
                            3.您承诺接受并遵守本协议的约定。如果您不同意本协议的约定，您应立即停止注册程序或停止使用优复用服务。<br/>
                            4.优复用有权根据需要不时地制订、修改本协议及/或各类规则，并以网站公示的方式进行公告，不再单独通知您。变更后的协议和规则一经在网站公布后，立即自动生效。如您不同意相关变更，应当立即停止使用优复用服务。您继续使用优复用服务的，即表示您接受经修订的协议。<br/>

                            <br/>第二条、注册者资格<br/>
                            您确认，在您完成注册程序或以其他优复用允许的方式实际使用优复用服务时，您应当是具备完全民事权利能力和完全民事行为能力的自然人、法人或其他组织。若您不具备前述主体资格，则您及您的监护人应承担因此而导致的一切后果，且优复用有权注销（永久冻结）您的优复用账户，并向您及您的监护人索偿。<br/>

                            <br/>第三条、 商品交易<br/>
                            1.商品交易原则：
                            a)平等原则：用户和优复用商城在交易过程中具有同等的法律地位。
                            b)自由原则：用户享有自愿向优复用商城购买商品的权利，任何人不得非法干预。
                            c)公平原则：用户和优复用商城行使权利、履行义务应当遵循公平原则。
                            d)诚实信用原则：用户和优复用行使权利、履行义务应当遵循诚实信用原则。<br/>

                            <br/> 第四条、优复用服务<br/>
                            1.通过优复用及其关联公司提供的优复用服务和其它服务，会员可在优复用上发布交易信息、查询商品和服务信息、达成交易意向并进行交易、对其他会员进行评价、参加优复用组织的活动以及使用其它信息服务及技术服务。<br/>
                            2.您在优复用上交易过程中与其他会员发生交易纠纷时，一旦您或其它会员任一方或双方共同提交优复用要求调处，则优复用有权根据单方判断做出调处决定，您了解并同意接受优复用的判断和调处决定。该决定将对您具有法律约束力。
                            <br/>
                            3.您了解并同意，优复用有权应政府部门（包括司法及行政部门）的要求，向其提供您在优复用填写的注册信息和交易纪录等必要信息。如您涉嫌侵犯他人知识产权，则优复用亦有权在初步判断涉嫌侵权行为存在的情况下，向权利人提供您必要的身份信息。<br/>

                            <br/>第五条、本网站的责任范围<br/>
                            1.在优复用上使用优复用服务过程中，您承诺遵守以下约定：
                            a)
                            在使用优复用服务过程中实施的所有行为均遵守国家法律、法规等规范性文件及优复用各项规则的规定和要求，不违背社会公共利益或公共道德，不损害他人的合法权益，不违反本协议及相关规则。您如果违反前述承诺，产生任何法律后果的，您应以自己的名义独立承担所有的法律责任，并确保优复用免于因此产生任何损失。
                            b) 在与其他会员交易过程中，遵守诚实信用原则，不采取不正当竞争行为，不扰乱网上交易的正常秩序，不从事与网上交易无关的行为。
                            c)
                            不发布国家禁止销售的或限制销售的商品或服务信息（除非取得合法且足够的许可），不发布涉嫌侵犯他人知识产权或其它合法权益的商品或服务信息，不发布违背社会公共利益或公共道德或优复用认为不适合在优复用上销售的商品或服务信息，不发布其它涉嫌违法或违反本协议及各类规则的信息。
                            d) 不以虚构或歪曲事实的方式不当评价其他会员，不采取不正当方式制造或提高自身的信用度，不采取不正当方式制造或提高（降低）其他会员的信用度。
                            e) 不对优复用上的任何数据作商业性利用，包括但不限于在未经优复用事先书面同意的情况下，以复制、传播等任何方式使用优复用站上展示的资料。
                            f) 不使用任何装置、软件或例行程序干预或试图干预优复用的正常运作或正在优复用上进行的任何交易、活动。您不得采取任何将导致不合理的庞大数据负载加诸优复用网络设备的行动。<br/>

                            2.您了解并同意：
                            a) 优复用有权对您是否违反上述承诺做出单方认定，并根据单方认定结果适用规则予以处理或终止向您提供服务，且无须征得您的同意或提前通知予您。
                            b)
                            经国家行政或司法机关的生效法律文书确认您存在违法或侵权行为，或者优复用根据自身的判断，认为您的行为涉嫌违反本协议和/或规则的条款或涉嫌违反法律法规的规定的，则优复用有权在优复用上公示您的该等涉嫌违法或违约行为及优复用已对您采取的措施。
                            c) 对于您在优复用上发布的涉嫌违法或涉嫌侵犯他人合法权利或违反本协议和/或规则的信息，优复用有权不经通知您即予以删除，且按照规则的规定进行处罚。
                            d)
                            对于您在优复用上实施的行为，包括您未在优复用上实施但已经对优复用及其用户产生影响的行为，优复用有权单方认定您行为的性质及是否构成对本协议和/或规则的违反，并据此作出相应处罚。您应自行保存与您行为有关的全部证据，并应对无法提供充要证据而承担的不利后果。<br/>

                            <br/>第六条、用户的权利和义务：<br/>
                            1. 用户有权拥有其在优复用商城的用户名及密码，并用该用户名和密码登陆优复用商城网站购买商品。用户不得以任何形式转让或授权他人使用自己的优复用商城用户名。 <br/>
                            2.
                            用户有权根据本协议的规定以及优复用商城网站上发布的相关规则在优复用商城网站上查询商品信息、发表使用体验、参与商品讨论、参加优复用商城的有关活动，以及享受优复用商城提供的其它信息服务
                            <br/>。
                            3.
                            用户有义务在注册和通过电话购物时提供自己的真实资料，并保证诸如电子邮件地址、联系电话、联系地址、邮政编码等内容的有效性及真实性，保证优复用商城可以通过上述联系方式与用户本人进行联系。同时，用户也有义务在相关资料发生变更时及时更新有关注册资料。用户保证不以他人资料在优复用商城进行注册和购买商品。
                            . 用户在成为优复用商城的会员后，可按优复用商城的积分返利说明享受返利，详情请见优复用商城在网站上公布的。 <br/>
                            4. 用户享有言论自由权利；并拥有适度修改、删除自己发表的文章的权利。 用户不得在优复用商城发表包含以下内容的言论：
                            a)反对宪法所确定的基本原则，煽动、抗拒、破坏宪法和法律、行政法规实施的。
                            b)煽动颠覆国家政权，推翻社会主义制度，煽动、分裂国家，破坏国家统一的。
                            c)损害国家荣誉和利益的。
                            d)煽动民族仇恨、民族歧视，破坏民族团结的。
                            e)任何包含对种族、性别、宗教、地域内容等歧视的。
                            f)捏造或者歪曲事实，散布谣言，扰乱社会秩序的；
                            g)宣扬封建迷信、邪教、淫秽、赌博、暴力、凶杀、恐怖、教唆犯罪的。
                            h)公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的。
                            i)损害国家机关信誉的。
                            j)其他违反宪法和法律行政法规的。<br/>

                            <br/>第七条 、优复用商城的权利和义务<br/>
                            1. 优复用商城有义务在现有技术上维护整个网上交易平台的正常运行，并努力提升和改进技术，使用户网上交易活动得以顺利进行。<br/>
                            2. 对用户在注册和使用优复用商城网上交易平台中所遇到的与交易或�册有关的问题及反映的情况，优复用商城应及时作出回复；。<br/>
                            3. 对于用户在优复用商城网站上作出下列行为的，优复用商城有权作出删除相关信息、终止提供服务等处理，而无须征得用户的同意：<br/>
                            a)优复用商城有权对用户的注册信息及购买行为进行查阅，发现注册信息或购买行为中存在任何问题的，有权向用户发出询问及要求改正的通知或者作出删除等处理；
                            b)用户违反本协议规定或有违反法律法规和地方规章的行为的，优复用商城有权停止传输并删除其信息，禁止用户发言，注销用户账户并按照相关法律规定向相关主管部门进行披露。
                            c)对于用户在优复用商城进行的下列行为，优复用商城有权对用户采取删除其信息、禁止用户发言、注销用户账户等限制性措施：包括发布或以电子邮件或以其他方式传送存在恶意、虚假和侵犯他人人身财产权利内容的信息，进行与网上购物无关或不是以购物为目的的活动，试图扰乱正常购物秩序，将有关干扰、破坏或限制任何计算机软件、硬件或通讯设备功能的软件病毒或其他计算机代码、档案和程序之资料，加以上载、发布、发送电子邮件或以其他方式传送，干扰或破坏优复用商城网站和服务或优复用商城网站和服务相连的服务器和网络，或发布其他违反公共利益或可能严重损害优复用商城和其它用户合法利益的信息。<br/>

                            <br/>第八条、网站规则、修改和可分性<br/>
                            1.
                            价格变动规则:优复用商城将尽最大努力保证用户所购商品与网站上公布的价格一致，但价目表并不构成要约。尽管做出最大的努力，优复用商城商品中的一小部分商品可能会有定价错误。如果发现错误定价，优复用商城将采取下列措施之一：
                            如果某一商品的正确定价低于错误定价，优复用商城将按照较低的定价向用户销售该商品。 如果某一商品的正确定价高于错误定价，优复用商城会根据具体情况，在交付前联系用户寻求指示,
                            或者取消订单并通知用户。 <br/>
                            2. 商品缺货规则
                            :用户希望购买的商品如果发生缺货，用户和优复用商城皆有权取消该订单。优复用商城可对缺货商品进行预售登记，优复用商城会尽最大努力在最快时间内满足用户的购买需求，当缺货商品到货，优复用商城将第一时间通过邮件、短信或电话通知用户，方便用户进行购买。预售登记并不做订单处理，不构成要约。<br/>
                            3. 邮件/短信服务规则:优复用商城保留通过邮件和短信的形式，对本网站及优复用商城购物用户发送订单信息、促销活动等告知服务的权利。如果在优复用商城注册、购物，则表明已默示接受此项服务。
                            如不想接收来自优复用商城除订单以外的邮件和短信，优复用商城可办理退阅。 <br/>
                            4. 送货规则
                            :优复用商城将会把商品送到用户指定的收货地址。所有在优复用商城网站上列出的送货时间皆为参考时间，供用户参照使用。参考送货时间是根据库存状况、正常的处理过程和送货时间、送货地点等情况计算得出的。<br/>
                            5. 退换货、补货规则 :优复用商城保留对商品退换货、补货的解释权和限制权。下订单即表明接受优复用商城的退换货、补发货规则。详情请参见退换货、补发货规则。<br/>
                            6. 规则的变更 :
                            a)优复用商城可以根据需要变更本规则、相关条款和条件或用户资格的认定。
                            对这些条款的修改和变更将被包含在优复用商城更新的规则中。上述变更具有可分割性，如果部分变更或条件被认定为无效的，不影响其他变更或条件的有效性。
                            b)用户在使用优复用商城提供的各项服务的同时，承诺接受并遵守各项相关规则的规定。优复用商城有权根据需要不时地制定、修改本协议或各类规则，如本协议有任何变更，优复用商城将在网站重要页面上提示修改内容。如用户不同意相关变更，必须停止使用“服务”。经修订的协议一经在优复用商城网站公布后，立即自动生效。各类规则会在发布后生效，亦成为本协议的一部分。登录或继续使用“服务”将表示用户接受经修订的协议。
                            <br/>
                            7. 解除和终止 :
                            ①用户有权在下列情况下，取消订单：
                            a)经用户和优复用商城协商达成一致的。
                            b) 优复用商城就用户订单做出承诺之前；
                            c) 优复用商城网站上的公布的商品价格发生变化或错误，用户在优复用商城发货之前通知优复用商城的。
                            ②优复用商城在下列情况下，可以取消用户订单。
                            a)经用户和优复用商城协商达成一致的。
                            b)优复用商城网站上显示的商品信息明显错误或缺货的。
                            c)用户订单信息明显错误或超出优复用商城存货量。
                            d)因不可抗力、优复用商城系统发生故障或遭受第三攻击，及其它优复用商城无法控制的情形。
                            e)经优复用商城判断不符合公平和诚实信用原则的情形，如同一用户多次无理由拒收商品。优复用商城可以终止全部或部分规则，即使优复用商城没有要求或强制用户严格遵守这些规则，也并不构成优复用商城对任何权利的放弃。
                            <br/>
                            8.
                            责任限制:在法律法规所允许的限度内，因使用优复用商城服务而引起的任何损害或经济损失，优复用商城承担的全部责任均不超过用户所购买的与该索赔有关的商品价格。这些责任限制条款将在法律所允许的最大限度内适用，并在用户资格被撤销或终止后仍继续有效。
                            <br/>

                            9. 在下列情况下，优复用商城可以通过注销用户的方式终止服务：
                            a)
                            在用户违反本服务协议相关规定时，优复用商城有权终止向该用户提供服务。但如该用户在优复用商城终止提供服务后，再一次直接或间接或以他人名义注册为优复用商城用户的，优复用商城有权再次单方面终止向该用户提供服务。
                            b)如优复用商城通过用户提供的信息与用户联系时，发现用户在注册时填写的电子邮箱已不存在或无法接收电子邮件的，经优复用商城以其它联系方式通知用户更改，而用户在三个工作日内仍未能提供新的电子邮箱地址的，优复用商城有权终止向该用户提供服务。
                            c)一经优复用商城发现用户注册信息中主要内容是虚假的，优复用商城有权随时终止向该用户提供服务。
                            d)本服务协议终止或更新时，用户明示不愿接受新的服务协议的。
                            d)其它优复用商城认为需终止服务的情况。 <br/>

                            <br/>第九条 附则<br/>

                            在本协议中所使用的下列词语，除非另有定义，应具有以下含义：<br/>
                            &quot;本网站&quot;在无特别说明的情况下，均指&quot;优复用&quot;（www.cjmqy.com）。　<br/>
                            "用户"： 指具有完全民事行为能力的猪八戒网各项服务的使用者。<br/>
                            "会员"： 指与优复用签订《优复用服务协议》并完成注册流程的用户。<br/>


                    </div>
                </td>
            </tr>

            <tr style="height: 38px;">
                <td style=" text-align:right; width: 400px; height: 38px;">
                    <img src="../images/load/loading.gif" id="loading" style="display: none;"/>
                </td>

                <td id="submitImg" style="text-align:left; width:187px; height: 38px;">
                    <a href="javascript:void(0);" onclick="submitForm();" style="text-decoration:none;">
                        <img src="img/sub.gif" style="border:none;"/>
                    </a>
                    <span style="color: #FFFFFF;">空空</span>
                    <input type="image" src="img/res.gif"/>
                </td>

                <td style="text-align:left; width:393px; height: 38px;">
                </td>
            </tr>

        </table>
    </form>
</div>

<div id="footer" style="border-top:#999999 dashed 1px;">
    <div id="foot_main">
        <ul>
            <li><a href="<%=path %>/help/help.jsp?menu=newMember&menuType=1">新手上路</a></li>
            <li><a href="<%=path %>/help/help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
            <li><a href="<%=path %>/help/help.jsp?menu=law&menuType=3">法律声明</a></li>
            <li><a href="<%=path %>/help/help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
        </ul>
    </div>
    <div style="clear:both; text-align:center; margin-top:40px; color:#9b9b9b; font-size:12px;">
        &nbsp;优复用&nbsp;
    </div>
</div>
<div class="line3">
    <ul>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>

</div>


</body>
</html>
