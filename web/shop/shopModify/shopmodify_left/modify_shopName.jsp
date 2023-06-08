<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>修改店铺名称</title>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function () {

            //如果商家数据全部为空，隐藏填写信息的表单
            if ('${empty shop.name}' == 'true') {

                $("#addComplete").hide();
            } else {
                //否则隐藏“马上添加”
                $("#if_add").hide();
            }

            //如果修改成功，显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
            if ('${!empty updateShopNameSuccess}' == 'true') {

                $("#modifyShopNameSuccess").show();
            } else {
                //否则不显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
                $("#modifyShopNameSuccess").hide();
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


        //验证店铺名称
        function validatshopName() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var shopName = document.getElementById("shopNameId").value;

            if (shopName.len() > 12) {
                document.getElementById("shopNameSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;店铺名称超过12个字符</font>";
                return false;
            } else if (shopName.len() < 1) {
                document.getElementById("shopNameSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;店铺名称不能为空</font>";
                return false;
            } else {
                document.getElementById("shopNameSpan").innerHTML = "";
                return true;
            }
        }


        //表单提交验证
        function validateForm() {
            return validatshopName();
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
            margin-left: 60px;
            font-family: 宋体;
            font-size: 14px;
            color: #424242;
        }

        #addComplete {
            width: 450px;
            margin-left: 60px;
        }

        #addComplete div {
            margin-top: 15px;
            font-family: 宋体;
            font-size: 14px;
            color: #424242;
        }

        #modifyShopNameSuccess {
            height: 30px;
            margin-top: 15px;
            margin-left: 20px;
            font-family: 宋体;
            font-size: 14px;
            color: #FF7D7D;
        }

        #decorate {
            margin-left: 110px;
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
    <form action="<%=request.getContextPath()%>/modifyShopName.do?userId=${userId}" method="post" id="regForm"
          onSubmit="return validateForm();">
        <fieldset>
            <legend>店铺名称</legend>
            <div id="if_add"><span>你还没有添加店铺名称&nbsp;&nbsp;&nbsp;&nbsp;</span><a id="add"
                                                                               href="javascript:void(0)">马上添加</a></div>
            <div id="addComplete">
                <div>
                    <label>店名：<span>*</span>&nbsp;</label>
                    <input class="busifo" id="shopNameId" type="text" name="shopName" value="${shop.name}"
                           onBlur="validatshopName()"/>&nbsp;<span
                        class="busifo_condition">1-12个字符，一个汉字为两个字符</span><span id="shopNameSpan"></span>
                    <input type="hidden" name="id" value="${shop.user.id }"/>
                </div>

                <div>
                    <input id="decorate" type="submit" value="装饰"/>
                </div>
            </div>
            <div id="modifyShopNameSuccess">
                <span>修改信息成功,请先关闭窗口当前窗口，然刷新页面</span>
                <br>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>
