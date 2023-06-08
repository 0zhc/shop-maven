<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set value="${userNew.shop}" var="shop" scope="page"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <% int temp = Integer.parseInt(request.getParameter("template"));
        if (temp == 1) {
    %>
    <link href="<%=path %>/shop/shop_css/prolist.css" rel="stylesheet"/><!--这个是蓝色色的css-->
    <%
    } else {

    %>
    <link href="<%=path %>/shop/shop_css/red/prolist_red.css" rel="stylesheet"/><!--这个是红色的css-->
    <%
        }
    %>
    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path %>/js/index/ads.js"></script>
    <link href="<%=path %>/shop/shop_css/shopAds.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        * {
            padding: 0px;
            margin: 0px;
        }

        .modifytip {
            float: right;
            color: #0000FF;
            font-weight: bolder;
            font-size: 17px;
            display: none;
            background-color: #FFFFFF;
        }

    </style>
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
                KE.event.add(KE.$('example'), 'submit', function () {
                    KE.sync(id);
                });
            },
            items: [               //这个是新修改
                'fontname', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'link'],
            afterChange: function (id) {
                var countCurrent = KE.count(id, 'text');//输入了多少个字
                var count = 200 - countCurrent;//还可以输入多少个字
                document.getElementById("wordId").value = countCurrent;
                if (count < 0) {
                    count = -count;
                    KE.$('content_msg').innerHTML = "<font color='red'>您的输入已超出" + count + "个字</font>";
                } else {
                    KE.$('content_msg').innerHTML = "<font style='color:#2D2D2D; font-size:14px; font-family:宋体;'>您还可以输入" + count + "字</font>";
                }
            }
        });
    </script>
    <script type="text/javascript">

        $(function () {
            query(1);
            $('#shopEvaluate').click(function () {
                var u = $('#u').val();
                if (u == "") {
                    alert("您还没有登录,不能评价.请先登录");
                    return;
                }
                var content = KE.html('content1');   //获得评价内容
                if (KE.isEmpty('content1')) {
                    $('#content_msg').html("<font color='red'>店铺评价不能为空</font>");
                    return;
                } else if (KE.count('content1', 'text') > 200) {
                    $('#content_msg').html("<font color='red'>店铺评价不能多于200个字符</font>");
                    return;
                } else {
                    $('#content_msg').html("");
                }

                var wordId = $('#wordId').val();
                $('tr.shopEvaluationTr').remove();
                $('#num').html("");
                $('#prevPage').html("");
                $('#nextPage').html("");
                $('#pageNumDiv').html("");
                var shopId = '${param.shopId}';     //获得被评价的商品ID
                var length = $(':checked').length;   //判断是否匿名是否被选上

                $.ajax({
                    type: 'POST',
                    url: '<%=request.getContextPath() %>/shopEvaluation/addShopEvaluation.do?' + escape(new Date()),
                    data: {'wordId': wordId, 'content': content, 'shopId': shopId, 'anonymity': length},
                    dataType: 'json',
                    success: function (msg) {

                        showShopEvaluation(msg);
                        if (msg.login == "noLogin") {
                            ShowEvaluation();
                        } else if (msg.content == "noContent") {
                            $('#content_msg').html("<font color='red'>店铺评价不能为空</font>");

                        } else if (msg.content == "tooLong") {
                            $('#content_msg').html("<font color='red'>店铺评价不能超过200个字</font>");

                        }
                    }
                });
                KE.html("content1", "");
            });
        });

        function showShopEvaluation(msg) {
            for (var i in msg.shopEvaluations) {
                $('#messages').append("<tr class='shopEvaluationTr'><td  style='padding-left:20px; width:100px; padding-top:10px;'" +
                    " class='leaveMesser'>" + msg.shopEvaluations[i].authorName + ": </td><td style='text-align:left;' width='650px'>" + msg.shopEvaluations[i].content +
                    "</td></tr><tr style='text-align:right;'  class='shopEvaluationTr'><td colspan='2' style='color: #434343; font-size:13px; font-family:宋体;'>" + msg.shopEvaluations[i].createDate + "</td></tr>" +
                    "<tr  class='shopEvaluationTr'><td colspan='2' style='border-bottom:#999999  dotted 1px; height:1px;'>&nbsp;</td></tr>");

            }
            $('#messages').append("<tr  style='text-align:right; height:60px;' class='shopEvaluationTr'>" +
                "<td colspan='2' id='page'><span id='prevPage'></span>" +
                "<span id='num'></span><span id='nextPage'></span><span id='pageNumDiv'></span></td></tr>");


            if (msg.p.hasPrevPage == true) {
                var pp = msg.p.currentPage - 1;
                $('#prevPage').html("<a href='javascript:query(" + pp + ")'>上一页</a>");
            }
            if (msg.p.hasNextPage == true) {
                var np = msg.p.currentPage + 1;
                $('#nextPage').html("<a href='javascript:query(" + np + ")'>下一页</a>");
            }
            if (msg.shopEvaluations.length != 0) {
                $('#pageNumDiv').html("&nbsp;&nbsp;到第&nbsp;<input type=text style='width:19px; height:18px;' name=pagenum id=pagenum />&nbsp;页&nbsp;&nbsp;" +
                    "<input type=button value=确定 onclick=query($('#pagenum').val()) />");

            }
            var totalPage = msg.p.totalPage;
            var currentPage = msg.p.currentPage;

            if (totalPage <= 7) {

                for (var x = 1; x <= totalPage; x++) {

                    if (x == currentPage) {

                        $('#num').append("<span style='color:red;padding:0px 5px 0px 5px;'>" + x + "</span>&nbsp;");
                    } else {
                        $('#num').append("<a style='padding:0px 5px 0px 5px;' href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                    }
                }
            } else {

                if (currentPage <= 4) {
                    for (var x = 1; x <= 7; x++) {

                        if (x == currentPage) {

                            $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>");
                        } else {
                            $('#num').append("<a style='padding:0px 5px 0px 5px;'  href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                        }

                    }
                    $('#num').append("...");

                } else if (currentPage >= totalPage - 3) {
                    $('#num').append("...");
                    for (var x = totalPage - 6; x <= totalPage; x++) {
                        if (x == currentPage) {

                            $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>&nbsp;");
                        } else {
                            $('#num').append("<a style='padding:0px 5px 0px 5px;'  href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                        }


                    }
                } else {
                    $('#num').append("...");
                    for (var x = currentPage - 3; x <= currentPage + 3; x++) {

                        if (x == currentPage) {

                            $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>&nbsp;");
                        } else {
                            $('#num').append("<a style='padding:0px 5px 0px 5px;' href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                        }

                    }
                    $('#num').append("...");
                }
            }
        }

        function query(i) {

            if (i == "" || i == null) {
                i = 1;
            }

            $('tr.shopEvaluationTr').remove();
            $('#num').html("");
            $('#prevPage').html("");
            $('#nextPage').html("");
            $('#pageNumDiv').html("");
            var shopId = '${param.shopId}';
            $.ajax({
                type: "GET",
                data: {'currentPage': i, 'shopId': shopId},
                url: "<%=request.getContextPath()%>/shopEvaluation/pageShopEvaluation.do?" + escape(new Date()), //分页查询
                dataType: "json",  //这个指定它是json
                success: function (msg) {

                    showShopEvaluation(msg);

                }
            });
        }
    </script>
    <script type="text/javascript">
        $(function () {
            var isModify = '${isModify}';
            var loginId = '${user.id}';
            var userNewId = '${userNew.id}'

            if (loginId == userNewId) {
                if (isModify == 1) {
                    $("#hot_product,#new_product,#old_product,#other_product,#shop_advertisement").hover(function () {
                        $(this).addClass("mymodify");
                        $(this).children("a").show();
                        $(this).css("border", "red solid 1px");


                    }, function () {
                        if ($("#hot_product,#new_product,#old_product,#other_product,#shop_advertisement").index(this) == 4) {
                            $(this).css("border", "#a3c7da solid 1px");
                        } else {
                            $(this).css("border", "#d9d9d9 solid 1px");
                        }


                        $(this).children(".modifytip").hide();
                    }).css("cursor", "pointer");

                }
            }
        });
    </script>
    <script>
        $(function () {

            $("#showTip").mouseover(function () {
                $("#show").draggable({containment: "parent"});
            }).css("cursor", "move");
            $("#rolling").click(function () {

                window.parent.RollingSet();
            })
            $("#lasthot").click(function () {

                window.parent.ShowHotGoodsSet();
            })
            $("#new").click(function () {

                window.parent.ShowNewGoodsSet();
            })
            $("#second").click(function () {

                window.parent.ShowSecondSet();
            })
            $("#other").click(function () {

                window.parent.ShowOtherSet();
            })


        });

        function ShowEvaluation() {


            window.parent.ShowEvaluation();
        }

    </script>

    <script>
        //用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
        //author:wuyixin

        function collectGood(goodId) {

            if ('${user.id}' == '') {
                alert('请先登录');
            } else {

                if (confirm("是否要收藏商品？")) {

                    $.ajax({
                        type: "post",
                        url: "<%=request.getContextPath()%>/userCollectionGood.do?" + escape(new Date()),
                        data: {'goodId': goodId},
                        dataType: "html",
                        success: function (data, textStatus) {
                            if (data == "collectSuccess") {
                                alert("成功收藏商品");

                            } else if (data == 'hasCollection') {

                                alert("此商品已收藏");

                            } else if (data == 'donotLogin') {
                                alert("请先登录");
                            }
                        }

                    });
                }
            }
        }

    </script>

    <style type="text/css">
        #modify {
            height: 420px;
        }

        #modify_left, #modify_middle, #modify_right {
            float: left;
            height: 420px;
        }

        #modify_left {
            width: 12px;
            background: url(shop_image/shopModifyShow/modify_left.gif) no-repeat;
        }

        #modify_middle {
            background: url(shop_image/shopModifyShow/modify_middle.jpg) repeat-x;
            position: relative;
        }

        #modify_right {
            width: 12px;
            background: url(shop_image/shopModifyShow/modify_right.gif) no-repeat;
        }

        #close {
            float: right;
            position: absolute;
            top: 8px;
            left: 700px;
        }

        #close img {
            border: none;
        }
    </style>

</head>

<body>
<input type="hidden" name="shopId" id="shopId" value="${param.shopId }"/>
<input type="hidden" name="u" id="u" value="${sessionScope.user}"/>
<div id="shop_advertisement" style="border:#b3dbf1 solid 1px;">
    <a href="#" id="rolling" class="modifytip" style="display:none; position:absolute; z-index:60; margin-left:740px;"
       title="banerList" onClick="return false">修改</a>
    <div class="ad">

        <ul class="slider">

            <li><a href="javascript:void(0)"><img src="<%=path %>/shop/goods/ads1.jpg"/></a></li>
            <c:forEach items="${goodses}" var="goods">
                <c:if test="${goods.goodsType==0}">
                    <li><a href="javascript:void(0)"><img src="<%=path %>/${goods.url}"/></a></li>

                </c:if>
            </c:forEach>

        </ul>
        <ul class="num">
            <li><span class="begeinColor">1</span></li>
            <%int i = 2; %>
            <c:forEach items="${goodses}" var="goods" varStatus="varS" begin="0">
                <c:if test="${goods.goodsType==0}">
                    <li><span class="begeinColor"><%=i++ %></span></li>

                </c:if>
            </c:forEach>


        </ul>
    </div>
</div>

<c:if test="${shop.isShowHot==1}">
    <div id="hot_product" style="position:relative;">
        <a href="#" class="modifytip" style="display:none; position:absolute; z-index:60; margin-left:740px;"
           onClick="return false" title="lasthot" id="lasthot">修改</a>
        <div id="hotpro_litle" style=" position:relative;">

            <div id="hot_letter">最热商品</div>
            <div class="letter_right_back"></div>
        </div>
        <div id="hotpro_content">
            <ul>
                <%int hot = 0; %>
                <c:forEach items="${goodses}" var="goods">
                    <c:if test="${goods.goodsType==1}">
                        <li><a href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" target="_top"><img
                                src="<%=path %>/${goods.url}"/></a><span class="pro_name"><a href="">${goods.name }</a></span><span
                                class="pro_price">${goods.price}元</span><a
                                href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" class="buy"
                                target="_top"></a><a href="javascript:collectGood('${goods.id}');" class="collect"></a>
                        </li>
                        <%++hot; %>
                    </c:if>
                </c:forEach>
                <%
                    for (int j = 0; j < 4 - hot; j++) {
                %>
                <li style="width: 177px;height: 210px;">
                    <div style="background-color: #ccc;width: 177px;height: 210px; line-height:210px; text-align: center; ">
                        未上传最热商品
                    </div>
                </li>
                <%
                    }
                %>

            </ul>
        </div>
    </div>
</c:if>
<c:if test="${shop.isShowNew==1}">
    <div id="new_product" style="clear:both;">
        <a href="#" class="modifytip" id="new" style="display:none; position:absolute; z-index:60; margin-left:740px;"
           onClick="return false" title="newPro">修改</a>
        <div id="newpro_litle">
            <div id="new_letter">最新商品</div>
            <div class="letter_right_back"></div>
        </div>
        <div id="newpro_content">
            <ul>
                <%int newGoods = 0; %>
                <c:forEach items="${goodses}" var="goods">
                    <c:if test="${goods.goodsType==2}">
                        <li><a href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" target="_top"><img
                                src="<%=path %>/${goods.url}"/></a><span class="pro_name"><a href="">${goods.name }</a></span><span
                                class="pro_price">${goods.price}元</span><a
                                href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" class="buy"
                                target="_top"></a><a href="javascript:collectGood('${goods.id}');" class="collect"></a>
                        </li>
                        <%++newGoods; %>
                    </c:if>
                </c:forEach>
                <%
                    for (int j = 0; j < 4 - newGoods; j++) {
                %>
                <li style="width: 177px;height: 210px;">
                    <div style="background-color: #ccc;width: 177px;height: 210px; line-height:210px; text-align: center; ">
                        未上传最新商品
                    </div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</c:if>
<c:if test="${shop.isShowSecond==1}">
    <div id="old_product" style="clear:both;">
        <a href="#" class="modifytip" id="second"
           style="display:none; position:absolute; z-index:60; margin-left:740px;" title="secondGoods"
           onClick="return false">修改</a>
        <div id="oldpro_litle">
            <div id="old_letter">二手商品</div>
            <div class="letter_right_back"></div>
        </div>
        <div id="oldpro_content">
            <ul>
                <%int secondGoods = 0; %>
                <c:forEach items="${goodses}" var="goods">
                    <c:if test="${goods.goodsType==3}">
                        <li><a href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" target="_top"><img
                                src="<%=path %>/${goods.url}"/></a><span class="pro_name"><a href="">${goods.name }</a></span><span
                                class="pro_price">${goods.price}元</span><a
                                href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" class="buy"
                                target="_top"></a><a href="javascript:collectGood('${goods.id}');" class="collect"></a>
                        </li>
                        <%++secondGoods; %>
                    </c:if>
                </c:forEach>
                <%
                    for (int j = 0; j < 4 - secondGoods; j++) {
                %>
                <li style="width: 177px;height: 210px;">
                    <div style="background-color: #ccc;width: 177px;height: 210px; line-height:210px; text-align: center; ">
                        未上传二手商品
                    </div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</c:if>

<div id="other_product">
    <a href="#" id="other" class="modifytip" style="display:none; position:absolute; z-index:60; margin-left:740px;"
       title="allGoods" onClick="return false">修改</a>
    <div id="otherpro_litle">
        <div id="other_letter">${shop.otherText }</div>
        <div class="letter_right_back"></div>
    </div>


    <div id="otherpro_content">
        <ul>
            <%int otherGoods = 0; %>
            <c:forEach items="${goodses}" var="goods" varStatus="varS">
                <c:if test="${goods.goodsType==4}">


                    <li style="width:179px; height:210px; overflow:hidden;"><a
                            href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" target="_top"><img
                            src="<%=path %>/${goods.url}"/></a><span class="pro_name"><a
                            href="">${goods.name }</a></span><span class="pro_price">${goods.price}元</span><a
                            href="<%=path%>/goodsFindShop.do?type=datail&goodsId=${goods.id}" class="buy"
                            target="_top"></a><a href="javascript:collectGood('${goods.id}');" class="collect"></a></li>
                    <%++otherGoods; %>
                </c:if>
            </c:forEach>
            <%
                for (int j = 0; j < 8 - otherGoods; j++) {
            %>
            <li style="width:179px; height:210px;">
                <div style="background-color:#ccc; width:179px; height:210px; line-height:210px; text-align: center; ">
                    未上传商品
                </div>
            </li>
            <%
                }
            %>
        </ul>
    </div>

</div>

<div id="mess_box">
    <div id="mess_text">
        <form>
            <input type="hidden" name="wordId" id="wordId"/>
            <table>
                <tr>
                    <td colspan="2" class="leaveMesser">给店铺评价</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea name="content" style="width:939px; height: 125px;" id="content1"></textarea>
                        &nbsp;<span id="content_msg"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="checkbox" id="anonymity" name="anonymity" value="1"/>
                        <span id="anonymity_text">&nbsp;匿名</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:right;"><input type="button" id="shopEvaluate" value="给店铺评价"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<div id="contain_mess">
    <table id="messages" style="width:770px; ">
        <tr id="messages_top" style="width:770px;">
            <td colspan="2"
                style="padding-left:20px; font-size:14px; font-weight:900; color:#FFFFFF; line-height:40px; ">评价信息
            </td>
        </tr>

    </table>
</div>

</body>
</html>
