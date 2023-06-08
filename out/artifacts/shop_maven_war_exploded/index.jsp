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
    <title>优复用</title>

    <meta name="keywords" content="优复用;网上免费开店;网上购物;旅游快递;社区创业创业平台;社区创业综合网"/>
    <meta name="description"
          content="优复用——阳江社区校园消费综合网站。优复用更是专属广东海洋大学学子的综合服务平台，为学子提供周边商家购物，旅游，兼职及二手商品交易等服务；同时也为社区提供免费开店的创业平台，让社区小本创业，自主经营。我们的宗旨：顾客至上，服务便民；让社区生活消费更省钱省力省时间，让社区创业兼职更容易!"/>
    <link rel="shortcut icon" href="favicon.ico"/>

    <link href="<%=path %>/css/index/index.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/index/ads.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/index/main_bottom.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/search/search.css" type="text/css" rel="stylesheet"/><!--引人搜索样式-->
    <link href="<%=path %>/css/comm/backg_line.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/index/index_2.css" type="text/css" rel="stylesheet"/>

    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path %>/js/searchPack/jquery.bgiframe.js"></script><!-- 搜索导入包 -->
    <script src="<%=path %>/js/searchPack/search.js"></script><!-- 搜索导脚本-->


    <script src="<%=path %>/js/index/ads.js"></script>
    <script src="<%=path %>/js/index/main_bottom.js"></script>
    <script src="<%=path %>/js/index/index.js"></script>
    <script src="<%=path %>/js/index/tab.js"></script>
    <script src="<%=path %>/js/jquery.lazyload.js"></script>
    <script type="text/javascript">
        function searchGoods() {
            document.getElementById("searchForm").submit();

        }

    </script>
    <script type="text/javascript">
        $(function () {
            var width = $("#top").css("width");
            $("#classfy_middle_main li").hover(function () {

                $(this).css("background-image", "url('<%=path %>/images/index/main_right_top_top.jpg')");

            }, function () {
                $(this).css("background-image", "url('<%=path %>/images/index/classfy_line.jpg')");
            }).css("cursor", "pointer");

        });
    </script>
    <style type="text/css">
        img {
            border: none;
        }

    </style>


    <script>
        function searchShop(isNew, shopBuyType) {

            var isNew = encodeURI(encodeURI(isNew));//编码，防止中文乱码
            var shopBuyType = encodeURI(encodeURI(shopBuyType));
            window.open("<%=request.getContextPath()%>/searchgoodsMiddle.do?name=&isNew=" + isNew + "&shopBuyType=" + shopBuyType, "_blank");
        }
    </script>
</head>

<body>
<div class="backg2"></div>
<div id="container">
    <div id="top">
        <ul id="top_left">
            <c:choose>
                <c:when test="${!empty user}">
                    <li style="margin-left:4px;">您好，欢迎(${user.callName })来到优复用！</li>
                </c:when>
                <c:otherwise>
                    <li style="margin-left:4px;">您好，欢迎来到优复用！</li>
                    <li class="top_login"><a href="cjmqylogin/login.jsp">请登陆</a></li>
                    <li class="top_rigister"><a href="cjmqylogin/res.jsp">免费注册</a></li>
                </c:otherwise>
            </c:choose>

        </ul>
        <ul id="top_right" style="margin-left: 250px;">
            <li><a href="<%=request.getContextPath() %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath() %>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
            <li id="trade_record" style="padding-right:5px;"><a href=""
                                                                style="background-image:url(images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
                <ul class="trade_main">
                    <li style="background-position:right center;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=bought">已买</a></li>
                    <li style="background-position:right center;padding-right:0px;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=sold">已卖</a></li>
                </ul>
            </li>

            <li id="collect_file"><a href="#"
                                     style="background-image:url(images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:8px; ">收藏夹</a>
                <ul class="store_main">
                    <li style="background-position:right center; "><a
                            href="<%=path %>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="<%=path %>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>
            <c:if test="${! empty user}">
                <li style="position: relative; left:-28px"><a href="<%=path %>/loginOut.do">注销</a></li>
            </c:if>
        </ul>
    </div>
    <!-- banner -->
    <div id="banner_top" style="clear:both; height: 40px;width: 974px; ">
        <a href=""><img src="<%=path%>/images/banners/002.gif"/></a>

    </div>


    <div id="search" style="height: 90px;">
        <div id="logo"><img src="<%=path%>/images/logo.jpg"/></div>
        <div id="search_main" style="float: right;">
            <form action="<%=path%>/searchgoodsMiddle.do" method="post" id="searchForm">
                <div id="searchContain" style="border: white solid 1px;margin-top: 18px;float: right;">
                    <ul id="menuMain">
                        <li style="margin-top: 10px; width: 20px; padding-left: 8px;">
                            <img src="images/index/newImgs/searchTool.gif"/>
                        </li>
                        <li style="margin-top: 10px; width: 350px;">
                            <input type="text" name="name" id="name" style="width: 340px;"/>
                        </li>
                        <li style="margin-top: 10px; width: 90px;">
                            <input type="text" name="isNew" id="isNew"
                                   style="width: 60px; background-image: url(images/index/newImgs/search_tip.gif); background-position: right top; background-repeat: no-repeat; padding-right: 15px;"
                                   value="商品" readonly="readonly"/>
                        </li>
                        <li
                                style="margin-top: 4px; margin-left: 24px">
                            <input type="image" src="images/index/newImgs/searchButtom.gif" onclick="searchGoods();"
                                   style="border: none;"/>

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
                            二手商品
                        </label>

                    </div>
                </div>
            </div>

        </div>

    </div>
    <div id="navigation" style=" width: 1200px;">
        <div id="navigation_left"></div>
        <div id="navigation_middle">
            <ul id="navigation_middle_menu">
                <li><a href="#"
                       style="color:#2e2e2e; background-image:url(images/index/navigation_menu_hover.jpg); background-repeat:no-repeat; background-position:center center;">首页</a>
                </li>
                <li><a href="<%=path %>/search_shops_goods/searchshops.jsp?isNewType=3&name=">优选商城</a></li>
                <li><a href="<%=request.getContextPath() %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
<%--                <li><a href="javascript:searchShop('店铺','旅游')" onclick="return linkClick(this)">旅游</a></li>--%>
<%--                <li><a href="javascript:searchShop('店铺','快递')" onclick="return linkClick(this)">快递</a></li>--%>
<%--                <li>--%>
<%--                    <a href="http://www.7daysinn.cn/inn_list.php?city=%E6%B9%9B%E6%B1%9F&zone=0&dtStart=2014-5-14&dtEnd=2014-5-15&hotel_name=%E8%AF%B7%E8%BE%93%E5%85%A5%E5%85%B3%E9%94%AE%E8%AF%8D">寸金订房</a>--%>
<%--                </li>--%>
<%--                <li><a href="javascript:searchShop('店铺','寸金KTV')" onclick="return linkClick(this)">优选KTV</a></li>--%>
                <li><a href="javascript:searchShop('二手商品')" onclick="return linkClick(this)">二手商品</a></li>
                <li>
                    <a href="https://tieba.baidu.com/f?ie=utf-8&kw=%E5%88%9B%E6%96%B0" target="_blank">创新吧</a>
                </li>
                <li><a href="help/help.jsp?menu=newMember&menuType=1">帮助中心</a></li>
            </ul>

        </div>
        <div id="navigation_right" style=""></div>
    </div>
    <div id="main" style=" width: 974px; height: 425px;">
        <div id="main_left" style="float: left; height: 425px;">
            <div id="classfy_top" style="padding-top:10px;">社区常用商品分类</div>
            <div id="classfy_middle">
                <ul id="classfy_middle_main">

                    <li><a href="javascript:searchShop('店铺','开心食品')">开心食品</a></li>

                    <li><a href="javascript:searchShop('店铺','零食坊')">零食坊</a></li>
                    <li><a href="javascript:searchShop('店铺','数码产品')">数码产品</a></li>
                    <li><a href="javascript:searchShop('店铺','常用电器')">常用电器</a></li>
                    <li><a href="javascript:searchShop('店铺','服装服饰')">服装服饰</a></li>
                    <li><a href="javascript:searchShop('店铺','运动用品')">运动用品</a></li>
                    <li><a href="javascript:searchShop('店铺','学习用品')">学习用品</a></li>
                    <li><a href="javascript:searchShop('店铺','寸金书城')">优选书城</a></li>
                    <li><a href="javascript:searchShop('店铺','美容护发')">美容护发</a></li>
                    <li><a href="javascript:searchShop('店铺','寸金订花')">优选订花</a></li>
                    <li><a href="javascript:searchShop('店铺','订蛋糕')">订蛋糕</a></li>
                    <li><a href="javascript:searchShop('店铺','旅游')">旅游</a></li>
                    <li><a href="javascript:searchShop('店铺','快递')">快递</a></li>
                    <li><a href="javascript:searchShop('店铺','寸金KTV')">优选KTV</a></li>
                    <li><a href="javascript:searchShop('店铺','餐饮')">餐饮</a></li>
                    <li><a href="javascript:searchShop('店铺','餐饮')">家具</a></li>
                </ul>

            </div>
            <div id="classfy_bottom"></div>

        </div>
        <div id="main_middle" style="height: 425px;margin-left: 6px;">
            <div id="main_middle_top">


                <div class="ad">
                    <ul class="slider">

                        <li><a href="#"><img src="images/goods/ads/mqy.jpg"/></a></li>
                        <li><a href="shop.do?id=1"><img src="images/goods/ads/01.jpg"/></a></li>
                        <li><a href="shop.do?id=3"><img src="images/goods/ads/02.jpg"/></a></li>
                        <li><a href="shop.do?id=4"><img src="images/goods/ads/03.jpg"/></a></li>
                        <li><a href="shop.do?id=2"><img src="images/goods/ads/04.jpg"/></a></li>
                    </ul>
                    <ul class="num">
                        <li><span class="begeinColor">1</span></li>
                        <li><span class="begeinColor">2</span></li>
                        <li><span class="begeinColor">3</span></li>
                        <li><span class="begeinColor">4</span></li>
                        <li><span class="begeinColor">5</span></li>
                    </ul>
                </div>
            </div>


            <div id="main_middle_middle"
                 style="height:30px; width:714px; background-image:url(images/index/fress_hot_line.jpg); background-repeat:repeat-x; background-position:bottom center;">
                <img src="images/index/main_middle_middle_tip.jpg"/><img src="images/index/fress_hot.jpg"/>
            </div>
            <div id="main_middle_bottom"
                 style=" clear:both; background-image:url(images/index/fress_hot_line1.jpg); background-repeat:repeat-x; background-position:bottom center; height: 144px;">
                <div class="global_module prolist">

                    <div class="prolist_content">
                        <ul>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=43"><img
                                        src="images/goods/ads/xxrd/01.jpg"
                                        alt=""/></a><span>新百伦男式M373WBL</span><strong
                                    style="color:#ff0000; font-weight:bolder;">$339.00</strong>
                                <span style="text-decoration:line-through;">$400.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=10"><img
                                        src="images/goods/ads/xxrd/02.jpg" alt=""/></a><span>旺旺吸吸冰</span><strong
                                    style="color:#ff0000; font-weight:bolder;">$3.00</strong>
                                <span style="text-decoration:line-through;">$4.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=66"><img
                                        src="images/goods/ads/xxrd/03.jpg" alt=""/></a><span>华硕主板</span><strong
                                    style="color:#ff0000; font-weight:bolder;">$429.00</strong>
                                <span style="text-decoration:line-through;">$455.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=45"><img
                                        src="images/goods/ads/xxrd/04.jpg"
                                        alt=""/></a><span>Puma男35499905</span><strong
                                    style="display:inline-block; padding-left:3px;color:#ff0000; font-weight:bolder;">$489.00</strong>
                                <span style="text-decoration:line-through;">$500.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=64"><img
                                        src="images/goods/ads/xxrd/05.jpg" alt=""/></a><span>技嘉主板</span><strong
                                    style="color:#ff0000; font-weight:bolder;">$359.00</strong>
                                <span style="text-decoration:line-through;">$370.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=44"><img
                                        src="images/goods/ads/xxrd/06.jpg"
                                        alt=""/></a><span style="display:block;width: 113px;text-align: center">Puma男1PU35615601</span><strong
                                    style="display:inline-block; padding-left:4px;color:#ff0000; font-weight:bolder;">$599.00</strong>
                                <span style="text-decoration:line-through;">$650.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=9"><img src="images/goods/ads/xxrd/07.jpg"
                                                                                      alt=""/></a><span
                                    style="display:block;width: 113px;text-align: center">芒果干</span><strong
                                    style="display:inline-block; padding-left:14px;color:#ff0000; font-weight:bolder;">$10.00</strong>
                                <span style="text-decoration:line-through;">$12.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=46"><img
                                        src="images/goods/ads/xxrd/08.jpg"
                                        alt=""/></a><span style="display:block;width: 113px;text-align: center">Puma男35382607</span><strong
                                    style="display:inline-block; padding-left:5px;color:#ff0000; font-weight:bolder;">$415.00</strong>
                                <span style="text-decoration:line-through;">$500.00</span></li>
                            <li><a href="goodsFindShop.do?type=datail&goodsId=63"><img
                                    src="images/goods/ads/xxrd/09.jpg" alt=""/></a><span
                                    style="display:block;width: 113px;text-align: center">三星120G固态硬盘</span><strong
                                    style="display:inline-block; padding-left:5px;color:#ff0000; font-weight:bolder;">$289.00</strong>
                                <span style="text-decoration:line-through;">$300.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=11"><img
                                        src="images/goods/ads/xxrd/10.jpg" alt=""/></a><span
                                    style="display:block;width: 113px;text-align: center">意式千层糕</span><strong
                                    style="display:inline-block; padding-left:18px;color:#ff0000; font-weight:bolder;">$2.00</strong>
                                <span style="text-decoration:line-through;">$2.50</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=65"><img
                                        src="images/goods/ads/xxrd/11.jpg" alt=""/></a><span
                                    style="display:block;width: 113px;text-align: center">微星主板</span><strong
                                    style="display:inline-block; padding-left:8px;color:#ff0000; font-weight:bolder;">$429.00</strong>
                                <span style="text-decoration:line-through;">$435.00</span></li>
                            <li>
                                <a href="goodsFindShop.do?type=datail&goodsId=12"><img
                                        src="images/goods/ads/xxrd/12.jpg" alt=""/></a><span
                                    style="display:block;width: 113px;text-align: center">浏乡飘香青豆</span><strong
                                    style="color:#ff0000; font-weight:bolder;">$10.00</strong>
                                <span style="text-decoration:line-through;">$11.00</span></li>
                        </ul>
                    </div>


                </div>
                <div class="module_left_right" style="position:relative;">
                    <img class="goLeft" src="images/index/main_middle_bottom_righttip.jpg" alt=""
                         style="left: -1px;
    top: -69px; position:absolute;"/><img
                        class="goRight" src="images/index/main_middle_bottom_lefttip.jpg" alt=""
                        style="left: 702px;
    position: absolute;
    top: -67px;"/></div>
            </div>

        </div>

        <div id="main_right" style="float: right; height: 425px;">
            <div id="register_load_openShop" style="height: 35px;">
                <ul id="register_load_openShop_main" style=" width: 212px;">
                    <li id="login"><a href="<%=path %>/cjmqylogin/login.jsp">登陆</a></li>
                    <li id="rigister"><a href="<%=path %>/cjmqylogin/res.jsp">免费注册</a></li>
                    <li id="openshop" style="float: right;"><a
                            href="<%=path %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
                </ul>
            </div>
            <div id="main_right_top" style="float: right;">
                <div id="main_right_top_top">
                    <ul>
                        <li style="padding-left:3px;"><a href="#"
                                                         style="background-image:url(images/index/main_right_hover.jpg); ">创业政策</a>
                        </li>
                        <li style="background-image:none;"><a href="#">就业动态</a></li>

                    </ul>

                </div>
                <div id="main_right_top_middle">
                    <div>
                        <ul>
                            <li><a href="https://www.yjbys.com/chuangye/zhengce/579226.html" target="_blank">高校毕业生就业创业政策指南</a>
                            </li>
                            <li>
                                <a href="https://www.yjbys.com/chuangye/ziliao/634375.html"
                                   target="_blank">社区创新创业事迹材料</a>
                            </li>
                            <li>
                                <a href="https://www.yjbys.com/chuangye/xiangmu/535755.html" target="_blank">社区创业项目</a>
                            </li>
                            <li>
                                <a href="https://www.yjbys.com/chuangye/xiangmu/535199.html" target="_blank">互联网创业项目</a>
                            </li>

                        </ul>
                    </div>
                    <div style="display:none;">
                        <ul>
                            <li><a href="https://www.collegejy.cn/" target="_blank">社区就业网</a></li>
                            <li>
                                <a href="https://www.yjbys.com/qiuzhizhinan/" target="_blank">求职指导</a>
                            </li>
                            <li><a href="https://www.yjbys.com/mianshi/" target="_blank">面试问题与技巧大全</a></li>
                            <li><a href="https://www.yjbys.com/mianshi/mianshiziwojieshao/" target="_blank">面试自我介绍</a>
                            </li>

                        </ul>
                    </div>

                </div>
                <div id="main_right_top_bottom"></div>
            </div>

            <div id="main_right_middle" style="float: right;height: 139px;">
                <div id="studentNewTop"><span style=" margin-left:20px;">优选文采</span></div>
                <div id="studentNewMidlle">
                    <ul>
                        <li><a href="https://www.yjbys.com/zhengwen/1174947.html" target="_blank">逐梦路上征文文选</a></li>
                        <li><a href="https://www.yjbys.com/zhengwen/2748735.html" target="_blank">筑梦路上征文</a></li>
                        <li><a href="https://www.yjbys.com/edu/shengyueqiyue/389612.html" target="_blank">逐梦飞翔古筝谱</a></li>
                        <li><a href="https://www.yjbys.com/zhengwen/742343.html" target="_blank">助学筑梦铸人征文</a></li>
                        <li><a href="https://www.yjbys.com/zhengwen/769416.html" target="_blank">放飞中国梦征文</a></li>
                        <li><a href="https://www.yjbys.com/zhengwen/733627.html" target="_blank">爱国主义征文</a></li>
                        <li><a href="https://www.yjbys.com/zhengwen/722366.html" target="_blank">环保征文</a></li>
                    </ul>
                </div>
                <div id="studentBottom"></div>

            </div>

            <div id="main_right_bottom" style="float: right;margin-top: 1px;">
                <div><a href="#"><img src="images/Ads/house.jpg"/></a></div>
                <div><a href="#"><img src="images/Ads/kuaidi.jpg"/></a></div>
            </div>
        </div>

    </div>


    <div id="banner_first" style="clear:both; height: 43px;width: 974px;">
        <a href="shop.do?id=2"><img src="<%=path%>/images/banners/sssq.jpg"/></a>


    </div>
    <div id="shop_introduce" style=" width: 974px; height: 390px;">
        <div id="shop_introduce_left">
            <div id="shop_introduce_left_top" style="line-height:43px;">
                <span style=" margin-left:56px;">店铺推荐</span>
                <span class="more"><a href="<%=path %>/search_shops_goods/searchshops.jsp?isNewType=3&name="
                                      style="color:#999999; text-decoration:none;" id="more">更多>></a></span></div>
            <div id="shop_introduce_left_middle" style="height: 376px;">

                <div id="shop_troduct_top">


                    <div style="margin-left:-4px;">
                        <p><a href="shop.do?id=1"><img src="images/index/shoperlogo/90shi.jpg"/></a></p>
                        <p>

                        <ul>
                            <li class="shop_introduce_describe_head">90食</li>
                            <li></li>
                            <li><span class="member">主营零食</span></li>
                        </ul>
                        </p>
                    </div>

                    <div>
                        <p><a href="shop.do?id=2"><img src="images/index/shoperlogo/sslogo.jpg" class="size2"/></a></p>


                        <p>
                        <ul>
                            <li class="shop_introduce_describe_head">宿舍神器</li>
                            <li></li>
                            <li><span class="member">宿舍用品</span></li>
                        </ul>
                        </p>
                    </div>


                    <div>
                        <p><a href="shop.do?id=3"><img src="images/index/shoperlogo/8haologo.jpg"/></a></p>
                        <p>

                        <ul>
                            <li class="shop_introduce_describe_head">8号当铺</li>
                            <li></li>
                            <li><span class="member">运动鞋</span></li>
                        </ul>
                        </p>
                    </div>


                    <div>
                        <p><a href="shop.do?id=4"><img src="images/index/shoperlogo/DIY.jpg"/></a></p>
                        <p>

                        <ul>
                            <li class="shop_introduce_describe_head">DIY</li>
                            <li></li>
                            <li><span class="member">电脑配件</span></li>
                        </ul>
                        </p>
                    </div>


                    <div>
                        <p><a href="shop.do?id=5"><img src="images/index/shoperlogo/logo.jpg"/></a></p>
                        <p>

                        <ul>
                            <li class="shop_introduce_describe_head">崇明507</li>
                            <li></li>
                            <li><span class="member">二手物品</span></li>
                        </ul>
                        </p>
                    </div>

                    <!--
                     <div>
                    <p> <a href="#" ><img src="images/shop/shop.jpg" /></a></p>
                    <p>

                     <ul>
                       <li class="shop_introduce_describe_head">寸金快递</li>
                        <li>市场价:￥500</li>
                        <li>会员价：<span class="member">￥200</span></li>
                      </ul>
                      </p>
                    </div>
                    -->


                </div>
                <div id="shop_troduct_bottom"></div>

            </div>
            <div id="shop_introduce_left_bottom"></div>
        </div>
        <div id="shop_introduce_right">


            <div><a
                    href="http://189.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.WWoUB2&user_number_id=809107100&rn=ff7e6da888e37cea93bbb3f9dd6b38e9"><img
                    src="images/goods/dianxin.jpg"/></a></div>
            <div><a href="http://xiaomi.tmall.com/index.htm?spm=p413746989.1.w5002-3938203029.2.TUNd3U"><img
                    src="images/goods/xiaomi.jpg"/></a></div>
            <div>
                <a href="http://loreal.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.XFS7zS&user_number_id=533497499&rn=0a6987cb4c317873bcfe26ab557f0b58"><img
                        src="images/goods/oly.jpg"/></a></div>
            <div>
                <a href="http://meadjohnson.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.G4obcW&user_number_id=1659070416&rn=28accb6659f6b5d904ddc3178a28dc89"><img
                        src="images/goods/mzc.jpg"/></a></div>
            <div>
                <a href="http://spalding.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.b8CjcV&user_number_id=394694533&rn=769e0a8b6d164259bc2fbf60dbc70605"><img
                        src="images/goods/sbd.jpg"/></a></div>
            <div>
                <a href="http://dabao.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.T4xQMw&user_number_id=500327991&rn=25db20b5a50f34b9cdc31e347ee547c2"><img
                        src="images/goods/db.jpg"/></a></div>
            <div>
                <a href="http://gd10010.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.KbX5OR&user_number_id=747143122&rn=90449b374f51d39aee0b23bf8ccbc6a4"><img
                        src="images/goods/lt.jpg"/></a></div>
            <div>
                <a href="http://nike.tmall.com/shop/view_shop.htm?spm=a220m.1000862.1000730.2.nagGct&user_number_id=890482188&rn=34f6a006ed878901c3f800155ff05f6a"><img
                        src="images/goods/nike.jpg"/></a></div>

        </div>

    </div>
    <div id="good_introduce">
        <div id="good_introduce_left">
            <div>
                <div id="good_introduce_left_top"><span class="two"
                                                        style="margin-left:42px; color:#FFFFFF; font-size:14px; font-weight:bolder;">二手商品热卖</span><span
                        style="margin-left:530px; font-size:14px;  "><a href="javascript:searchShop('二手商品')"
                                                                        class="more1"
                                                                        style="text-decoration:none; color:#666666;"
                                                                        onclick="return linkClick(this)">更多>></a></span>
                </div>
                <div id="good_introduce_left_middle">
                    <ul>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=67"><img
                                    src="images/shop/eshou/01.jpg"/></a><br/>
                            <p>PSP</p>
                            <p>原价:<span>￥500</span></p>
                            <p>现价:<span>￥50</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=68"><img
                                    src="images/shop/eshou/02.jpg"/></a><br/>
                            <p>吹风筒</p>
                            <p>原价:<span>￥70</span></p>
                            <p>现价:<span>￥15</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=69"><img
                                    src="images/shop/eshou/03.jpg"/></a><br/>
                            <p>小风扇</p>
                            <p>原价:<span>￥70</span></p>
                            <p>现价:<span>￥35</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=70"><img
                                    src="images/shop/eshou/04.jpg"/></a><br/>
                            <p>帽子</p>
                            <p>原价:<span>￥20</span></p>
                            <p>现价:<span>￥12</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=71"><img
                                    src="images/shop/eshou/05.jpg"/></a><br/>
                            <p>魔术牌</p>
                            <p>原价:<span>￥20</span></p>
                            <p>现价:<span>￥15</span></p>
                        </li>

                    </ul>


                </div>
                <div id="good_introduce_left_bottom"></div>

            </div>

            <div id="ratherPrice" style="margin-top: 10px;">
                <div id="ratherPrice_top" style="line-height:38px;"><span class="two"
                                                                          style="margin-left:54px; color:#FFFFFF; font-size:14px; font-weight:bolder;">特价促销</span><span
                        style="margin-left:530px;  font-size:14px; "></span></div>
                <div id="ratherPrice_middle">
                    <ul>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=42"><img
                                    src="images/shop/tejia/01.jpg"/></a><br/>
                            <p class="fis">新百伦中性M400SKB</p>
                            <p>原价:<span>￥600</span></p>
                            <p>现价:<span>￥449</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=8"><img
                                    src="images/shop/tejia/02.jpg"/></a><br/>
                            <p>草莓干</p>
                            <p>原价:<span>￥30</span></p>
                            <p>现价:<span>￥16</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=62"><img
                                    src="images/shop/tejia/03.jpg"/></a><br/>
                            <p>日立笔记本硬盘</p>
                            <p>原价:<span>￥400</span></p>
                            <p>现价:<span>￥289</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=26"><img
                                    src="images/shop/tejia/04.jpg"/></a><br/>
                            <p>挂牌留言榜</p>
                            <p>原价:<span>￥20</span></p>
                            <p>现价:<span>￥10</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=67"><img
                                    src="images/shop/tejia/05.jpg"/></a><br/>
                            <p>复习资料</p>
                            <p>原价:<span>￥500</span></p>
                            <p>现价:<span>￥50</span></p>
                        </li>

                    </ul>


                </div>
                <div id="ratherPrice_bottom"></div>

            </div>
            <div id="banner2" style="width:899px; overflow:hidden;margin-top: 5px;">
                <a href="#"><img src="images/index/banner2.jpg" style="border:none; width:899px;margin-left: 1px"/></a>
            </div>
            <div id="newGoods" style="margin-top: 10px;">
                <div id="newGoods_top" style="line-height:38px;"><span class="two"
                                                                       style="margin-left:55px; color:#FFFFFF; font-size:14px; font-weight:bolder;">新品推荐</span><span
                        style="margin-left:530px;  font-size:14px; "><a
                        href="<%=path %>/searchgoodsMiddle.do?name=&isNew=%25E5%2595%2586%25E5%2593%2581&shopBuyType=%25E5%2595%2586%25E5%2593%2581"
                        style="color:#999999; text-decoration:none;" class="more4" id="more">更多>></a></span></div>
                <div id="newGoods_middle" style="padding-bottom: 20px;">
                    <ul>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=53"><img src="images/shop/xinpin/01.jpg"/></a><br/>
                            <p>英特尔i3CPU</p>
                            <p>原价:<span>￥800</span></p>
                            <p>现价:<span>￥759</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=54"><img src="images/shop/xinpin/02.jpg"/></a><br/>
                            <p>英特尔i5CPU</p>
                            <p>原价:<span>￥1245</span></p>
                            <p>现价:<span>￥1239</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=57"><img src="images/shop/xinpin/03.jpg"/></a><br/>
                            <p>英特尔i7CPU</p>
                            <p>原价:<span>￥2190</span></p>
                            <p>现价:<span>￥1999</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=38"><img src="images/shop/xinpin/04.jpg"/></a><br/>
                            <p>Nike男式631044</p>
                            <p>原价:<span>￥6390</span></p>
                            <p>现价:<span>￥629</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=39"><img src="images/shop/xinpin/05.jpg"/></a><br/>
                            <p>Nike男式511881</p>
                            <p>原价:<span>￥359</span></p>
                            <p>现价:<span>￥329</span></p>
                        </li>

                    </ul>

                    <ul>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=40"><img src="images/shop/xinpin/06.jpg"/></a><br/>
                            <p>Nike男式599190</p>
                            <p>原价:<span>￥549</span></p>
                            <p>现价:<span>￥519</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=41"><img src="images/shop/xinpin/07.jpg"/></a><br/>
                            <p>新百伦女式W373OAB</p>
                            <p>原价:<span>￥499</span></p>
                            <p>现价:<span>￥469</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=32"><img src="images/shop/xinpin/08.jpg"/></a><br/>
                            <p>Adidas男式M17999</p>
                            <p>原价:<span>￥429</span></p>
                            <p>现价:<span>￥409</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=36"><img src="images/shop/xinpin/09.jpg"/></a><br/>
                            <p>Adidas男式D66025</p>
                            <p>原价:<span>￥429</span></p>
                            <p>现价:<span>￥409</span></p>
                        </li>
                        <li>
                            <a href="goodsFindShop.do?type=datail&goodsId=37"><img src="images/shop/xinpin/10.jpg"/></a><br/>
                            <p>Adidas女式M19777</p>
                            <p>原价:<span>￥369</span></p>
                            <p>现价:<span>￥359</span></p>
                        </li>

                    </ul>


                </div>
                <div id="newGoods_bottom"></div>
            </div>
        </div>
        <div id="good_introduce_right" style=" border:#FFFFFF solid 1px;float: right;">
            <div>
                <div id="good_introduce_right_top"><span
                        style="color:#0084cc; font-size:14px; font-weight:bolder;">销售排行版</span></div>
                <div id="good_introduce_right_middle" style="height: 385px;">
                    <ul>
                        <li>
                            <div>1</div>
                            <div><a href="goodsFindShop.do?type=datail&goodsId=1"><img
                                    src="images/goods/paihang/01.jpg"/></a></div>
                            <div class="move">
                                <p>海牌海苔</p>
                                <p>价格：<span>￥10.0</span></p>
                            </div>

                        </li>

                    </ul>


                    <ul>
                        <li>
                            <div>2</div>
                            <div><a href="goodsFindShop.do?type=datail&goodsId=2"><img
                                    src="images/goods/paihang/02.jpg"/></a></div>
                            <div class="move">
                                <p>麦德隆干吃汤圆芝麻味</p>
                                <p>价格：<span>￥0.5</span></p>
                            </div>

                        </li>

                    </ul>


                    <ul>
                        <li>
                            <div>3</div>
                            <div><a href="goodsFindShop.do?type=datail&goodsId=3"><img
                                    src="images/goods/paihang/03.jpg"/></a></div>
                            <div class="move">
                                <p>夹心蛋黄月饼</p>
                                <p>价格：<span>￥3.0</span></p>
                            </div>

                        </li>

                    </ul>
                    <ul>
                        <li>
                            <div>4</div>
                            <div><a href="goodsFindShop.do?type=datail&goodsId=4"><img
                                    src="images/goods/paihang/04.jpg"/></a></div>
                            <div class="move">
                                <p>EGO金小熊饼干</p>
                                <p>价格：<span>￥34.0</span></p>
                            </div>

                        </li>

                    </ul>

                    <ul>
                        <li>
                            <div>5</div>
                            <div><a href="goodsFindShop.do?type=datail&goodsId=5"><img
                                    src="images/goods/paihang/05.jpg"/></a></div>
                            <div class="move">
                                <p>炎亭渔夫鱼板烧</p>
                                <p>价格：<span>￥2.5</span></p>
                            </div>

                        </li>

                    </ul>

                </div>
                <div id="good_introduce_right_bottom"></div>
            </div>
            <div id="hotTopic">
                <div id="hotTopic_top"><span
                        style="color:#0084cc; font-size:14px; font-weight:bolder;">微博话题</span></div>
                <div id="hotTopic_middle">
                    <ul>
                        <li>
                            <a href="http://weibo.com/p/10080898da31549cf81c664d764e1c0c40e6d5?k=%E5%A4%A7%E5%AD%A6%E7%94%9F%E5%88%9B%E4%B8%9A&from=huati_topic"
                               target="_blank">社区创业<img
                                    src="images/index/weibo.jpg" style="display: none;"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/topic?q=%E5%A4%A7%E5%AD%A6%E7%94%9F%E5%85%BC%E8%81%8C&pagetype=topic&topic=1&Refer=weibo_topic"
                               target="_blank">社区兼职<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo/%2523%25E5%25B8%25A6%25E4%25BD%25A0%25E5%2585%25B1%25E4%25BA%25AB%25E8%258A%25B1%25E5%25BC%2580%25E7%2583%2582%25E6%25BC%25AB%25E6%2597%25B6%2523?topnav=1&wvr=6&Refer=top_hot"
                               target="_blank">带你共享花开烂漫时<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo?q=%E5%A4%A7%E5%AD%A6%E7%94%9F%E9%80%89%E6%8B%A9%E5%8D%87%E5%AD%A6%E8%BF%98%E6%98%AF%E5%B0%B1%E4%B8%9A"
                               target="_blank">社区升学还是就业<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo?q=%23%E5%AD%A6%E4%BC%9A%E6%8B%92%E7%BB%9D%E4%B8%8D%E5%B1%9E%E4%BA%8E%E8%87%AA%E5%B7%B1%E7%9A%84%E8%AF%84%E4%BB%B7%23"
                               target="_blank">学会拒绝不属于自己的评价<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo/%23%E5%88%9B%E4%B8%9A%E6%94%BF%E7%AD%96%23"
                               target="_blank">创业政策<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo/%23%E7%BD%91%E4%B8%8A%E5%BC%80%E5%BA%97%23"
                               target="_blank">网上开店<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo/%23%E5%88%9B%E4%B8%9A%E5%AD%B5%E5%8C%96%E5%9F%BA%E5%9C%B0%23"
                               target="_blank">创业孵化基地<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo/%23%E6%81%92%E5%A4%A7%E5%86%A0%E5%86%9B%23"
                               target="_blank">恒大冠军<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo?q=%23%E6%81%92%E5%A4%A7%E6%B1%BD%E8%BD%A6%23"
                               target="_blank">恒大汽车<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo?q=%23%E5%88%9B%E6%96%B0%E5%88%9B%E4%B8%9A%23"
                               target="_blank">创新创业<img
                                    src="images/index/weibo.jpg"/></a></li>
                        <li>
                            <a href="https://s.weibo.com/weibo/%23%E4%BB%99%E5%89%91%E5%A5%87%E4%BE%A0%E4%BC%A0%E4%BA%94%23"
                               target="_blank">仙剑奇侠传5<img
                                    src="images/index/weibo.jpg"/></a></li>
                    </ul>
                </div>
                <div id="hotTopic_bottom"></div>
            </div>
        </div>
    </div>
    <div id="banner_third" style="clear:both; height: 40px;width: 974px; ">
        <a href=""><img src="<%=path%>/images/banners/taobao.jpg"/></a>

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
        <div id="foot_main" style="padding: 0px;margin: 0px;">
            <ul>

                <li><a href="<%=path %>/help/help.jsp?menu=newMember&menuType=1">新手上路</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=law&menuType=3">法律声明</a></li>
                <li><a href="<%=path %>/help/help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
            </ul>

        </div>
        <div style="margin-left: 443px;
    clear: both;
    text-align: center;
    margin-top: 61px;
    color: #9b9b9b;
    font-size: 12px;">优复用
        </div>
        <div class="line0">
            <ul>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>
        <!--
           <div ><a style="margin-left: 400px;" href="http://www.cyberpolice.cn/infoCategoryListAction.do?act=init"><img src="<%=path %>/images/onlineSir.gif" style="border: none;width: 50px;vertical-align: middle;"/></a><a style="margin-left: 50px;" href="http://www.cyberpolice.cn/infoCategoryListAction.do?act=init"><img src="<%=path %>/images/onlineSir.jpg" style="border: none;width: 50px;vertical-align: middle;"/></a></div>
           -->
    </div>


</div>
<div class="line1"></div>
<div class="line3">
    <ul>
        <li></li>
        <li></li>
    </ul>
</div>
<div class="line4">
    <ul>
        <li></li>
        <li></li>
    </ul>
</div>
<%--<div class="line14">--%>
<%--    <ul>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--        <li></li>--%>
<%--    </ul>--%>
<%--</div>--%>
<div class="backg"></div>
</body>
</html>
