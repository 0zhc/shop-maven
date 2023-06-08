<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="utf-8" %>
<%@ page import="com.shop.entity.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>优复用后台管理</title>

    <link href="<%=path%>/css/sysytem/managerIndex.css" type="text/css" rel="stylesheet"/>
    <script src="<%=path%>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path%>/js/system/managerIndex.js"></script>
    <link href="<%=path%>/css/search/search.css" type="text/css" rel="stylesheet"/><!--引人搜索样式-->
    <link href="<%=path%>/css/comm/top.css" rel="stylesheet"/>
    <link href="<%=path%>/css/comm/backg_line.css" rel="stylesheet"/>
    <link href="<%=path%>/css/sysytem/manager_css.css" type="text/css" rel="stylesheet"/>

    <script src="<%=path%>/js/searchPack/jquery.bgiframe.js"></script><!-- 搜索导入包 -->
    <script src="<%=path%>/js/searchPack/search.js"></script><!-- 搜索导脚本-->
    <script language="JavaScript" type="text/javascript">
        var path = '<%=path%>';

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

            var type = getValue.type;


            switch (type) {
                case 'freeopenshop':
                    $(".comman ul li a").css("background-image", "none");
                    $("#freeOpen").css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "shop/promptMiddle.jsp");

                    break;
                case 'bought':
                    $(".comman ul li a").css("background-image", "none");
                    $("#bought").css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "../system/tradeRecord/tradPro.jsp");
                    break
                case 'sold':
                    $(".comman ul li a").css("background-image", "none");
                    $("#sold").css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "<%=path%>/system/tradeRecord/solePro.jsp");
                    break;

                case 'soreShop':
                    $(".comman ul li a").css("background-image", "none");
                    $("#soreShop").css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "<%=request.getContextPath()%>/collectionShopFindByUserId.do?userId=${user.id}&currentpage=1");
                    break;

                case 'soregoods':
                    $(".comman ul li a").css("background-image", "none");
                    $("#soregoods").css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "<%=request.getContextPath()%>/collectionProductFindByUserId.do?userId=${user.id}&currentpage=1");
                    break;

                case 'upgoods':
                    $(".comman ul li a").css("background-image", "none");
                    $(".comman ul li a").eq(2).css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "shop/UploadProduct.html");
                    break;

                case 'shopSet':
                    $(".comman ul li a").css("background-image", "none");
                    $(".comman ul li a").eq(1).css("background-image", "url(<%=path%>/images/sysytem/menu_son_tip.jpg)");
                    $("#mainContent").attr("src", "shop/shopSet.html");
                    break;

                default:
                    ;
            }

        })

        //liuming


        var xmlHttp;

        function getXmlHttpRequest() {
            if (window.XMLHttpRequest)
                return new XMLHttpRequest();
            else if (window.ActiveXObject) {
                var activexName = ["MSXML2.XMLHTTP", "Microsoft.XMLHTTP"];
                for (var i = 0; i < activexName.length; i++) {
                    try {
                        return new ActiveXObject(activexName[i]);
                        break;
                    } catch (e) {
                        return null;
                    }
                }
            }
        }

        function load() {

            xmlHttp = getXmlHttpRequest();
            var url = "<%=request.getContextPath() %>/count.do";
            xmlHttp.onreadystatechange = getResult;
            xmlHttp.open("GET", url, true);
            xmlHttp.send(null);
        }

        function getResult() {

            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    var text = xmlHttp.responseXML;
                    var complaint = text.getElementsByTagName("complaint")[0].firstChild.nodeValue;
                    var complaintAlert = text.getElementsByTagName("complaintAlert")[0].firstChild.nodeValue;
                    var stationAnnouce = text.getElementsByTagName("stationAnnouce")[0].firstChild.nodeValue;
                    var cusOrder = text.getElementsByTagName("cusOrder")[0].firstChild.nodeValue;
                    var ownOrder = text.getElementsByTagName("ownOrder")[0].firstChild.nodeValue;
                    var menber = text.getElementsByTagName("menber")[0].firstChild.nodeValue;
                    document.getElementById("complaint").innerHTML = '(' + complaint + ')';
                    document.getElementById("complaintAlert").innerHTML = '(' + complaintAlert + ')';
                    document.getElementById("stationAnnouce").innerHTML = '(' + stationAnnouce + ')';
                    document.getElementById("cusOrder").innerHTML = '(' + cusOrder + ')';
                    document.getElementById("ownOrder").innerHTML = '(' + ownOrder + ')';
                    document.getElementById("menber").innerHTML = '(' + menber + ')';
                    setTimeout("load()", 1000);
                } else {
                    window.open("<%=path%>/cjmqylogin/login.jsp");
                }
            }
        }

    </script>
    <script type="text/javascript">
        function searchGoods() {
            document.getElementById("searchForm").submit();

        }

        function logout() {

            alert(basePath)
            location.replace(this.href);//清掉缓存问题
            window.open('<%=basePath%>/user/loginOut.do');

        }
    </script>
    <style type="text/css">
        #isNew {
            text-align: right;
        }

        .comman ul li a {
            background-repeat: no-repeat;
            background-position: left center;
        }
    </style>

</head>

<body onload="load()">
<div class="backg2"></div>
<div id="container">
    <div id="top">
        <ul id="top_left" style="width: 450px;">
            <li style="padding-left: 5px;">你好${user.callName }，欢迎来到优复用！</li>
            <li class="top_login"><a href="../index.jsp">返回首页</a></li>

        </ul>
        <ul id="top_right">
            <li><a href="<%=request.getContextPath() %>/system/manager_index.jsp?type=freeopenshop">免费开店</a></li>
            <li><a href="<%=request.getContextPath() %>/cart/findAllGoodsInCart.do" id="shop_car">购物车</a></li>
            <li><a href="<%=path %>/system/manager_index.jsp?type=freeopenshop">我要卖</a></li>
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
                            href="<%=path %>/system/manager_index.jsp?type=soreShop">店铺</a></li>
                    <li style=" padding:0px; margin:0px; background-image:none; margin-right:10px;"><a
                            href="<%=path %>/system/manager_index.jsp?type=soregoods">宝贝</a></li>
                </ul>
            </li>
            <c:if test="${! empty user}">
                <%--                <li style="position: relative; left:-28px"><a href="javascript:void(0)" onclick="logout()" target="_top">注销</a></li>--%>
                <li style="position: relative; left:-28px"><a href="<%=request.getContextPath()%>/loginOut.do">注销</a>
                </li>
            </c:if>

        </ul>

    </div>
    <div id="banner" style="clear:both; height: 40px;width: 974px; "><a href=""><img
            src="<%=path%>/images/banners/taobao.jpg" style="border: none;"/></a></div>
    <div id="search" style="height: 90px; margin-top: 54px;">
        <div id="logo"><img src="../images/logo.jpg"/></div>
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
    <div id="main" style="height: 800px;">
        <div id="menu" style=" width: 190px;height: 800px;">
            <div id="menu_top" style="line-height: 33px;"><span
                    style="margin-left: 40px;color: #ffffff;font-size: 14px;font-weight: 800;">后台管理</span></div>
            <div id="menu_middle">
                <ul>

                    <li class="comman">
                        <a href="../charts-project/index.jsp" target="_blank" class="menu_tip">数据可视化</a>

                    </li>
                    <li class="comman">
                        <a href="#" class="menu_tip">店铺管理</a>
                        <ul>
                            <li>
                                <a id="freeOpen" href="<%=path%>/system/shop/promptMiddle.jsp?"
                                   style="background-image: url(../images/sysytem/menu_son_tip.jpg); background-repeat: no-repeat;"
                                   target="mainContent">我的店铺</a>
                            </li>
                            <li>
                                <a href="<%=path%>/system/shop/prompt.do?Jsptype=isShow"
                                   target="mainContent">设置店铺显示模块</a>
                            </li>


                        </ul>

                    </li>


                    <li class="comman">
                        <a href="#" class="menu_tip">交易记录</a>
                        <ul>
                            <li><a id="bought" href="<%=request.getContextPath()%>/system/tradeRecord/tradPro.jsp"
                                   target="mainContent">已买</a></li>
                            <li><a id="sold" href="<%=request.getContextPath()%>/system/tradeRecord/solePro.jsp"
                                   target="mainContent">已卖</a></li>
                        </ul>
                    </li>


                    <li class="comman">
                        <a href="#" class="menu_tip">收藏管理</a>
                        <ul>
                            <li><a id="soreShop"
                                   href="<%=request.getContextPath()%>/collectionShopFindByUserId.do?userId=${user.id}&currentpage=1"
                                   target="mainContent">店铺</a></li>
                            <li><a id="soregoods"
                                   href="<%=request.getContextPath()%>/collectionProductFindByUserId.do?userId=${user.id}&goodName=''&currentpage=1"
                                   target="mainContent">商品</a></li>
                        </ul>
                    </li>
                    <c:if test="${user.userName==right && (! empty right)}">
                        <!--

                        <li class="comman">
                        <a href="#" class="menu_tip">留言管理</a>
                        <ul>
                        <li>
                        <a href="message/Message.html" target="mainContent">查看留言 </a>
                        </li>
                        </ul>
                        </li>
                        -->
                    </c:if>
                    <li class="comman">
                        <a href="#" class="menu_tip">定单管理</a>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/order/searchAllCusOrders.do"
                                   target="mainContent">查看顾客订单</a></li>
                            <li><a href="<%=request.getContextPath()%>/order/searchAllOwnOrders.do"
                                   target="mainContent">查看已下订单</a></li>
                        </ul>
                    </li>
                    <c:if test="${user.userName==right && (! empty right)}">
                        <li class="comman">
                            <a href="#" class="menu_tip">经营店铺管理</a>
                            <ul>
                                <li><a href="<%=request.getContextPath()%>/findAllshopManage.do?currentpage=1"
                                       target="mainContent">查看经营店铺</a></li>
                            </ul>
                        </li>
                    </c:if>
                    <li class="comman">
                        <a href="#" class="menu_tip">维权</a>
                        <ul>
                            <li><a href="<%=request.getContextPath() %>/complaint/searchAllComplaints.do"
                                   target="mainContent">投诉回复结果</a></li>
                            <li><a href="<%=request.getContextPath() %>/complaint/searchComplaintAlert.do"
                                   target="mainContent">收到他人投诉</a>
                            </li>
                            <c:if test="${user.userName==right && (! empty right)}">
                                <li><a href="<%=request.getContextPath() %>/complaint/searchSystemComplaints.do"
                                       target="mainContent">查看所有投诉</a></li>
                                <li><a href="<%=request.getContextPath() %>/complaint/searchAllComplaintAlert.do"
                                       target="mainContent">收到所有警告</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="comman">
                        <a href="#" class="menu_tip">个人信息管理</a>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/findUserByUserId.do?userId=${user.id}"
                                   target="mainContent">修改个人信息</a></li>
                        </ul>
                    </li>

                    <c:if test="${user.userName==right && (! empty right)}">
                        <li class="comman">
                            <a href="#" class="menu_tip">会员管理</a>
                            <ul>
                                <li>
                                    <a href="<%=path %>/system/findAllUsersByPage.do" target="mainContent">查看会
                                            <%--                                    <a href="member/MembersInfo.jsp" target="mainContent">查看会--%>

                                        员信息</a>
                                </li>
                                <li>
                                    <a href="shop/myshop/ispromotOpenShop/addCode.jsp?addCodeType=1"
                                       target="mainContent">添加激活码</a>
                                </li>
                                <li>
                                    <a href="<%=path %>/system/selectCodeActiveByPage.do"
                                       target="mainContent">查询激活码</a>
                                </li>
                            </ul>
                        </li>
                        <!--
                        <li class="comman">
                        <a href="#" class="menu_tip">日志管理</a>
                        <ul>
                        <li>
                        <a href="log/log.html" target="mainContent">查看日志</a>
                        </li>


                        </ul>
                        </li>
                        -->
                        <li class="comman">
                            <a href="#" class="menu_tip">站内信息发布</a>
                            <ul>
                                <li><a href="<%=request.getContextPath() %>/stationAnnouce/searchAllStationAnnouces.do"
                                       target="mainContent">查看信息发布</a></li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
            </div>
            <div id="menu_buttom"></div>
        </div>
        <div id="content" style="width: 1002px;overflow: hidden;float: right;position: relative;">

            <div style="color:#999999; font-size:13px;background-repeat:no-repeat; position: absolute; margin-left:778px; margin-top: 10px;">
                <span style="margin-right: 7px;"><a
                        href="<%=request.getContextPath() %>/stationAnnouce/searchSendStationAnnouces.do"
                        target="mainContent" style="text-decoration:none;">站长信息<img
                        src="<%=request.getContextPath()%>/images/sysytem/information.jpg"
                        style="vertical-align:middle; border:none;"/><span id="stationAnnouce"
                                                                           style="color:red;"></span>个</a></span>在线人数：<span
                    id="menber"></span>人
            </div>
            <div id="content_top" style="line-height: 35px;"><span
                    style="font-size: 14px;font-weight: 800;margin-left: 40px;">设置板块</span></div>
            <div id="content_middle">
                <iframe width="995" height="750" src="" frameborder="0" scrolling="no" name="mainContent"
                        id="mainContent" class="a"></iframe>

            </div>
            <div id="content_buttom"></div>

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
        <div class="pos" style="clear:both; text-align:center; margin-top:40px; color:#9b9b9b; font-size:12px;">优复用
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
<div class="line5">
    <ul>
        <li></li>
    </ul>
</div>
<div class="line1"></div>
<div class="backg3"></div>
<%
    if ((User) request.getSession().getAttribute("user") == null) {
        out.println("<script>window.open('../cjmqylogin/login.jsp','_parent')</script>");
    }
%>
</body>
</html>
