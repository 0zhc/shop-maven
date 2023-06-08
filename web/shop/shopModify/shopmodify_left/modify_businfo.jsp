<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>修改店铺商家信息</title>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function () {

            //如果商家数据全部为空，隐藏填写信息的表单
            if ('${empty userRequest.callName && empty userRequest.telephone && empty userRequest.shortNumber && empty userRequest.qq}' == 'true') {

                $("#addComplete").hide();
            } else {
                //否则隐藏“马上添加”
                $("#if_add").hide();
            }

            //如果修改成功，显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
            if ('${!empty updateUserInfoSuccess}' == 'true') {

                $("#modifyUserInfoSuccess").show();
            } else {
                //否则不显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
                $("#modifyUserInfoSuccess").hide();
            }

        })

        //点击马上添加，秀出填写信息的表单
        $(function () {
            $("#add").click(function () {
                $("#addComplete").show();
                $("#if_add").hide();
            })
        })

        //使用jq,使商家填写信息时显示提示内容
        $(function () {

            $(".busifo").focus(function () {
                $(this).addClass("focus");
                $(this).next("span").show();
                $(this).next("span").next("span").html("");
            }).blur(function () {
                $(this).removeClass("focus");
                $(this).next("span").hide();
            });
        })


        //验证商家昵称
        function validatCallName() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var callName = document.getElementById("callNameId").value;

            if (callName.len() > 10) {
                document.getElementById("callNameSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;输入内容超过10个字符</font>";
                return false;
            } else if (callName.len() < 1) {
                document.getElementById("callNameSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;输入内容不能为空</font>";
                return false;
            } else {
                document.getElementById("callNameSpan").innerHTML = "";
                return true;
            }
        }

        //验证商家长号
        function validatTelephone() {
            var telephone = document.getElementById("telephoneId").value;
            var reg = /^1[3|4|5|8]\d{9}$/;
            if (telephone == "") {
                document.getElementById("telephoneSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入手机号码不能为空</font>";
                return false;
            } else if (!reg.test(telephone)) {
                document.getElementById("telephoneSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入手机号码格式不正确</font>";
                return false;
            } else {
                document.getElementById("telephoneSpan").innerHTML = "";
                return true;
            }
        }

        //验证商家短号
        function validatShortNumber() {
            var shortNumber = document.getElementById("shortNumberId").value;
            var reg = /^6\d{5}$/;
            if (shortNumber == "") {
                document.getElementById("shortNumberSpan").innerHTML = "";
                return true;
            } else if (!reg.test(shortNumber)) {
                document.getElementById("shortNumberSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入手机短号格式不正确</font>";
                return false;
            } else {
                document.getElementById("shortNumberSpan").innerHTML = "";
                return true;
            }
        }

        //验证商家QQ号码
        function validatQQ() {
            var qq = document.getElementById("qqId").value;
            var reg = /^[1-9](\d){4,9}$/;
            if (qq == "") {
                document.getElementById("QQSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入QQ号码不能为空</font>";
                return false;
            } else if (!reg.test(qq)) {
                document.getElementById("QQSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入QQ号码格式不正确</font>";
                return false;
            } else {
                document.getElementById("QQSpan").innerHTML = "";
                return true;
            }
        }


        //表单提交验证
        function validateForm() {
            return validatCallName() && validatTelephone() && validatShortNumber() && validatQQ();
        }


    </script>

    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        #modify_businfo {
            margin-top: 20px;
            margin-left: 33px;
        }

        #if_add {
            width: 450px;
            margin-top: 15px;
            margin-left: 80px;
            font-family: 宋体;
            font-size: 14px;
            color: #424242;
        }

        #addComplete {
            width: 450px;
            margin-left: 80px;
        }

        #addComplete div {
            margin-top: 15px;
            font-family: 宋体;
            font-size: 14px;
            color: #424242;
        }

        #modifyUserInfoSuccess {
            height: 30px;
            margin-top: 15px;
            margin-left: 50px;
            font-family: 宋体;
            font-size: 14px;
            color: #FF7D7D;
        }

        #decorate {
            margin-left: 100px;
        }

        #if_add a {
            text-decoration: none;
            color: #969696;
        }

        #if_add a:hover {
            color: #424242;
        }

        label span {
            color: red;
        }

        .busifo_condition {
            color: #CC0000;
            display: none;
        }

        .focus {
            border: #60C8FD 1px solid;
            background: #CEEFFF;
        }
    </style>

</head>

<body>

<div id="modify_businfo">
    <form action="<%=request.getContextPath()%>/modifyUserInfo.do?userId=${userId}" method="post" id="regForm"
          onSubmit="return validateForm()">
        <fieldset>
            <legend>店主信息</legend>
            <div id="if_add"><span>你还没有添加店主信息&nbsp;&nbsp;&nbsp;&nbsp;</span><a id="add"
                                                                               href="javascript:void(0)">马上添加</a></div>
            <div id="addComplete">
                <div>
                    <label>昵&nbsp;称：<span>*</span>&nbsp;</label>
                    <input class="busifo" id="callNameId" type="text" name="callName" value="${userRequest.callName}"
                           onBlur="validatCallName()"/>&nbsp;<span
                        class="busifo_condition">1-10个字符，一个汉字为两个字符</span><span id="callNameSpan"></span>
                    <input type="hidden" name="id" value="${userRequest.id }"/>
                </div>
                <div>
                    <label>长&nbsp;号：<span>*</span>&nbsp;</label>
                    <input class="busifo" id="telephoneId" type="text" name="telephone" value="${userRequest.telephone}"
                           onBlur="validatTelephone()"/>&nbsp;<span class="busifo_condition">请填写真实手机号码</span><span
                        id="telephoneSpan"></span>
                </div>
                <div>
                    <label>短&nbsp;号：&nbsp;&nbsp;</label>
                    <input class="busifo" id="shortNumberId" type="text" name="shortNumber"
                           value="${userRequest.shortNumber}" onBlur="validatShortNumber()"/>&nbsp;<span
                        class="busifo_condition">请填写真实短号</span><span id="shortNumberSpan"></span>
                </div>
                <div>
                    <label>Q&nbsp;&nbsp;&nbsp;Q：<span>*</span>&nbsp;</label>
                    <input class="busifo" id="qqId" type="text" name="qq" value="${userRequest.qq}"
                           onBlur="validatQQ()"/>&nbsp;<span class="busifo_condition">请填写真实QQ号码</span><span
                        id="QQSpan"></span>
                </div>
                <div>
                    <input id="decorate" type="submit" value="装饰"/>
                </div>
            </div>
            <div id="modifyUserInfoSuccess">
                <span>修改信息成功,请先关闭窗口当前窗口，然刷新页面</span>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>
