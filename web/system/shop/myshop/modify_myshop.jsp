<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的店铺修改</title>
    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <link href="<%=path %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="<%=path %>/cjmqyeditor/kindeditor.js"></script>

    <script>

        KE.show({
            id: 'content1',
            shadowMode: false,
            autoSetDataMode: false,
            syncType: '', //auto: 每次修改时都会同步; form:提交form时同步; 空:不会自动同步;
            allowPreviewEmoticons: false,
            resizeMode: false,
            afterCreate: function (id) {
                KE.event.add(KE.$('userShopModifyForm'), 'submit', function () {
                    KE.sync(id);
                });
            },
            items: [               //这个是新修改
                'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'link'],

            afterChange: function (id) {
                var count = 2000 - KE.count(id, 'text');
                if (count < 0) {
                    count = -count;
                    KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>" + count + "</font>字";
                } else {
                    KE.$('word_count').innerHTML = "您还可以输入" + count + "字";
                }
            }
        });


    </script>

    <script type="text/javascript">
        $(function () {
            var template = '${userNew.shop.template}';
            if (template == 1) {
                $('input[@name=template]').get(0).checked = true;
            } else if (template == 2) {
                $('input[@name=template]').get(1).checked = true;
            }

            //选中经营类型
            var temp = document.getElementById("shopBuyType");
            var shopBuyType = '${userNew.shop. shopBuyType}';
            for (var i = 0; i < temp.length; i++) {
                if (temp[i].value == shopBuyType) {
                    temp.value = shopBuyType;
                    break;
                }
            }

            //选中开店地址 学生
            var tempA = document.getElementById("shopBigAddress");
            var shopBigAddress = '${userNew.shop. shopBigAddress}';
            for (var i = 0; i < tempA.length; i++) {
                if (tempA[i].value == shopBigAddress) {
                    tempA.value = shopBigAddress;
                    break;
                }
            }
        })

    </script>

    <script type="text/javascript">
        function checkShopName() {
            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }
            var name = document.getElementById("name").value;
            var reg = /^[\u4E00-\u9FA5 A-Za-z0-9]{0,}$/;
            if (name == "") {
                document.getElementById("checkName").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入店铺名称！</font>";
                return false;
            } else if (!reg.test(name)) {
                document.getElementById("checkName").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;只能输入中文、英文、数字！</font>";
                return false;
            } else if (name.len() > 12) {
                document.getElementById("checkName").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长度不能超过12个字符！ </font>";
                return false;
            } else {
                document.getElementById("checkName").innerHTML = "";
                return true;
            }
        }

        function checkNumber() {
            var number = $("#number").val();
            if (number == null) {
                return true;
            }
            var reg = /^[0-9]{3,6}$/;
            if (number == "") {
                document.getElementById("checkNumber").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入宿舍号！</font>";
                return false;
            } else if (!reg.test(number)) {
                document.getElementById("checkNumber").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入正确的宿舍号！</font>";
                return false;
            } else {
                document.getElementById("checkNumber").innerHTML = "";
                return true;
            }
        }

        function checkNumber1() {
            var number1 = $("#number1").val();
            if (number1 == null) {
                return true;
            }
            var reg = /^[\u4E00-\u9FA5 A-Za-z0-9\-.]{0,}$/;
            if (number1 == "") {
                document.getElementById("checkNumber1").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入详细地点！</font>";
                return false;
            } else if (!reg.test(number1)) {
                document.getElementById("checkNumber1").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;只能输入中文  英文  数字  '.'  '-'！</font>";
                return false;
            } else if (number1.length > 30) {
                document.getElementById("checkNumber1").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长度不能超过30个字符！</font>";
                return false;
            } else {
                document.getElementById("checkNumber1").innerHTML = "";
                return true;
            }
        }

        function check() {

            if (KE.isEmpty('content1')) {
                document.getElementById("checkInfo").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入店铺介绍！</font>"
                return false;
            } else if (KE.count('content1', 'text') > 2000) {
                document.getElementById("checkInfo").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;店铺介绍不能超过2000个字符！</font>"
                return false;
            } else {
                document.getElementById("checkInfo").innerHTML = ""
            }
            return checkShopName() && checkNumber() && checkNumber1();
        }
    </script>

</head>

<body>
<div id="content">
    <form action="<%=path %>/system/modifyUserShop.do" method="post" id="userShopModifyForm" onsubmit="return check()">
        <table class="myshop">
            <tr style="line-height:21px;">
                <td colspan="2"><a>首页</a><span>>></span><a>后台管理</a><span>>></span><a>我的店铺</a></td>

            </tr>

            <tr>
                <td style="padding-left:10px;">经营类型<span style="color:#FF0000;">*</span></td>
                <td>
                    <select style="width:100px;" name="shopBuyType" id="shopBuyType">
                        <option value="开心食品">开心食品</option>
                        <option value="零食坊">零食坊</option>
                        <option value="数码产品">数码产品</option>
                        <option value="常用电器">常用电器</option>
                        <option value="服装服饰">服装服饰</option>
                        <option value="运动用品">运动用品</option>
                        <option value="学习用品">学习用品</option>
                        <option value="寸金书城">寸金书城</option>
                        <option value="美容护发">美容护发</option>
                        <option value="寸金订花">寸金订花</option>
                        <option value="订蛋糕">订蛋糕</option>
                        <option value="旅游">旅游</option>
                        <option value="旅游">快递</option>
                        <option value="寸金KTV">寸金KTV</option>
                        <option value="餐饮">餐饮</option>
                    </select></td>

            </tr>
            <tr>
                <td style=" padding-left:10px;width: 200px;">店铺网址<span style="color:#FF0000;">*</span></td>
                <td>
                    <div style="float: left; line-height: 29px;"><a href="<%=path %>/shop.do?id=${user.shop.id}"
                                                                    target="_top">${userNew.shop.url }</a></div>
                    <div style="float: right;width:90px;height:29px; padding-left:10px; background-image: url('<%=path %>/images/seeMyshop.jpg'); background-repeat: no-repeat;line-height: 30px;margin-right: 150px;">
                        <a href="<%=path %>/shop.do?id=${user.shop.id}" target="_top" style="color: white;">查看店铺</a>
                    </div>
                </td>
            </tr>
            <tr>
                <td style=" padding-left:10px;">店铺名称<span style="color:#FF0000;">*</span></td>
                <td><input name="name" type="text" value="${userNew.shop.name }" id="name"
                           onblur="checkShopName()"/><span id="checkName"></span></td>
            </tr>

            <tr>
                <td style=" padding-left:10px;">开店地点<span style="color:#FF0000;">*</span></td>
                <td>
                    <c:choose>
                        <c:when test="${userNew.userType==1}">
                            <select name="shopBigAddress" style="width:100px;" id="shopBigAddress">
                                <option value="崇祥苑">崇祥苑</option>
                                <option value="崇德苑">崇德苑</option>
                                <option value="崇明苑">崇明苑</option>
                                <option value="崇智苑">崇智苑</option>
                                <option value="进德苑">进德苑</option>
                                <option value="厚德苑">厚德苑</option>
                                <option value="齐家苑">齐家苑</option>
                                <option value="同源苑">同源苑</option>
                            </select>
                            宿舍号 <input type="text" value="${userNew.shop.shopDetailAddress}" name="shopDetailAddress"
                                       id="number" onblur="checkNumber()"/><span id="checkNumber"></span>
                        </c:when>
                        <c:otherwise>
                            <!-- 商家 -->
                            <select>
                                <option value="寸金" name="shopBigAddress">寸金</option>
                            </select>
                            <input type="text" value="${userNew.shop.shopDetailAddress}" name="shopDetailAddress"
                                   id="number1" onblur="checkNumber1()"/><span id="checkNumber1"></span>

                        </c:otherwise>

                    </c:choose>


                </td>


            </tr>


            <tr>
                <td style=" padding-left:10px;">店铺介绍<span style="color:#FF0000;">*</span></td>
                <td><textarea rows="16" cols="81" id="content1" style="width:650px;"
                              name="shopInfo">${userNew.shop.shopInfo}</textarea><span id="word_count"></span><span
                        id="checkInfo"></span></td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center;"><img src="<%=path %>/shop/shop_image/selectShop/blue.jpg"
                                                                height="150px;" style="vertical-align:middle;"/>蓝色<input
                        type="radio" name="template" checked="checked" value="1"/>
                    <img src="<%=path %>/shop/shop_image/selectShop/red.jpg" height="150px;"
                         style="vertical-align:middle;"/>红色<input type="radio" name="template" value="2"/></td>
            </tr>


            <tr style="text-align:center;">
                <td colspan="2"><input type="submit" value="修改"/>&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"/>&nbsp;&nbsp;&nbsp;<input
                        type="reset" value="返回"/></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
