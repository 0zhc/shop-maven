<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <link href="<%=path%>/css/loginAndrex/top_foot.css" rel="stylesheet"/>
    <link href="<%=path%>/css/loginAndrex/login.css" rel="stylesheet"/>
    <link href="<%=path%>/css/comm/top.css" rel="stylesheet"/>
    <link href="<%=path%>/css/comm/backg_line.css" rel="stylesheet"/>
    <link href="<%=path%>/css/help/help_css.css" rel="stylesheet"/>
    <link href="<%=path%>/css/loginAndrex/login6.css" rel="stylesheet"/>
    <script src="<%=path%>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path%>/js/system/managerIndex.js"></script>

    <title>优复用登录</title>

    <style type="text/css">
        * {
            padding: 0px;
            margin: 0px;
        }

        #container {
            width: 974px;
            padding-left: 15px;
            padding-right: 15px;

            position: relative;
            left: 50%;
            margin-left: -487px;
            height: 1000px;
        }

        #helpMenu, #contentMain {
            float: left;
        }

        #helpMenu {
            width: 250px;

            height: 900px;
            padding-top: 4px;
        }

        #contentMain {
            width: 715px;
            height: 900px;

            float: right;
        }

        ul, li {
            list-style: none;
        }

        #helpMenuTop {
            width: 248px;
            height: 35px;
            background-image: url(imgs/menuTop.jpg);
            background-repeat: no-repeat;
        }

        #helpMenuContainerMiddle {
            width: 248px;
            height: 600px;
            background-image: url(imgs/menuMiddle.jpg);
            background-repeat: repeat-y;
        }

        #helpMenuBottom {
            width: 248px;
            height: 8px;
            background-image: url(imgs/menubuttom.jpg);
            background-repeat: no-repeat;
        }

        #helpMenuContainer li {

            background-image: url(imgs/menuline.jpg);
            background-position: bottom center;
            background-repeat: no-repeat;
        }

        #helpMenuContainer li a {
            height: 32px;
            line-height: 32px;
            margin-left: 13px;
            padding-left: 30px;
            font-size: 14px;
            color: #666666;
            text-decoration: none;
            background-image: url(imgs/tip.jpg);
            background-position: left center;
            background-repeat: no-repeat;
            display: block;
        }

        #helpMenuContainer li a:hover {
            color: #006dd2;
        }

        #contentMain_top {
            width: 714px;
            height: 41px;
            background-image: url(imgs/contentRightTop.jpg);
            background-repeat: no-repeat;
        }

        #contentMain_Middle {
            width: 714px;
            height: 800px;
            background-image: url(imgs/contentRightMiddle.jpg);
            background-repeat: repeat-y;
        }

        #contentMain_bottom {
            width: 714px;
            height: 15px;
            background-image: url(imgs/contentRightbottom.jpg);
            background-repeat: no-repeat;
        }

        .common {
            margin-left: 25px;
            display: none;
        }

        .myCurrent {
            padding-left: 40px;
        }
    </style>
    <script type="text/javascript">
        var path = '<%=path%>';
        $(function () {
                $("#helpMenuContainer>li").hover(function () {

                        $("#helpMenuContainer>li").css("background-image", "url(imgs/menuline.jpg)");
                        $(this).css("background-image", "url(imgs/menuHover.jpg)");
                    }, function () {
                        $(this).css("background-image", "url(imgs/menuline.jpg)");
                    }
                );


            }
            //  $("#helpMenuContainer>li>a").css("background-image", "url(imgs/bigTip.jpg)");
            //$("#helpMenuContainer>li>a").eq(0).css("background-image", "url(imgs/currentTip.jpg)");
        );
    </script>
    <script type="text/javascript">
        $(function () {
            $("#helpMenuContainer>li>a").css("background-image", "url(imgs/bigTip.jpg)");
            //$("#helpMenuContainer>li>a").eq(0).css("background-image", "url(imgs/currentTip.jpg)").css("font-size","14px").css("color","white").css("font-weight","600");
            $("#helpMenuContainer>li").click(function () {
                    $("#helpMenuContainer>li>ul").hide();
                    $(this).children("ul").show();
                }
            );

            $("#law,#linkUs,#newMember,#buyerKnow").click(function () {

                $(".common").hide();
                $(".common>li>a").css("background-image", "url(imgs/tip.jpg)").css("color", "#666666").css("font-size", "14px").css("font-weight", "500");
                $("#law,#linkUs,#newMember,#buyerKnow").css("background-image", "url(imgs/bigTip.jpg)").css("color", "#666666").css("font-size", "14px").css("font-weight", "500");
                $(this).css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");

            });

            $(".common>li>a").click(function () {

                $("#law,#linkUs,#newMember,#buyerKnow").css("background-image", "url(imgs/bigTip.jpg)").css("color", "#666666").css("font-size", "14px").css("font-weight", "500");
                $(".common>li>a").css("background-image", "url(imgs/tip.jpg)").css("color", "#666666").css("font-size", "14px").css("font-weight", "500");
                $(this).css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");

            });


        })


        //构造参数对象并初始化
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
            var getValue = new QueryString();

            var menu = getValue.menu;
            var menuType = getValue.menuType;
            // alert(menu);
            //  alert(menuType);

            switch (menu) {
                case 'mqy':
                    if (menuType == 'intro') {
                        $("#mqy").show();
                        $("#intro").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/mqy_intro.jsp");
                    }
                    if (menuType == 'injion') {
                        $("#mqy").show();
                        $("#injion").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/join_mqy.jsp");
                    }

                    if (menuType == 'operate') {
                        $("#mqy").show();
                        $("#operate").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/cooperation_area.jsp");
                    }
                    break;
                case 'freeOpen':
                    if (menuType == 'regis') {
                        $("#freeOpen").show();
                        $("#regis").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/reg_setUpShop1.jsp");
                    }
                    if (menuType == 'upload') {
                        $("#freeOpen").show();
                        $("#upload").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        // $("#mainContent").attr("src","shop/promptMiddle.jsp");
                    }

                    if (menuType == 'manager') {
                        $("#freeOpen").show();
                        $("#manager").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/shop_service.jsp");
                    }


                    break;

                case 'buyPoin':

                    if (menuType == 'flor') {
                        $("#buyPoin").show();
                        $("#flor").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/shopping_step.jsp");
                    }
                    if (menuType == 'map') {
                        $("#buyPoin").show();
                        $("#map").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/shopping_map.jsp");
                    }


                    break;


                case 'buyMethod':

                    if (menuType == 'pay') {
                        $("#buyMethod").show();
                        $("#pay").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/pay_method.jsp");
                    }
                    if (menuType == 'backPay') {
                        $("#buyMethod").show();
                        $("#backPay").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/pay_return.jsp");
                    }


                    break;

                case 'scope':
                    if (menuType == 'peixion') {
                        $("#scope").show();
                        $("#peixion").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/scop_door.jsp");
                    }
                    if (menuType == 'check') {
                        $("#scope").show();
                        $("#check").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/scop_valita_received.jsp");
                    }

                    if (menuType == 'scopeantime') {
                        $("#scope").show();
                        $("#scopeantime").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/scope_time.jsp");
                    }


                    break;


                case 'server':
                    if (menuType == 'policity') {
                        $("#server").show();
                        $("#policity").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/return_rule.jsp");
                    }
                    if (menuType == 'backFlor') {
                        $("#server").show();
                        $("#backFlor").css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                        $("#mainContent").attr("src", "content/return_flow.jsp");
                    }
                    break;
                case 'newMember':
                    $("#newMember").eq(0).css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                    break;
                case 'buyerKnow':
                    $("#buyerKnow").eq(0).css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                    break;
                case 'law':
                    $("#law").eq(0).css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                    break;
                case 'linkUs':
                    $("#linkUs").eq(0).css("background-image", "url(imgs/currentTip.jpg)").css("font-size", "14px").css("color", "white").css("font-weight", "600");
                    break;


            }


        })
    </script>

</head>


<body>
<div class="backg2"></div>
<div id="contain">
    <div id="top">
        <ul id="top_left" style="padding: 0px;margin: 0px;width:530px;">
            <li style="padding-left: 8px;">${user.userName }你好，欢迎来到优复用！</li>
            <li class="top_login"><a href="<%=path%>/index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right" style="padding: 0px;">
            <li><a href="<%=path%>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath()%>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path%>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
            <li id="trade_record" style="padding-right:5px;"><a href="#"
                                                                style="background-image:url(../images/index/tip.jpg); background-repeat:no-repeat; background-position:104% 41%; padding-right:15px;">我的交易记录</a>
                <ul class="trade_main">
                    <li style="background-position:right center;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=bought">已买</a></li>
                    <li style="background-position:right center;padding-right:0px;"><a
                            href="<%=request.getContextPath()%>/system/manager_index.jsp?type=sold">已卖</a></li>
                </ul>
            </li>

            <li id="collect_file"><a href="#"
                                     style="background-image:url(../images/index/tip.jpg);background-repeat:no-repeat; background-position:57% 40%;  padding-right:0px; margin-left:8px; ">收藏夹</a>
                <ul class="store_main">
                    <li style="background-position:right center; "><a
                            href="<%=path%>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="<%=path%>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>
            <c:if test="${! empty user}">
                <li style="position: relative; left:-28px"><a href="<%=path%>/user/loginOut.do">注销</a></li>
            </c:if>
        </ul>

    </div>

    <div id="logo">
        <img src="<%=path%>/images/logo.jpg"/><img src="<%=path%>/help/imgs/help.jpg"/>
    </div>
    <div id="banner"><img src="<%=path%>/help/imgs/helpYou.jpg"/></div>
    <div id="content">
        <div id="helpMenu">
            <div id="helpMenuTop" style=" line-height:35px;"><span
                    style="color:#333333; font-size:14px; font-weight:600; margin-left:15px;">新手帮助分类</span></div>
            <div id="helpMenuContainerMiddle">
                <ul id="helpMenuContainer">
                    <li><a href="content/fresher.jsp" target="mainContent" class="bigTip" id="newMember">新手上路</a></li>
                    <li><a href="content/buyer_must_know.jsp" target="mainContent" class="bigTip"
                           id="buyerKnow">买家须知</a></li>
                    <li><a href="#" class="bigTip" onClick="return false">关于优复用 </a>
                        <ul class="common" style="display: none;" id="mqy">
                            <li><a href="content/mqy_intro.jsp" target="mainContent" class="bigTip"
                                   id="intro">优复用简介 </a></li>
                            <li><a href="content/join_mqy.jsp" target="mainContent" class="bigTip"
                                   id="injion">加入优复用 </a></li>
                            <li><a href="content/cooperation_area.jsp" target="mainContent" class="bigTip" id="operate">合作专区 </a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#" class="bigTip" onClick="return false">免费开店 </a>
                        <ul class="common" id="freeOpen">
                            <li><a href="content/reg_setUpShop1.jsp" target="mainContent" class="bigTip"
                                   id="regis">注册开店 </a></li>
                            <li><a href="content/reg_setUpShop2.jsp" target="mainContent" class="bigTip" id="upload">上传产品 </a>
                            </li>
                            <li><a href="content/shop_service.jsp" target="mainContent" class="bigTip"
                                   id="manager">店铺维护</a></li>
                        </ul>
                    </li>
                    <li><a href="#" class="bigTip" onClick="return false">购物指南 </a>
                        <ul class="common" id="buyPoin">
                            <li><a href="content/shopping_map.jsp" target="mainContent" class="bigTip"
                                   id="map">网站地图 </a></li>
                            <li><a href="content/shopping_step.jsp" target="mainContent" class="bigTip"
                                   id="flor">购物流程 </a></li>

                        </ul>
                    </li>
                    <li><a href="#" class="bigTip" onClick="return false">支付方式 </a>
                        <ul class="common" id="buyMethod">
                            <li><a href="content/pay_method.jsp" target="mainContent" class="bigTip" id="pay">如何支付 </a>
                            </li>
                            <li><a href="content/pay_return.jsp" target="mainContent" class="bigTip"
                                   id="backPay">如何办理退款 </a></li>

                        </ul>
                    </li>
                    <li><a href="#" class="bigTip" onClick="return false">配送方式 </a>
                        <ul class="common" id="scope">
                            <li><a href="content/scop_door.jsp" target="mainContent" class="bigTip"
                                   id="peixion">发货方式</a></li>

                            <li><a href="content/scop_valita_received.jsp" target="mainContent" class="bigTip"
                                   id="check">验货签收 </a></li>
                            <li><a href="content/scope_time.jsp" target="mainContent" class="bigTip" id="scopeantime">配送范围及配送时间 </a>
                            </li>

                        </ul>
                    </li>
                    <li><a href="#" class="bigTip" onClick="return false">售后服务 </a>
                        <ul class="common" id="server">

                            <li><a href="content/return_rule.jsp" target="mainContent" class="bigTip" id="policity">退换货政策 </a>
                            </li>
                            <li><a href="content/return_flow.jsp" target="mainContent" class="bigTip"
                                   id="backFlor">退货流程</a></li>

                        </ul>
                    </li>


                    <li><a href="content/fresher.jsp" target="mainContent" class="bigTip" class="bigTip"
                           id="law">法律声明 </a></li>
                    <li><a href="content/lianxi.jsp" target="mainContent" class="bigTip" class="bigTip"
                           id="linkUs">联系我们 </a></li>
                </ul>
            </div>
            <div id="helpMenuBottom"></div>
        </div>
        <div id="contentMain">
            <div id="contentMain_top"></div>
            <div id="contentMain_Middle" style="padding-left:6px;">
                <iframe width="920" height="800" src="content/fresher.jsp" frameborder="0" scrolling="no"
                        name="mainContent" id="mainContent"></iframe>

            </div>
            <div id="contentMain_bottom"></div>
        </div>
    </div>

    <div id="footer" style="clear:both;">
        <div id="foot_main">
            <ul>
                <li><a href="help.jsp?menu=newMember&menuType=1">新手上路</a></li>
                <li><a href="help.jsp?menu=buyerKnow&menuType=2">买家须知</a></li>
                <li><a href="help.jsp?menu=law&menuType=3">法律声明</a></li>
                <li><a href="help.jsp?menu=linkUs&menuType=4">联系我们</a></li>
            </ul>
        </div>
        <div style="clear:both; text-align:center; margin-top:40px; margin-left:552px; color:#9b9b9b; font-size:12px;">
            &nbsp;优复用&nbsp;
        </div>
    </div>

</div>
<div class="line2">
    <ul>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
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

<div class="backg3"></div>
</body>
</html>
