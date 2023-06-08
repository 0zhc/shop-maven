<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title>符合条件宝贝</title>
    <link href="<%=request.getContextPath()%>/shop/shop_css/search_hot_new_old.css" rel="stylesheet"/>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>
    <script type="text/javascript">
        //wuyixin
        //通过左边的商品分类搜索最热，最新，二手商品
        var userId = "${param.userId}";
        var goodsType = "${param.goodsType}";

        function query() {

            $('li').remove();//移掉<li>
            var path = '<%=path%>/';
            $.ajax({
                type: "POST",
                data: {'userId': userId, 'goodsType': goodsType},
                url: "${pageContext.request.contextPath}/findHotNewOldProInShop.do",
                dataType: "json",  //这个指定它是json（返回来得json对象）
                success: function (msg) {

                    if (msg.g != '') {

                        for (var i in msg.g) {

                            $('ul').append('<li><a href="' + path + 'goodsFindShop.do?type=datail&goodsId=' + msg.g[i].id + '"  target="_top"><img src="' + path + msg.g[i].url + '" /></a><span class="pro_name"><a href="">' + msg.g[i].name + '</a></span><span class="pro_price">' + msg.g[i].price + '元</span><a href="' + path + '/goodsFindShop.do?type=datail&goodsId=' + msg.g[i].id + '" class="buy"  target="_top"></a><a href="javascript:collectGood(' + msg.g[i].id + ');" class="collect"></a></li>');
                        }
                    } else {

                        $('ul').html('<span style=" margin-left:260px; color:#181818; font-size:14px;">对不起，没有你所收藏的商品</span>');
                    }

                }
            });
        }
    </script>
</head>

<body onload="query()">
<div id="search_prolist">

    <div id="search_condition">
        <div id="search_condition_title">
            <div id="condition_title_letter">
                <c:choose>
                    <c:when test="${param.goodsType==1}">
                        最热商品
                    </c:when>
                    <c:when test="${param.goodsType==2}">
                        最新商品
                    </c:when>
                    <c:otherwise>
                        二手商品
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>

    <div id="condition_goods">
        <ul></ul>
    </div>

</div>
</body>
</html>
