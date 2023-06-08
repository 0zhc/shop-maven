<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>无标题文档</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>
    <%
        String template = request.getParameter("template");
        if (template != null) {
            if ("1".equals(template)) {
    %>
    <link href="<%=request.getContextPath()%>/shop/shop_css/pro_scope.css" rel="stylesheet"/><!--这个是蓝色--><%
} else {
%>
    <link href="<%=request.getContextPath()%>/shop/shop_css/red/pro_red_scope.css" rel="stylesheet"/><!--这个是红色--><%
        }
    }

%>


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
    </style>
    <script type="text/javascript">
        $(function () {
            var isMoidfy = '${param.isModify }';
            if (isMoidfy == 1) {

                $("#Scopcontianer").hover(function () {
                    $(this).css("border", "red solid 1px");
                    $(this).children("a").show();

                }, function () {
                    $(this).css("border", "none");
                    $(this).children(".modifytip").hide();
                }).css("cursor", "pointer");
            }

        });
    </script>
    <script>

        function ShowScope() {
            var path = '<%=request.getContextPath()%>/shop/shopModify/scope/modify_scopeMidd.jsp?userId=' + '${userId}' + '&keepThis=true&TB_iframe=true&height=370&width=800';
            window.parent.ShowScope(path);
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
            background: url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/modify_left.gif) no-repeat;
        }

        #modify_middle {
            width: 700px;
            background: url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/modify_middle.jpg) repeat-x;
            position: relative;
        }

        #modify_right {
            width: 12px;
            background: url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/modify_right.gif) no-repeat;
        }

        #close {
            float: right;
            position: absolute;
            top: 8px;
            left: 680px;
        }

        #close img {
            border: none;
        }
    </style>
</head>

<body>

<div id="Scopcontianer" style="height:800px; width:914px; position:relative; overflow:hidden;">
    <a href="javascript:void(0)" title="scope" onclick="ShowScope()" class="modifytip"
       style="display:none;  position:absolute; left:730px; top:10px;">修改</a>
    <div id="Scoptip" style="font-size:16px;"><span style="margin-left:20px;">配送范围</span>

    </div>

    <div style=" background-image:url(<%=request.getContextPath()%>/shop/shop_image/goodsdescripTipmiddle.jpg);width:895px;background-size: 922px;  background-repeat:repeat-y; padding-left:10px; padding-right:10px; padding-bottom:20px;">
        ${shop.deliverScope}
    </div>

    <div style="background-image:url(<%=request.getContextPath()%>/shop/shop_image/goodsdescripTipbottom.jpg); background-repeat:no-repeat; background-size: 922px; width:915px; height:19px;"></div>
</div>

<div style=" height:420px;  background-color:none; position:absolute; left:430px; top:140px; z-index:500; display:none; "
     id="show">
    <div id="modify">
        <div id="modify_left"></div>
        <div id="modify_middle">
            <div id="showTip" style="height:33px; line-height:33px;">
                装修店铺对话框
                <a href="#" id="close"><img
                        src="<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/close_modify.jpg"
                        alt="关闭装修店铺对话框" onClick="return false"/></a></div>


            <div id="content" style="height:330px; width:915px; margin-top:10px; ">

                <!--<iframe width="550px" height="330px"   frameborder="0" scrolling="no" name="showDiv" id="showDiv" src="3.html"></iframe>-->

            </div>

        </div>

        <div id="modify_right"></div>

    </div>

</div>

</body>
</html>
