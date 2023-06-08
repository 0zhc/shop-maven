<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
    <link type="text/css" rel="stylesheet" href="otherProduct.css"/>

</head>

<body>
<center>
    <div id="content" style="width:550px;">
        <fieldset>
            <legend>购买产品->下订单</legend>
            <form action="ordedetail.html">


                <table width="100%" border="0" cellspacing="0" class="myshop">

                    <tr>


                        <td><span style="color:red;">${errorInfo }</span> ${success }</td>

                    </tr>


                </table>
            </form>
        </fieldset>
    </div>
</center>
</body>
</html>
