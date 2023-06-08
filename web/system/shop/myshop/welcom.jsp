<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>我的店铺</title>
    <link href="<%=path%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path%>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        #content {
            position: relative;
        }

        #congratulat {
            position: absolute;
            left: 140px;
            top: 250px;
            font-size: 20px;
            font-family: 宋体;
            font-weight: 700;
            color: #008ED2;
        }

        #congraImg {
            position: absolute;
            height: 34px;
            width: 118px;
            left: 250px;
            top: 320px;
            background: url('<%=path%>/images/decorations.gif') no-repeat;
        }

        #decotext {
            position: absolute;
            left: 370px;
            top: 330px;
        }

        #decotext a {
            display: block;
            font-size: 16px;
            font-family: 宋体;
            font-weight: 700;
            color: #FF3333;
        }

        #decotext a:hover {
            color: #008ED2;
            text-decoration: none;
        }


    </style>

</head>

<body>
<div id="content">
    <form action="#">
        <table class="myshop">
            <tr style="line-height:21px;">
                <td colspan="3"><a>首页</a><span>>></span><a>后台管理</a><span>>></span><a>我的店铺:开店成功</a></td>

            </tr>

            <tr style="height: 600px;text-align: center; ">
                <td colspan="3" style="height: 600px; color: #333; font-size: 14px; ">
                    <div id="congratulat">恭喜您在优复用拥有了自己的网上店铺,请好好经营！</div>
                    <div id="congraImg"></div>
                    <span id="decotext"><a href="<%=request.getContextPath()%>/system/shop/prompt.do?Jsptype=userShop"
                                           target="_top">装修店铺去了！</a></span>

                </td>

            </tr>


        </table>
    </form>
</div>
</body>
</html>
