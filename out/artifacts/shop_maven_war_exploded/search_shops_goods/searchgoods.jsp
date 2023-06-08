<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>优复用商品搜索结果</title>
    <link href="<%=path%>/css/sysytem/managerIndex.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path%>/css/shopandgoods/goods.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path%>/css/search/search.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path%>/css/comm/backg_line.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path%>/css/shopandgoods/line.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path%>/css/shopandgoods/searchgoods_css.css" type="text/css" rel="stylesheet"/>

    <script src="<%=path%>/js/jquery-1.2.6.min.js"></script>

    <script src="<%=path%>/js/searchPack/jquery.bgiframe.js"></script><!-- 搜索导入包 -->
    <script src="<%=path%>/js/searchPack/search.js"></script><!-- 搜索导脚本-->
    <script src="<%=path%>/js/system/managerIndex.js"></script>
    <script src="<%=path%>/js/shopandgoods/good.js"></script>
    <script type="text/javascript">
        var path = '<%=path%>';//给js文件传输路径变量
    </script>
    <!-- 设置表格样式 -->
    <style type="text/css">
        #table {
            width: 780px;
            table-layout: fixed;
            border-collapse: collapse;
            font-size: 14px;
        }

        #table td {
            border: none;
            border-bottom: #ccc dashed 1px;
            text-align: center;
            height: 150px;
            overflow: hidden;
            width: 182px;
        }
        #table td:nth-child(2) {
            padding-left: 26px !important;
        }
        #table td:nth-child(n+2) {
            padding-left: 22px;
        }
        #table tr {
            height: 100px;
        }

        .price {
            color: #e90000;
            font-size: 14px;
            font-weight: 900;
        }

        #table img {
            width: 177px;
            height: 118px;
        }

        .sort {
            border: gray solid 1px;
        }

        .sort li {
            width: 80px;
            clear: both;
            background-color: #ccc;
            height: 20px;
            text-align: center;
            border-bottom: white dashed 1px;
            line-height: 22px;
        }

        #isNew {
            text-align: right;
        }

        #buyPro {
            color: #006697;
            text-decoration: none;
        }

        #buyPro:hover {
            color: #FF0909;
            text-decoration: underline;
        }
        #pageAction {
            position: absolute;
            z-index: 999;
            top: 901px;
            left: 169px;
        }
        #main_left {
            position: relative;
        }
        #table {
            height: 840px;
        }
    </style>
    <!-- 分页查询 -->
    <script type="text/javascript">
        var isNew = '${isNew}';
        var name = '${name}';
        var basePath = '<%=path%>/';//根路径
        var beginPrice = 0//$('#beginPrice').val();
        var endPrice = 5000//$('#endPrice').val();
        var isSore = 1; //默认为降序
        $(function () {
            $('#btn').click(function () {
                alert($('#hello').val());
            })

            $('#searchbtn').click(function () {
                var num = $('#searchnum').val();

                query(num);
            })

            var isNew = '${isNew}';

            if (isNew == 1) {
                $("#isNew").val("商品");

            }
            if (isNew == 2) {
                $("#isNew").val("二手商品");

            }
            if (isNew == 3) {
                $("#isNew").val("店铺");

            }

            query(1);
        })

        function searchByPrice(i) {
            beginPrice = $('#beginPrice').val();
            endPrice = $('#endPrice').val();
            var reg = /^[0-9]{1,20}$/;

            if (!reg.test(beginPrice) || !reg.test(endPrice)) {
                alert("输入必须为数字");
                return false;
            }
            query(i);
        }

        function searchBySore(i) {
            beginPrice = $('#beginPrice').val();
            endPrice = $('#endPrice').val();

            isSore = i; //为升序
            query(1);
        }

        //字符串装换函数
        function ReplaceAll(str, sptr, sptr1) {
            while (str.indexOf(sptr) >= 0) {
                str = str.replace(sptr, sptr1);
            }
            return str;
        }

        function query(i) {

            //   	alert(beginPrice+"tt"+endPrice);
            //var isSore=1;   //1为升序 2 为降序
            //$("#Resuxt").html("88");
            //return false;

            $('tr').remove();
            //$('tr:gt(1)').remove();
            $('#num').html("");
            $('#prevPage').html("");
            $('#nextPage').html("");
            $
                .ajax({
                    type: "POST",
                    data: {
                        'currentPage': i,
                        'isNew': isNew,
                        'name': name,
                        'beginPrice': beginPrice,
                        'endPrice': endPrice,
                        'isSore': isSore
                    },
                    url: "${pageContext.request.contextPath}/search_shops_goods/searchAllGoodsByName.do",
                    dataType: "json", //这个指定它是json
                    beforeSend: function (XMLHttpRequest) {
                        $("#loading").show();
                    },
                    success: function (msg) {

                        if (msg.p.totalPage == 0) {
                            $("#pageAction").hide();
                            $('table')
                                .append(
                                    '<tr ><td colspan="5" style="text-align: center;">对不起，没有想要的记录<td></tr>');
                            $('#total').text(0);
                            return false;
                        } else {
                            $("#pageAction").show();
                        }
                        for (var i in msg.goodsesJson) {

                            var imgUrl = basePath + msg.goodsesJson[i].url;
                            var imgUrlReplaced = ReplaceAll(imgUrl, "\\", "/");
                            var description = msg.goodsesJson[i].description.substring(0, 25) + "... ...";

                            var goodsName = msg.goodsesJson[i].name;

                            var goodsNameReprced = goodsName
                                .replace(
                                    name,
                                    '<font color="red" style="color:#e90000; font-weight:900;">' + name + '</font>');//对搜索关键字进行替换样色
                            $('table')
                                .append(
                                    '<tr><td><a href="' + path + '/goodsFindShop.do?type=datail&goodsId=' + msg.goodsesJson[i].id + '"><img src="'
                                    + imgUrlReplaced
                                    + '"/></a></td><td style="text-align:left;padding-left:10px; line-height:20px; ">名称：'
                                    + goodsNameReprced
                                    +
                                    '<br/>介绍：'
                                    + description
                                    + '</td><td>价格：<span class="price">'
                                    + msg.goodsesJson[i].price
                                    + '￥</span></td><td>数量：<font color="#0984FF">'
                                    + msg.goodsesJson[i].amount
                                    + msg.goodsesJson[i].amountUnit
                                    + '</font></td><td><a href="' + path + '/goodsFindShop.do?type=datail&goodsId=' + msg.goodsesJson[i].id + '" id="buyPro">购买....</a></td></tr>');
                        }


                        $('#totalPage').html(msg.p.totalPage);
                        $('#totalRecord').html(msg.p.totalRecord);
                        $('#total').html(msg.p.totalRecord);
                        if (msg.p.hasPrevPage == true) {
                            var pp = msg.p.currentPage - 1;
                            $('#prevPage').html(
                                "<a href='javascript:query(" + pp
                                + ")'>上一页</a>");
                        }
                        if (msg.p.hasNextPage == true) {

                            var np = msg.p.currentPage + 1;

                            $('#nextPage').html(
                                "<a href='javascript:query(" + np
                                + ")'>下一页</a>");
                        }

                        $('#lastPage').html(
                            "<a href='javascript:query(" + msg.p.totalPage
                            + ")'>尾页</a>");
                        $('#firstPage')
                            .html("<a href='javascript:query(1)'>首页</a>");
                        $('#currentPage').html("" + msg.p.currentPage);

                        var flat1 = false;
                        var flat2 = false;
                        var count = 0;
                        var totalPage = msg.p.totalPage;
                        var currentPage = msg.p.currentPage;

                        if (totalPage <= 7) {

                            for (var x = 1; x <= totalPage; x++) {

                                if (x == currentPage) {

                                    $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>&nbsp;");
                                } else {
                                    $('#num').append("<a class='numclass' style='padding:0px 5px 0px 5px;' href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                                }
                            }
                        } else {

                            if (currentPage <= 4) {
                                for (var x = 1; x <= 7; x++) {
                                    if (x == currentPage) {
                                        $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>");
                                    } else {
                                        $('#num').append("<a class='numclass'  style='padding:0px 5px 0px 5px;' href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                                    }
                                }
                                $('#num').append("...");
                            } else if (currentPage >= totalPage - 3) {
                                $('#num').append("...");
                                for (var x = totalPage - 6; x <= totalPage; x++) {
                                    if (x == currentPage) {

                                        $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>&nbsp;");
                                    } else {
                                        $('#num').append("<a class='numclass'  style='padding:0px 5px 0px 5px;' href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                                    }
                                }
                            } else {
                                $('#num').append("...");
                                for (var x = currentPage - 3; x <= currentPage + 3; x++) {

                                    if (x == currentPage) {

                                        $('#num').append("<span style='padding:0px 5px 0px 5px;color:red'>" + x + "</span>&nbsp;");
                                    } else {
                                        $('#num').append("<a class='numclass'  style='padding:0px 5px 0px 5px;' href='javascript:query(" + x + ")'>" + x + "</a>&nbsp;");
                                    }

                                }
                                $('#num').append("...");
                            }
                        }

                    },
                    complete: function (XMLHttpRequest, textStatus) {
                        $("#loading").hide();

                    }
                });
        }
    </script>

    <script type="text/javascript">
        function searchGoods() {
            document.getElementById("searchForm").submit();

        }

    </script>

</head>

<body>
<div class="backg2"></div>
<div class="backg"></div>

<div id="contain" style="width:1200px;overflow: hidden;">
    <div id="top">
        <ul id="top_left" style="width: 450px;">
            <li style="padding-left: 5px;">${user.callName }你好，欢迎来到优复用！</li>
            <li class="top_login"><a href="<%=path%>/index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right">
            <li><a href="<%=request.getContextPath() %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath() %>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
            <li id="trade_record" style="padding-right:5px;"><a href="#"
                                                                style="background-image:url(<%=path%>/images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
                <ul class="trade_main">
                    <li style="background-position:right center;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=bought">已买</a></li>
                    <li style="background-position:right center;padding-right:0px;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=sold">已卖</a></li>
                </ul>
            </li>

            <li id="collect_file"><a href="#"
                                     style="background-image:url(<%=path%>/images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:8px; ">收藏夹</a>
                <ul class="store_main">
                    <li style="background-position:right center; "><a
                            href="<%=path %>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="<%=path %>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>

            <c:if test="${! empty user}">
                <li style="position: relative; left:-28px"><a href="<%=path%>/user/loginOut.do">注销</a></li>
            </c:if>
        </ul>

    </div>
    <div id="banner" style="clear:both; height: 40px;width: 974px; "><a href=""><img
            src="<%=path%>/images/banners/taobao.jpg"/></a></div>
    <div id="search" style="height: 90px; margin-top: 58px;">
        <div id="logo"><img src="<%=path %>/images/logo.jpg"/></div>
        <div id="search_main" style="text-align: right;float: right; margin-top: 20px;">

            <form action="<%=path%>/searchgoodsMiddle.do" method="post"
                  id="searchForm">
                <div id="searchContain">
                    <ul id="menuMain">
                        <li style="margin-top: 10px; width: 20px; padding-left: 8px;">
                            <img src="<%=path%>/images/index/newImgs/searchTool.gif"/>
                        </li>
                        <li style="margin-top: 10px; width: 350px;">
                            <input type="text" name="name" id="name" style="width: 340px;"/>
                        </li>
                        <li style="margin-top: 10px; width: 90px;">
                            <input type="text" name="isNew" id="isNew"
                                   style="width: 60px; background-image: url(<%=path%>/images/index/newImgs/search_tip.gif); background-position: right top; background-repeat: no-repeat; padding-right: 15px;"
                                   value="商品" readonly="readonly"/>
                        </li>
                        <li
                                style="margin-top: 5px; margin-left: 5px; padding-left: 15px;">
                            <input type="image" src="<%=path%>/images/index/newImgs/searchButtom.gif"
                                   onclick="searchGoods();" style="border: none;"/>

                        </li>
                    </ul>
                </div>
            </form>
            <div id="selectItem" class="selectItemhidden">
                <div id="selectItemAd" class="selectItemtit bgc_ccc">
                    <h2 id="selectItemTitle" class="selectItemleft">
                        请选择搜索类型
                    </h2>
                    <div id="selectItemClose" class="selectItemright">
                        关闭
                    </div>
                </div>
                <div id="selectItemCount" class="selectItemcont">
                    <div id="selectSub">
                        <input type="checkbox" name="cr01" id="cr01" value="商品"/>
                        <label for="cr01">
                            商品
                        </label>
                        <input type="checkbox" name="cr02" id="cr02" value="店铺"/>
                        <label for="cr02">
                            店铺
                        </label>
                        <input type="checkbox" name="cr03" id="cr03" value="二手商品"/>
                        <label for="cr03">
                            二手商
                        </label>

                    </div>
                </div>


            </div>


        </div>
        <div id="register_load_openShop">

        </div>
    </div>


    <div id="main" style="height:950px;  padding-top:1px;width:1200px;overflow: hidden;">
        <div id="main_left" style=" width:994px; height:925px; overflow: hidden;">


            <div class="searchGoodTipSearch" style="padding-top:10px; border-bottom:#d9d9d9 solid 1px; height:30px;">
                <ul style="padding-left:5px;">
                    <li>共搜索到<span style="color:#e90000; font-size:13px; font-weight:900;" id="total"></span>个符合条件的商品。
                    </li>
                    <li style="    margin-left: 446px;
    width: 80px;" id="sortPrice">
                        <a href="#"
                           style="background-image:url(<%=path%>/images/index/tip1.jpg); padding-right:13px; background-position:right center; background-repeat:no-repeat; text-decoration:none; display:block; line-height:normal; padding-top:3px; color:#414141;"
                           id="sortTip">价格排序</a>
                        <ul class="sort">
                            <li><a href="javascript:void(0)" onclick="searchBySore(1)">升序</a></li>
                            <li><a href="javascript:void(0)" onclick="searchBySore(2)">降序</a></li>
                        </ul>
                    </li>
                    <li style="margin-left:14px; line-height:24px;">价格：</li>
                    <li><input type="text" style="width:50px;" name="beginPrice" id="beginPrice" value="0"/></li>
                    <li style="line-height:24px; margin-left:10px; margin-right:10px;">到</li>
                    <li><input type="text" style="width:50px;" name="endPrice" id="endPrice" value="5000"/></li>
                    <li style="margin-left:1px; margin-top: 2px;"><input type="image"
                                                                         src="<%=path%>/images/searchshopgood/searchButtom.jpg"
                                                                         onclick="searchByPrice(1)"/></li>
                </ul>
            </div>

            <div>
                <!-- test -->

                <div id="Resuxt" style="height: 840px; width: 994px;overflow: hidden;">
                    <div style="text-align: center;"><img src="<%=path%>/images/load/loading.gif" id="loading"
                                                          style="display: none;"/></div>
                    <table id="table">

                    </table>
                </div>
                <div style="text-align: center;" id="pageAction">
                    <span id="firstPage"></span>&nbsp;
                    <span id="prevPage"></span>&nbsp;
                    <span id="num"></span>&nbsp;
                    <span id="nextPage"></span>&nbsp;
                    <span id="lastPage"></span>&nbsp; 每页5条&nbsp; 共
                    <span id="totalRecord"></span>条记录&nbsp; 共
                    <span id="totalPage"></span>页&nbsp; 当前第
                    <span id="currentPage"></span>页&nbsp;
                    <span>
							<input type="text" id="searchnum" style="width: 50px;vertical-align:middle;"/>
                             </span>
                    <span  style="position: absolute; top: 0px;left: 570px;">
							<input type="image" id="searchbtn" src="<%=path%>/images/searchshopgood/go.gif"/>
                            </span>
                </div>
                <!-- test -->
            </div>
        </div>
        <div id="main_right" style="float: right;">
            <div id="main_right_top"></div>
            <div id="main_right_middle" style="margin-top:-18px;">
                <ul style="padding-left:11px; padding-right:2px;">
                    <li>
                        <div style="text-align:center; margin-bottom:5px; "><a
                                href="goodsFindShop.do?type=datail&goodsId=3"><img
                                src="<%=path%>/images/searchshopgood/introductPro/01.jpg"
                                style="width: 162px; height: 92px;"/></a></div>
                        <div style="text-align:center; margin-bottom:3px; color:#0185d0; font-size:13px;">夹心蛋黄月饼</div>
                        <div style=" height:32px; ">
                            <div style="float:left; width:100px; text-align:right;"><img
                                    src="<%=path%>/images/searchshopgood/onePrice.jpg"/></div>
                            <div style="float:left; width:40px; text-align:right; height:23px; line-height:23px;  color:#ed0000; font-size:14px; font-weight:900; ">
                                ￥3.0
                            </div>
                        </div>
                    </li>

                    <li>
                        <div style="text-align:center; margin-bottom:5px; "><a
                                href="goodsFindShop.do?type=datail&goodsId=2"><img
                                src="<%=path%>/images/searchshopgood/introductPro/02.jpg"
                                style="width: 162px; height: 108px;"/></a></div>
                        <div style="text-align:center; margin-bottom:3px; color:#0185d0; font-size:13px;">麦德隆干吃汤圆芝麻味
                        </div>
                        <div style=" height:32px; ">
                            <div style="float:left; width:100px; text-align:right;"><img
                                    src="<%=path%>/images/searchshopgood/onePrice.jpg"/></div>
                            <div style="float:left; width:40px; text-align:right; height:23px; line-height:23px;  color:#ed0000; font-size:14px; font-weight:900; ">
                                ￥0.5
                            </div>
                        </div>
                    </li>


                    <li>
                        <div style="text-align:center; margin-bottom:5px; "><a
                                href="goodsFindShop.do?type=datail&goodsId=24"><img
                                src="<%=path%>/images/searchshopgood/introductPro/03.jpg"
                                style="width: 162px; height: 108px;"/></a></div>
                        <div style="text-align:center; margin-bottom:3px; color:#0185d0; font-size:13px;">妙管家除湿盒</div>
                        <div style=" height:32px; ">
                            <div style="float:left; width:100px; text-align:right;"><img
                                    src="<%=path%>/images/searchshopgood/onePrice.jpg"/></div>
                            <div style="float:left; width:40px; text-align:right; height:23px; line-height:23px;  color:#ed0000; font-size:14px; font-weight:900; ">
                                ￥10.0
                            </div>
                        </div>
                    </li>

                    <li>
                        <div style="text-align:center; margin-bottom:5px; "><a
                                href="goodsFindShop.do?type=datail&goodsId=27"><img
                                src="<%=path%>/images/searchshopgood/introductPro/04.jpg"
                                style="width: 162px; height: 108px;"/></a></div>
                        <div style="text-align:center; margin-bottom:3px; color:#0185d0; font-size:13px;">便利贴</div>
                        <div style=" height:32px; ">
                            <div style="float:left; width:100px; text-align:right;"><img
                                    src="<%=path%>/images/searchshopgood/onePrice.jpg"/></div>
                            <div style="float:left; width:40px; text-align:right; height:23px; line-height:23px;  color:#ed0000; font-size:14px; font-weight:900; ">
                                ￥1.5
                            </div>
                        </div>
                    </li>

                    <li>
                        <div style="text-align:center; margin-bottom:5px; "><a
                                href="goodsFindShop.do?type=datail&goodsId=36"><img
                                src="<%=path%>/images/searchshopgood/introductPro/05.jpg"
                                style="width: 162px; height: 108px;"/></a></div>
                        <div style="text-align:center; margin-bottom:3px; color:#0185d0; font-size:13px;">
                            Adidas男式D66025
                        </div>
                        <div style=" height:32px; ">
                            <div style="float:left; width:100px; text-align:right;"><img
                                    src="<%=path%>/images/searchshopgood/onePrice.jpg"/></div>
                            <div style="float:left; width:40px; text-align:right; height:23px; line-height:23px;  color:#ed0000; font-size:14px; font-weight:900; ">
                                ￥409.0
                            </div>
                        </div>
                    </li>

                </ul>
            </div>
            <div id="main_right_bottom">

            </div>


        </div>
    </div>


    <div id="state">
        <div>
            <ul>
                <li>关于优复用</li>
                <li><a href="<%=path %>/help/help.jsp?menu=mqy&menuType=intro">优复用简介</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=mqy&menuType=injion">加入优复用</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=mqy&menuType=operate">合作专区</a></li>

            </ul>
        </div>
        <div>
            <ul>
                <li>免费开店</li>
                <li><a href="<%=path %>/help/help.jsp?menu=freeOpen&menuType=regis">注册开店</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=freeOpen&menuType=upload">上传产品</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=freeOpen&menuType=manager">店铺维护</a></li>

            </ul>

        </div>
        <div>
            <ul>
                <li>购物指南</li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyPoin&menuType=flor">购物流程</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyPoin&menuType=map">网站地图</a></li>


            </ul>

        </div>

        <div>
            <ul>
                <li>支付方式</li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyMethod&menuType=pay">如何支付</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyMethod&menuType=backPay">如何办理退款</a></li>


            </ul>

        </div>
        <div>
            <ul>
                <li>配送范围</li>
                <li><a href="<%=path %>/help/help.jsp?menu=scope&menuType=peixion">送货上门</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=scope&menuType=check">验货签收</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=scope&menuType=scopeantime">配送范围及配送时间</a></li>

            </ul>
        </div>

        <div>
            <ul>
                <li>售后服务</li>
                <li><a href="<%=path %>/help/help.jsp?menu=server&menuType=policity">退换货政策</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=server&menuType=backFlor">退货流程</a></li>


            </ul>

        </div>

    </div>
    <div id="footer">
        <div id="foot_main">
            <ul>
                <li><a href="<%=path %>/help/help.jsp?menu=newMember&menuType=1">新手上路</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=law&menuType=3">法律声明</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
            </ul>
        </div>
        <div style="margin-left: 443px; clear:both; text-align:center; margin-top:40px; color:#9b9b9b; font-size:12px;">&nbsp;优复用&nbsp;</div>

    </div>
</div>
<div class="line1"></div>
<div class="line2">
    <ul>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
</body>
</html>
