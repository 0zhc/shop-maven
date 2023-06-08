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
    <title>我的店铺</title>

    <link href="<%=path %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script>
        $(function () {
            //  window.location.href='<%=path %>/system/shop/prompt.do?type=prompt';

        });
    </script>
</head>

<body>
<div id="content">
    <form action="#">
        <table class="myshop">
            <tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
                <td colspan="2"><a>首页</a><span>>></span><a>后台管理</a><span>>></span>我的店铺</td>
            </tr>
            <tr>
                <td style=" font-size:14px; color:#666666; padding-top:10px; height:80px; line-height:20px; text-indent:30px;">
                    您好，欢迎到来优复用免费开店，本系统给社区提供免费开店，是一款简单的开店系统，由学生根据实际情况自主开发电子系统。欢迎广大社区参与，鼓励社区在网上创业，这是一款本地化的网店，交易只需要一个电话，或者短号。请多多支持。

            </tr>

            <tr>
                <td style=" text-align:center; height:30px;">
                    <c:choose>
                        <c:when test="${empty userNew.shop}">
                            <a href="myshop/ispromotOpenShop/selectInfor.jsp" name="mainContent">我要去开店</a>&nbsp;&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>&nbsp;&nbsp;&nbsp; <a href="<%=path %>/system/shop/prompt.do?Jsptype=modifyShop"
                                                           name="mainContent">查看我的店铺</a>&nbsp;&nbsp;&nbsp;</c:otherwise>
                    </c:choose>
                    <a href="javascript:history.go(-1);">返回</a></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
