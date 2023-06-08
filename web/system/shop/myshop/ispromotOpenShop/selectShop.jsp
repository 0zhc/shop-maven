<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的店铺</title>
    <link href="<%= path %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%= path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<div id="content">
    <form action="<%=path %>/system/updateShopTemplate.do">
        <input type="hidden" value="${shopId}" name="shopId"/>
        <table class="myshop">
            <tr style="line-height:21px;">
                <td colspan="3"><a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">我的店铺:选择店铺</a>
                </td>

            </tr>
            <tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
                <td colspan="2" style="color:#000000; font-size:18px; "><span
                        style="margin-left:200px; line-height:60px; ">最后一步：请选择店铺的模板</span></td>
                <td>操作</td>

            </tr>


            <tr>
                <td style="text-align:center;">模板一</td>
                <td style="text-align:center;"><img src="<%=path %>/shop/shop_image/selectShop/blue.jpg"
                                                    style="height:300px;"/></td>
                <td style="text-align:center;"><input type="radio" name="template" checked="checked" value="1"/>选择蓝色
                </td>
            </tr>
            <tr style="text-align:center;">
                <td>模板二</td>
                <td><img src="<%=path %>/shop/shop_image/selectShop/red.jpg" style=" height:300px;"/></td>
                <td><input type="radio" name="template" value="2"/>选择红色</td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;"><input type="submit" value="提交"/> &nbsp; &nbsp; &nbsp;<input
                        type="button" value="返回"/></td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>
