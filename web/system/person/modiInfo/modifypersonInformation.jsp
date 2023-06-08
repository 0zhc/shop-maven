<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="<%=request.getContextPath()%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>
    <title>个人信息修改</title>
    <style type="text/css">

        * {
            margin: 0px;
            padding: 0px;
        }

        table tr {
            text-align: center;
        }

        input {
            width: 13em;
        }

        #sumbitId {
            width: 40px
        }

        <!--
        密码强度框css样式

        -->
        #passwordStrength {
            display: none;
        }

        #passwordStrength ul {
            list-style-type: none;
            height: 15px;
            width: 141px;
            border-color: #cccccc;
            border-width: 2px 0px 2px 2px;
            border-style: solid;
            background-color: #eeeeee;
        }

        #passwordStrength ul li {
            float: left;
            width: 30px;
            padding-left: 15px;
            line-height: 15px;
            color: #404040;
            font-family: 宋体;
            font-size: 12px;
            border-right: #cccccc solid 2px;
        }
    </style>

    <script type="text/javascript">

        //验证商家昵称
        function validatCallName() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var callName = document.getElementById("callNameId").value;

            if (callName.len() > 10) {
                document.getElementById("callNameSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;输入内容超过10个字符</font>";
                return false;
            } else if (callName.len() < 1) {
                document.getElementById("callNameSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;输入内容不能为空</font>";
                return false;
            } else {
                document.getElementById("callNameSpan").innerHTML = "";
                return true;
            }
        }

        //验证邮箱
        function validateEmail() {
            var email = document.getElementById("emailId").value;
            var reg = /^\w+@\w+.\w+$/;

            if (email == "") {
                document.getElementById("emailSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;输入邮箱不能为空</font>";
                return false;
            } else if (!reg.test(email)) {
                document.getElementById("emailSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;输入邮箱格式不正确</font>";
                return false;
            } else {
                document.getElementById("emailSpan").innerHTML = "";
                return true;
            }
        }

        //验证旧密码是否正确
        $(function () {
            $("#oldPasswordId").blur(function () {

                if ($('#oldPasswordId').val() == "") {
                    $("#oldPasswordSpan").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入原密码</font>");
                } else {

                    $.ajax({
                        type: "post",
                        url: "<%=request.getContextPath()%>/oldPasswordExit.do",
                        dateType: "html",
                        data: {
                            'userId':${user.id},
                            'oldPassword': $('#oldPasswordId').val(),
                            'time': new Date().getTime()
                        },
                        success: function (returnedData) {

                            if (returnedData == "passwordError") {
                                $("#oldPasswordSpan").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密码错误</font>");
                            } else {
                                $("#oldPasswordSpan").html("");
                            }

                        }
                    })
                }
            })
        });

        //验证"输入新密码"
        function validateNewPassword() {

            //失去焦点时隐藏密码强度的图
            document.getElementById("passwordStrength").style.display = "none";

            var newPassword = document.getElementById("newPasswordId").value

            var reg = /^\w{6,16}$/;

            if (newPassword == "") {
                document.getElementById("newPasswordSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新密码不能为空</font>";
                return false;
            } else if (!reg.test(newPassword)) {
                document.getElementById("newPasswordSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6-16个字符字母、数字和下划线</font>";
                return false;
            } else {
                document.getElementById("newPasswordSpan").innerHTML = "";
                return true;
            }
        }

        //验证"确认新密码"
        function validateConPassword() {
            var newPassword = document.getElementById("newPasswordId").value
            var confirmPassword = document.getElementById("confirmPasswordId").value

            if (newPassword == confirmPassword) {
                document.getElementById("confirmPasswordSpan").innerHTML = "";
                return true;
            } else {
                document.getElementById("confirmPasswordSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;输入密码不一致</font>";
                return false;
            }
        }

        //表单提交验证
        function validateForm() {

            if ($('#oldPasswordId').val() == "") {
                $("#oldPasswordSpan").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入原密码</font>");
            } else {

                $.ajax({
                    type: "post",
                    url: "<%=request.getContextPath()%>/oldPasswordExit.do",
                    dateType: "html",
                    data: {'userId':${user.id}, 'oldPassword': $('#oldPasswordId').val(), 'time': new Date().getTime()},
                    success: function (returnedData) {

                        if (returnedData == "passwordError") {
                            $("#oldPasswordSpan").html("<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密码错误</font>");
                        } else {
                            $("#oldPasswordSpan").html("");
                            if (validatCallName() && validateEmail() && validateNewPassword() && validateConPassword()) {
                                myform.submit();
                            }
                        }

                    }
                })
            }
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
            //填写密码时使newPasswordSpan的内容清空
            document.getElementById("newPasswordSpan").innerHTML = "";

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

        }

    </script>

</head>

<body>
<div id="content">

    <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">修改个人信息</a>
    </div>
    <form action="<%=request.getContextPath()%>/modifyUser.do" method="post" id="myform">
        <input type="hidden" name="id" value="${userRe.id}"/>
        <table class="myshop" style="width:600px;">

            <tr>
                <td style="text-align:right; padding-right:20px; width:200px;">呢&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
                <td colspan="2" style="text-align:left;"><input type="text" name="callName" value="${userRe.callName}"
                                                                id="callNameId" maxlength="25"
                                                                onblur="validatCallName()"/><span
                        id="callNameSpan"></span> <input type="hidden" name="id" value="${userRe.id}"/></td>
            </tr>

            <tr>
                <td style="text-align:right; padding-right:20px; width:200px;">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</td>
                <td colspan="2" style="text-align:left;"><input type="text" name="email" value="${userRe.email}"
                                                                id="emailId" maxlength="25"
                                                                onblur="validateEmail()"/><span id="emailSpan"></span>
                </td>
            </tr>

            <tr>
                <td style="text-align:right; padding-right:20px; width:200px;">输入原密码：</td>
                <td colspan="2" style="text-align:left;"><input type="password" name="oldPassword" id="oldPasswordId"
                                                                maxlength="21"/><span id="oldPasswordSpan"></span></td>
            </tr>

            <tr>
                <td style="text-align:right; padding-right:20px; width:200px;">输入新密码：</td>
                <td style="text-align:left; width:170px;"><input type="password" name="newPassword" id="newPasswordId"
                                                                 maxlength="21" onkeyup="pwStrength(this.value)"
                                                                 onblur="validateNewPassword()"/></td>
                <td style="text-align:left;"><span id="newPasswordSpan"></span>
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
                <td style="text-align:right; padding-right:20px; width:200px;">确认新密码：</td>
                <td colspan="2" style="text-align:left;"><input type="password" name="userPassword"
                                                                id="confirmPasswordId" maxlength="21"
                                                                onblur="validateConPassword()"/><span
                        id="confirmPasswordSpan"></span></td>
            </tr>

            <tr style="text-align:center;">
                <td colspan="3"><input id="sumbitId" type="button" value="提交" onclick="validateForm()"/></td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>