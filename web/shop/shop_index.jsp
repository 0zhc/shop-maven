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
    <title>优复用个人店铺首页</title>

    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path %>/shop/showTip/thickbox.js"></script>
    <link href="<%=path %>/shop/showTip/thickbox.css" type="text/css" rel="stylesheet"/>

    <script src="<%=path %>/js/system/managerIndex.js"></script>
    <script type="text/javascript">
        //loading提示路径
        var tb_pathToImage = "<%=path %>/shop/showTip/images/loadingAnimation.gif";
        var path = '<%=path %>';
        var template = '${shop.template}';
    </script>
    <c:choose>
        <c:when test="${shop.template==1}">
            <script language="JavaScript" type="text/javascript"
                    src="<%=path %>/shop/shop_js/shop_blue_index.js"></script>
            <link href="<%=path %>/shop/shop_css/shop_index.css" rel="stylesheet"/>
            <!--这个是蓝色色的css-->
        </c:when>
        <c:otherwise>
            <script language="JavaScript" type="text/javascript"
                    src="<%=path %>/shop/shop_js/shop_red_index.js"></script>
            <link href="<%=path %>/shop/shop_css/red/shop_red_index.css" rel="stylesheet"/>
            <!--这个是红色的css-->
        </c:otherwise>
    </c:choose>

    <style type="text/css">
        .modifytip {
            float: right;
            color: #0000FF;
            font-weight: bolder;
            font-size: 14px;
            display: none;
            background-color: #FFFFFF;
        }

        .mymodify {
            border: #FF0000 solid 1px;
        }

        #showRolling, #showHot, #showNew, #showSecond, showOhter {
            display: none;
        }
    </style>
    <script type="text/javascript">
        $(function () {

            var isModify = '${isModify}';
            // alert(isModify);
            var loginId = '${user.id}';
            var userNewId = '${userNew.id}'

            if (loginId == userNewId) {
                if (isModify == 1) {//1为装修  2 为查看
                    $("#business_information,#new,#friendly_link,#banner,#book_shop").hover(function () {
                        $(this).css("border", "red solid 1px");
                        $(this).children("a").show();

                    }, function () {
                        $(this).css("border", "none");
                        $(this).children(".modifytip").hide();
                    }).css("cursor", "pointer");

                }
            }


        });
    </script>

    <link href="<%=path%>/css/comm/backg_line.css" rel="stylesheet"/>
    <link href="<%=path %>/css/shop/shop_index_css.css" type="text/css" rel="stylesheet"/>
    <script>
        $(function () {
            $("#showTip").mouseover(function () {
                $("#show").draggable({containment: "parent"});
            }).css("cursor", "move");


        });

        function RollingSet() {
            $("#rollingGoods").click();
        }

        function ShowHotGoodsSet() {
            $("#showHotGoods").click();
        }

        function ShowNewGoodsSet() {
            $("#showNewGoods").click();
        }

        function ShowSecondSet() {
            $("#showSecondGoods").click();
        }

        function ShowOtherSet() {
            $("#showOtherGoods").click();
        }

        function ShowOrder(urlPath) {
            //alert(urlPath);
            $("#showOrder").attr("href", urlPath);
            $("#showOrder").click();
        }

        function ShowEvaluation() {
            var urlPath = '<%=path %>/cjmqylogin/login_min.jsp?keepThis=true&TB_iframe=true&height=500&width=1000';
            $("#showOrder").attr("href", urlPath);
            $("#showOrder").click();
        }

        function ShowCart(urlPath) {
            //alert(urlPath);
            $("#showCart").attr("href", urlPath);
            $("#showCart").click();
        }

        function ShowScope(urlPath) {


            $("#showScope").attr("href", urlPath);
            $("#showScope").click();
        }

        function ShowBuIntro(urlPath) {


            $("#showBuIntro").attr("href", urlPath);
            $("#showBuIntro").click();

        }

        function ShowSecurity(urlPath) {


            $("#showSecurity").attr("href", urlPath);
            $("#showSecurity").click();

        }

        function ShowCantact(urlPath) {


            $("#ShowCantact").attr("href", urlPath);
            $("#ShowCantact").click();

        }


    </script>

    <script>

        //wuyixin

        //在店铺页搜索符合条件的商品
        function selectPro() {

            var proKeyWord = document.getElementById("proKeyWordId").value;
            var oneProPrice = document.getElementById("oneProPriceId").value;
            var twoProPrice = document.getElementById("twoProPriceId").value;
            proKeyWord = encodeURI(encodeURI(proKeyWord));//编码，防止中文乱码
            window.open("<%=request.getContextPath()%>/shop/search_pro.jsp?userId=${userNew.id}&proKeyWord=" + proKeyWord + "&oneProPrice=" + oneProPrice + "&twoProPrice=" + twoProPrice, "mainRight");
        }

        //用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
        function userToCollShop(shopId) {

            if ('${user.id}' == '') {
                alert('请先登录');
            } else {

                if (confirm("是否要收藏店铺？")) {

                    $.ajax({
                        type: "post",
                        url: "<%=request.getContextPath()%>/userCollectionShop.do?" + escape(new Date()),
                        data: {'shopId': shopId},
                        dataType: "html",
                        success: function (data, textStatus) {
                            if (data == "collectSuccess") {
                                alert("成功收藏店铺");

                            } else if (data == 'hasCollection') {

                                alert("您已收藏了此店铺");

                            } else if (data == 'donotLogin') {
                                alert("请先登录");
                            }
                        }

                    });
                }
            }
        }


        //通过左边的商品分类搜索最热，最新，二手商品
        function findProcategory(goodsType) {
            window.open("<%=request.getContextPath()%>/shop/search_hot_new_old.jsp?userId=${userNew.id}&goodsType=" + goodsType, "mainRight");

        }

        //通过左边的商品分类搜索其他商品
        function findOtherPro(goodsType, otherText) {

            otherText = encodeURI(encodeURI(otherText));//编码，防止中文乱码
            window.open("<%=request.getContextPath()%>/shop/search_other.jsp?userId=${userNew.id}&goodsType=" + goodsType + "&otherText=" + otherText, "mainRight");


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
            width: 750px;
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
            left: 725px;
        }

        #close img {
            border: none;
        }

        .line7 {
            position: absolute;
            width: 500px;
            z-index: 1;
            top: 25px;
            left: 496px;
        }

        .line7 ul li {
            float: left;
            margin-right: 99px;
            width: 1px;
            height: 14px;
            border-left: 1px solid #d7d7d7;
        }

        #trade_record ul, #collect_file ul {
            top: 30px;
        }
    </style>
    <script>
        function QueryString() {
            var name, value, i;
            var str = location.href;//获得浏览器地址栏URL串
            var num = str.indexOf("?")
            str = str.substr(num + 1);//截取“?”后面的参数串
            var arrtmp = str.split("&");//将各参数分离形成参数数组
            for (i = 0; i < arrtmp.length; i++) {
                num = arrtmp[i].indexOf("=");
                if (num > 0) {
                    name = arrtmp[i].substring(0, num);//取得参数名称
                    value = arrtmp[i].substr(num + 1);//取得参数值
                    this[name] = value;//定义对象属性并初始化
                }
            }
        }

        $(function () {
            $("#showTip").mouseover(function () {
                $("#show").draggable({containment: "parent"});
            }).css("cursor", "move");

            var getValue = new QueryString();

            var type = getValue.type;


            switch (type) {

                case 'datail':

                    if (template == 1) {//蓝色
                        $("#links_top ul li a").css("background-image", "url(<%=path%>/shop/shop_image/red/links_a.gif)");
                        $("#links_top ul li a ").eq(0).css("background-image", "url(<%=path%>/shop/shop_image/links_a_home.gif)").css("color", "#2D2D2D");
                        $("#links_top ul li a").eq(5).css("background-image", "url(<%=path%>/shop/shop_image/links_hover.gif)").css("color", "white");
                    } else {//红色
                        $("#links_top ul li a").css("background-image", "url(<%=path%>/shop/shop_image/red/links_a.gif)");
                        $("#links_top ul li a ").eq(0).css("background-image", "url(<%=path%>/shop/shop_image/red/links_a_home.gif)").css("color", "#2D2D2D");
                        $("#links_top ul li a").eq(5).css("background-image", "url(<%=path%>/shop/shop_image/red/links_hover.gif)").css("color", "white");
                    }


                    $("#mainRight").attr("src", "<%=path%>/shop/proDetailMiddle.jsp?goodsId=${goodsId}&template=" + template);
                    break;


                default:

                    $("#mainRight").attr("src", "<%=path%>/shop/proListpromptMiddle.jsp?userId=${userNew.id}&shopId=${shop.id}&template=" + template);

                    ;
            }

        });
    </script>

    <script>

        //用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
        function userToCollShop(shopId) {

            if ('${user.id}' == '') {
                alert('请先登录');
            } else {

                if (confirm("是否要收藏店铺？")) {

                    $.ajax({
                        type: "post",
                        url: "<%=request.getContextPath()%>/userCollectionShop.do?" + escape(new Date()),
                        data: {'shopId': shopId},
                        dataType: "html",
                        success: function (data, textStatus) {
                            if (data == "collectSuccess") {
                                alert("成功收藏店铺");

                            } else if (data == 'hasCollection') {

                                alert("您已收藏了此店铺");

                            } else if (data == 'donotLogin') {
                                alert("请先登录");
                            }
                        }

                    });
                }
            }
        }
    </script>

    <script type="text/javascript" language="javascript">
        //wuyixin
        //iframe自适应高度
        function iFrameHeight() {
            var ifm = document.getElementById("mainRight");
            var subWeb = document.frames ? document.frames["mainRight"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }

    </script>

</head>
<body>
<div class="backg2"></div>
<div id="container">
    <div id="top">
        <ul id="top_left" style="width: 450px;">

            <c:choose>
                <c:when test="${user.id==userNew.id && (! empty user)}">
                    <li style="padding-left: 3px; width: 250px;"><span
                            style="font-size: 12px; font-weight: 500;padding-right: 5px;">${user.userName}</span>主人您好,很开心您能来看我！
                    </li>
                </c:when>
                <c:otherwise>
                    <li style="padding-left: 10px; width: 250px;"><span
                            style="font-size: 12px; font-weight: 500;padding-right: 5px;"></span>您好,很开心您关顾本店！
                    </li>
                </c:otherwise>
            </c:choose>


            <li class="top_login"><a href="<%=path %>/index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right">
            <li><a href="<%=request.getContextPath() %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath() %>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
            <li id="trade_record" style="padding-right:5px;"><a href="#"
                                                                style="background-image:url(<%=path %>/images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
                <ul class="trade_main">
                    <li style="background-position:right center;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=bought">已买</a></li>
                    <li style="background-position:right center;padding-right:0px;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=sold">已卖</a></li>
                </ul>
            </li>

            <li id="collect_file"><a href="#"
                                     style="background-image:url(<%=path %>/images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:0px; ">收藏夹</a>
                <ul class="store_main">
                    <li style="background-position:right center; "><a
                            href="<%=path %>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image: margin-right:10px;"><a
                            href="<%=path %>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>


            <c:if test="${user.id==userNew.id && (! empty user)}">
                <li id="modifyShop"><a href="#"
                                       style="background-image:url(<%=path %>/images/index/tip.jpg);background-repeat:no-repeat; background-position:100% 40%;  padding-right:20px;display:block; ">装修店铺</a>
                    <ul class="modifyShop" style="display:none; position:absolute; z-index:90; top: 26px;">
                        <li style="background-position:right center; "><a
                                href="<%=path %>/system/shop/prompt.do?Jsptype=seeUserShop">查看店铺</a></li>
                        <li style=" padding:0px; margin:0px; background-image:none;"><a
                                href="<%=path %>/system/shop/prompt.do?Jsptype=userShop">修改店铺</a></li>
                    </ul>
                </li>

            </c:if>

            <c:if test="${! empty user}">
                <li class="des"><a href="<%=path %>/user/loginOut.do">注销</a></li>
            </c:if>

        </ul>

    </div>

    <div id="banner" class="banner_right"
         style="clear:both;background-image: url('/images/Shoper/cjmqy001/1399105933280.jpg') no-repeat;  background-color: #999;">

        <a href="<%=path %>/shop/shopModify/logo_banner/promptMiddle.jsp?keepThis=true&TB_iframe=true&height=400&width=1100"
           title="店铺装修>>店铺店标&#8226;招牌设置" class="thickbox modifytip"
           style="position: absolute; top: 68px; left: 1169px; z-index: 999;">修改</a>

        <%--        <div id="shop_logo"--%>
        <%--             style="background-image: url('<%=path %>/${shop.logoUrl}');background-color: #ccc;">--%>
        <%--            <c:if test="${empty shop.logoUrl}">--%>
        <%--            <div>logo: <span>宽为  132px</span><br/><span style="margin-left: 33px;">高为 88px</span></div>--%>
        <%--        </c:if><c:if test="${!empty shop.logoUrl}">--%>
        <%--        <img src="<%=path %>/${shop.logoUrl}" width="132px"--%>
        <%--                                                        height="88px"/>--%>
        <%--    </c:if></div>--%>
        <div id="banner_right" style="background-size: 100% 100%; background-color: #999;">
            <c:if test="${empty shop.bannerUrl}"><span style="position: absolute;"><br/><span
                    style="margin-left: 45px;"></span></span></c:if>
            <div id="links_top">
                <ul>
                    <li id="homepage"><a
                            href="<%=request.getContextPath()%>/shop/proListpromptMiddle.jsp?userId=${userNew.id}&shopId=${shop.id}&template=${shop.template}"
                            target="mainRight">首页</a></li>
                    <li class="otherpage"><a
                            href="<%=request.getContextPath()%>/linkFindBussIntroByUserId.do?userId=${userNew.id}&isModify=${isModify }&template=${shop.template}"
                            target="mainRight"><span>商家介绍</span></a></li>
                    <li class="otherpage"><a
                            href="<%=request.getContextPath()%>/linkFindScopeByUserId.do?userId=${userNew.id}&isModify=${isModify }&template=${shop.template}"
                            target="mainRight"><span>配送范围</span></a></li>
                    <li class="otherpage"><a
                            href="<%=request.getContextPath()%>/linkFindSecureByUserId.do?userId=${userNew.id}&isModify=${isModify }&template=${shop.template}"
                            target="mainRight"><span>购物保障</span></a></li>
                    <li class="otherpage"><a
                            href="<%=request.getContextPath()%>/linkFindContactUsByUserId.do?userId=${userNew.id}&isModify=${isModify }&template=${shop.template}"
                            target="mainRight"><span>联系我们</span></a></li>
                    <li class="otherpage"><a href="#" target="mainRight" onClick="return false"><span>商品详情</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div id="links">
    </div>

    <div id="main">
        <div id="main_left">
            <div id="business_information">
                <a href="<%=path %>/shop/shopModify/shopmodify_left/modify_businfoMidd.jsp?userId=${userNew.id}&keepThis=true&TB_iframe=true&height=300&width=630"
                   title="店铺装修对话框" class="thickbox modifytip" id="modifyLink">修改</a>
                <span id="shopkeeper"> 店主昵称：${userNew.callName}</span>
                <span id="tel">${userNew.telephone}</span>
                <span id="short_tel">短号：${userNew.shortNumber}</span>
                <span id="qq">
                    <a href=' http://wpa.qq.com/msgrd?V=1&amp;Uin=${userNew.qq}&amp' ;target='_blank'>QQ<span
                            style="color: #FFFFFF;">空</span>直接联系我</a>
                    <!--  <a href=' http://wpa.qq.com/msgrd?V=1&amp;Uin=${userRequest.qq}&amp';target='_blank'><img src=' http://wpa.qq.com/pa?p=1:${userRequest.qq}:4'  border='0' alt='QQ' />直接联系我</a>--> </span>
            </div>

            <div id="book_shop">
                <a href="<%=path %>/shop/shopModify/shopmodify_left/modify_shopNameMidd.jsp?userId=${userNew.id}&keepThis=true&TB_iframe=true&height=200&width=600"
                   title="店铺装修对话框" class="thickbox modifytip" id="modifyLink">修改</a>
                <span>店名：${shop.name}</span>
                <a id="collect_shop" title="点击收藏店铺" href="javascript:userToCollShop('${shop.id }');"></a>
            </div>

            <div id="shop_search">
                <div id="shop_search_title">
                    搜索店内宝贝
                </div>
                <div id="shop_search_main">
                    <div id="search_main_top">关键字：<input id="proKeyWordId" type="text"/></div>
                    <div id="search_main_middle">价<span style="color: #FFFFFF;">空</span>格：<input id="oneProPriceId"
                                                                                                 type="text"/><span
                            style="color: #FFFFFF;">k</span>从<span style="color: #FFFFFF;">k</span><input
                            id="twoProPriceId" type="text"/></div>
                    <div id="search_main_bottom"><a href="javascript:selectPro();"></a></div>
                </div>
            </div>

            <div id="new">
                <a href="<%=path %>/shop/shopModify/shopmodify_left/modify_newMidd.jsp?userId=${userNew.id}&keepThis=true&TB_iframe=true&height=330&width=800"
                   title="店铺装修对话框" class="thickbox modifytip" id="modifyLink">修改</a>
                <span>店铺公告</span>
                <div id="new_main">

                    <ul>
                        <c:forEach var="shopAnnouce" items="${shop.shopAnnouces}">
                            <li><a href="#" class="tooltip">${shopAnnouce.content}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div id="product_category">
                <div id="procategory_title">产品分类</div>
                <c:if test="${shop.isShowHot==1}">
                    <div id="procategory_hot"><a href="javascript:findProcategory('1');">最热商品</a></div>
                </c:if>
                <c:if test="${shop.isShowNew==1}">
                    <div id="procategory_new"><a href="javascript:findProcategory('2');">最新商品</a></div>
                </c:if>
                <c:if test="${shop.isShowSecond==1}">
                    <div id="procategory_old"><a href="javascript:findProcategory('3');">二手商品</a></div>
                </c:if>
                <div id="procategory_other"><a
                        href="javascript:findOtherPro('4','${shop.otherText}');">${shop.otherText}</a></div>
            </div>

            <div id="friendly_link">
                <a href="<%=path %>/shop/shopModify/shopmodify_left/modify_fridenlinkMidd.jsp?userId=${userNew.id}&keepThis=true&TB_iframe=true&height=350&width=750"
                   title="店铺装修对话框" class="thickbox modifytip" id="modifyLink">修改</a>
                <ul id="flink_title">
                    <li>友情链接</li>
                </ul>
                <ul id="flink_mian">


                    <c:forEach var="friendLink" items="${userNew.friendlinks}">
                        <li><a href="${friendLink.url}" target="_blank">${friendLink.urlText}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <div id="main_right">

            <div id="pro_right">
                <iframe width="942" frameborder="0" scrolling="no" name="mainRight" id="mainRight" src=""
                        onLoad="iFrameHeight()"></iframe>
            </div>
        </div>
        <div id="footer" style="position: relative">
            <div id="foot_main">
                <ul>
                    <li><a href="<%=path %>/help/help.jsp?menu=newMember&menuType=1">新手上路</a></li>
                    <li><a href="<%=path %>/help/help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
                    <li><a href="<%=path %>/help/help.jsp?menu=law&menuType=3">法律声明</a></li>
                    <li><a href="<%=path %>/help/help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
                </ul>
            </div>
            <div style="clear:both; text-align:center; margin-top:40px; color:#9b9b9b; font-size:12px;">优复用</div>
            <div class="line7">
                <ul>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div id="showRolling">
    <a href="<%=path %>/shop/shopModify/productModify/proBannerListpromptMiddle.jsp?keepThis=true&TB_iframe=true&height=500&width=1000"
       title="店铺装修对话框" class="thickbox" id="rollingGoods"></a>


</div>
<div id="showHot">
    <a href="<%=path %>/shop/shopModify/productModify/proHotpromptMiddle.jsp?keepThis=true&TB_iframe=true&height=500&width=1000"
       title="店铺装修对话框" class="thickbox" id="showHotGoods"></a>

</div>
<div id="showNew">
    <a href="<%=path %>/shop/shopModify/productModify/proNewpromptMiddle.jsp?keepThis=true&TB_iframe=true&height=500&width=1000"
       title="店铺装修对话框" class="thickbox" id="showNewGoods"></a>

</div>
<div id="showSecond">
    <a href="<%=path %>/shop/shopModify/productModify/proSecondpromptMiddle.jsp?keepThis=true&TB_iframe=true&height=500&width=1000"
       title="店铺装修对话框" class="thickbox" id="showSecondGoods"></a>

</div>
<div id="showOhter">
    <a href="<%=path %>/shop/shopModify/otherProduct/proOhterpromptMiddle.jsp?keepThis=true&TB_iframe=true&height=500&width=1000"
       title="店铺装修对话框" class="thickbox" id="showOtherGoods"></a>

</div>
<div id="showOrder1">
    <a href="" title="店铺装修对话框" class="thickbox" id="showOrder"></a>

</div>
<div id="showCart1">
    <a href="" title="店铺装修对话框" class="thickbox" id="showCart"></a>

</div>
<div id="showScopeDiv">
    <a href="" title="店铺装修对话框" class="thickbox" id="showScope"></a>

</div>
<div id="showBussiIntroDiv">
    <a href="" title="店铺装修对话框" class="thickbox" id="showBuIntro"></a>

</div>

<div id="showSecurityDiv">
    <a href="" title="店铺装修对话框" class="thickbox" id="showSecurity"></a>

</div>
<div id="ShowCantactDiv">
    <a href="" title="店铺装修对话框" class="thickbox" id="ShowCantact"></a>

</div>

</body>
</html>
