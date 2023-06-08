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
    <script type="text/javascript" src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#add').click(function () {

            });
        });
    </script>
    <style type="text/css">


        table td {
            border-right: 1px solid #CCC;
            border-bottom: 1px solid #CCC;
            text-align: center;
        }

        table {
            border-top: 1px solid #CCC;
            border-left: 1px solid #CCC;
        }

        table th {
            background-color: #CCC;
            text-align: center;
        }

        input {

            border: 1px solid #888;
        }

    </style>

    <title>商家广告设置</title>
</head>

<body style="background-color:#fafafa">

<form action="" method="post" class="regForm" id="regForm">
    <fieldset style="width:950px;margin-left: 25px; margin-right: 25px;">
        <legend>修改商家广告设置</legend>
        <div>你还可以添加${3-count}
            个商家广告设置
        </div>

        <table border="0" cellspacing="0" style="width: 100%;">
            <thead>
            <tr>
                <th width="220">广告图片</th>

                <th width="60">操作</th>
            </tr>
            </thead>
            <tbody>


            <c:forEach items="${rollingsGoods}" var="goods">
                <tr>
                    <td><img src="<%=path %>/${goods.url}" style="width:350px;height:100px"/></td>

                    <td>
                        <a href="<%=path %>/system/shop/myshop/goodsDetail.do?JspType=modify_bannerListDatail&goodsId=${goods.id}">修改</a>
                        &nbsp; &nbsp;&nbsp; <a
                            href="<%=path %>/shop/rollingGoods/delete.do?goodsId=${goods.id}&userId=${user.id}&userName=${user.userName}&shopId=${user.shop.id}&deleteType=deleteRolling">删除</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${count<3}">
                <tr>
                    <td colspan="3">
                        <input type="button" value="添加"
                               onclick="window.location.href='<%=path %>/shop/shopModify/productModify/addBannerList.jsp'"/>
                    </td>
                </tr>
            </c:if>
            <tr>
                <td colspan="3" style="height: 100px;font-size: 14px;">温馨提示：添加/修改成功后，请重新筛新一些游览器或者按 F5即可看到查看店铺装修后的效果</td>
            </tr>


            </tbody>
        </table>


    </fieldset>
</form>

</body>
</html>
