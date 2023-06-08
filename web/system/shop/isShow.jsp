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
    <script type="text/javascript" src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var isShowHot = '${userNew.shop.isShowHot}';
            var isShowNew = '${userNew.shop.isShowNew}';
            var isShowSecond = '${userNew.shop.isShowSecond}';

            if (isShowHot == 1) {
                $('input[@name=hot]').get(0).checked = true;
            } else if (isShowHot == 2) {
                $('input[@name=hot]').get(1).checked = true;
            }

            if (isShowNew == 1) {
                $('input[@name=new]').get(0).checked = true;
            } else if (isShowNew == 2) {
                $('input[@name=new]').get(1).checked = true;
            }

            if (isShowSecond == 1) {
                $('input[@name=second]').get(0).checked = true;
            } else if (isShowSecond == 2) {
                $('input[@name=second]').get(1).checked = true;
            }


        })

    </script>
    <script type="text/javascript">
        //是否显示最热
        function isHotShow() {
            var shopId = '${user.shop.id}';
            var isShow = $("input[name='hot']:checked").val();
            var setType = "hot";//hot 为最热
            $.ajax({
                type: "post",
                url: "<%=request.getContextPath()%>/shop/modifyIsShow.do?" + escape(new Date()),
                data: {'shopId': shopId, 'isShow': isShow, 'setType': setType},
                dataType: "html",//(可以不写,默认)
                beforeSend: function (XMLHttpRequest) {
                    $("#loading").show();
                },
                success: function (data, textStatus) {

                    if (data == 'ok') {
                        $("#loading").hide();
                        $("#tip").text("修改成功 ");
                    } else {
                        //注册失败
                        $("#tip").html('<font color="red">修改失败</font>');
                    }

                },
                complete: function (XMLHttpRequest, textStatus) {
                    //HideLoading();
                    $("#loading").hide();

                },

                error: function () {

                    //请求出错处理
                }

            });

        }

        //是否显示最新
        function isNewShow() {
            var shopId = '${user.shop.id}';
            var isShow = $("input[name='new']:checked").val();
            var setType = "new";//hot 为最热
            $.ajax({
                type: "post",
                url: "<%=request.getContextPath()%>/shop/modifyIsShow.do?" + escape(new Date()),
                data: {'shopId': shopId, 'isShow': isShow, 'setType': setType},
                dataType: "html",//(可以不写,默认)
                beforeSend: function (XMLHttpRequest) {
                    $("#loading").show();
                },
                success: function (data, textStatus) {

                    if (data == 'ok') {
                        $("#loading").hide();
                        $("#tip").text("修改成功");
                    } else {
                        //注册失败
                        $("#tip").html('<font color="red">修改失败</font>');
                    }

                },
                complete: function (XMLHttpRequest, textStatus) {
                    //HideLoading();
                    $("#loading").hide();

                },

                error: function () {

                    //请求出错处理
                }

            });

        }

        //是否显示二手
        function isSecondShow() {
            var shopId = '${user.shop.id}';
            var isShow = $("input[name='second']:checked").val();

            var setType = "second";//hot 为最热
            $.ajax({
                type: "post",
                url: "<%=request.getContextPath()%>/shop/modifyIsShow.do?" + escape(new Date()),
                data: {'shopId': shopId, 'isShow': isShow, 'setType': setType},
                dataType: "html",//(可以不写,默认)
                beforeSend: function (XMLHttpRequest) {
                    $("#loading").show();
                },
                success: function (data, textStatus) {

                    if (data == 'ok') {
                        $("#loading").hide();
                        $("#tip").text("修改成功");
                    } else {
                        //注册失败
                        $("#tip").html('<font color="red">修改失败</font>');
                    }

                },
                complete: function (XMLHttpRequest, textStatus) {
                    //HideLoading();
                    $("#loading").hide();

                },

                error: function () {

                    //请求出错处理
                }

            });

        }
    </script>
    <style type="text/css">
        input {

            border: 1px solid #888;
        }

    </style>
</head>


<body>
<div id="content">
    <form action="<%=path %>/system/selectUserGoodsByPage.do?jspType=shopSelectGoods" method="post">
        <table class="myshop">
            <tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
                <td colspan="3">
                    <a>首页</a><span>>></span><a>后台管理</a><span>>></span><a>设置显示模块</a>
                </td>
            </tr>

            <c:choose>
                <c:when test="${! empty userNew.shop}">
                    <tr>

                        <td style="text-align:center;font-size:14px;">模块名称</td>
                        <td style="text-align:center;font-size:14px;">是否显示</td>
                        <td style="text-align:center;font-size:14px;">操作</td>


                    </tr>

                    <tr>

                        <td style="text-align:center;font-size:14px;">最热</td>
                        <td style="text-align:center;font-size:14px;">显示<input type="radio" checked="checked" name="hot"
                                                                               value="1"/>不显示<input type="radio"
                                                                                                    name="hot"
                                                                                                    value="2"/></td>
                        <td style="text-align:center;font-size:14px;"><input type="button" value="修改"
                                                                             style="margin-right: 20px;"
                                                                             onclick="isHotShow();"/></td>


                    </tr>
                    <tr>

                        <td style="text-align:center;font-size:14px;">最新</td>
                        <td style="text-align:center;font-size:14px;">显示<input type="radio" checked="checked" name="new"
                                                                               value="1"/>不显示<input type="radio"
                                                                                                    name="new"
                                                                                                    value="2"/></td>
                        <td style="text-align:center;font-size:14px;"><input type="button" value="修改"
                                                                             style="margin-right: 20px;"
                                                                             onclick="isNewShow();"/></td>


                    </tr>
                    <tr>

                        <td style="text-align:center;font-size:14px;">二手</td>
                        <td style="text-align:center;font-size:14px;">显示<input type="radio" checked="checked"
                                                                               name="second" value="1"/>不显示<input
                                type="radio" name="second" value="2"/></td>
                        <td style="text-align:center;font-size:14px;"><input type="button" value="修改"
                                                                             style="margin-right: 20px;"
                                                                             onclick="isSecondShow();"/></td>


                    </tr>
                    <tr>

                        <td style="text-align:center;font-size:14px;" colspan="3"><a
                                href="<%=path %>/system/shop/prompt.do?Jsptype=seeUserShop" target="_top">查看修改结果</a>
                        </td>


                    </tr>
                    <tr>
                        <td colspan="3">
                            <div style="position: absolute;left: 300px; top:20px;"><img
                                    src="<%=path %>/images/load/loading.gif" id="loading" style="display: none;" / >
                            </div>
                            <div style="text-align: center;"><span id="tip" style="margin-right: 100px;"></span></div>
                        </td>
                    </tr>

                </c:when>
                <c:otherwise>
                    <tr style="text-align: center;">
                        <td colspan="3">您还没有开店</td>
                    </tr>
                </c:otherwise>
            </c:choose>

        </table>
    </form>
</div>
</body>
</html>
