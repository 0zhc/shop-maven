<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%--<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>优复用宝贝详细信息</title>

    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <script src="<%=path %>/shop/showTip/thickbox.js"></script>
    <link href="<%=path %>/shop/showTip/thickbox.css" type="text/css" rel="stylesheet"/>

    <script src="../js/UI/ui.base.min.js"></script>
    <script src="../js/UI/ui.draggable.min.js"></script>
    <% int temp = Integer.parseInt(request.getParameter("template"));
        if (temp == 1) {
    %>
    <link href="<%=path %>/shop/shop_css/pro_detail.css" rel="stylesheet"/> <!--这是蓝色-->
    <%
    } else {

    %>
    <link href="<%=path %>/shop/shop_css/red/pro_red_detail.css" rel="stylesheet"/><!--这是红色-->
    <%
        }
    %>
    <!--<link href="shop_css/pro_detail.css" rel="stylesheet" />--><!--这是蓝色-->

    <script src="${pageContext.request.contextPath}/csm_editor/kindeditor.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/csm_editor/themes/default/default.css"/>
    <style type="text/css">
        #messages a {
            color: #666;
            text-decoration: none;
        }
    </style>
    <script>
        var editor;
        KindEditor.ready(function (K) {
            editor = K.create('textarea[name="content"]', {
                items: [               //这个是新修改
                    'fontname', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                    'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                    'insertunorderedlist', '|', 'emoticons', 'link'],
                afterChange: function () {
                    var countCurrent = this.count('text');//输入了多少个字
                    var count = 200 - countCurrent;//还可以输入多少个字
                    document.getElementById("wordId").value = countCurrent;
                    if (count < 0) {
                        count = -count;
                        K('#content_msg').html("<font style ='color:#ec4501;'>您的输入已超出" + count + "个字</font>");
                    } else {
                        K('#content_msg').html("<font style='color:#2D2D2D; font-size:14px; font-family:宋体;'>您还可以输入" + count + "字</font>");
                    }
                }
            });

        });


    </script>
    <script type="text/javascript">
        function execute() {
            query(1);
            total();
        }

        function addEvaluation() {
            if ($('#u').val() == "") {
                alert("您还没有登录,不能评价.请先登录");

                return;
            }
            var content = editor.html();   //获得评价内容
            var editorLength = editor.count('text');
            if (editor.isEmpty()) {
                $('#content_msg').html("<font color='red'>商品评价不能为空</font>");
                return;
            } else if (editorLength > 200) {
                $('#content_msg').html("<font color='red'>商品评价不能超过200个字</font>");

                return;
            } else {
                $('#content_msg').html("");
            }
            var wordId = $('#wordId').val();
            $('tr.evaluationTr').remove();
            $('#num').html("");
            $('#prevPage').html("");
            $('#nextPage').html("");
            $('#pageNumDiv').html("");

            var goodId = $('#goodId').val();     //获得被评价的商品ID
            var length = $(':checked').length;   //判断是否匿名是否被选上
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath() %>/evaluation/addEvaluation.do',
                data: {'wordId': wordId, 'content': content, 'goodId': goodId, 'anonymity': length},
                dataType: 'json',
                success: function (msg) {
                    showEvaluation(msg);
                    if (msg.login == "noLogin") {
                        //	alert("请先登录");
                        alert("您还没有登录,不能评价.请先登录");

                    } else if (msg.content == "noContent") {
                        $('#content_msg').html("<font color='red'>商品评价不能为空</font>");

                    } else if (msg.content == "tooLong") {
                        $('#content_msg').html("<font color='red'>商品评价不能超过200个字</font>");

                    }
                }
            });
            editor.html("");
        };

        $(function () {


            $(".modifytip").click(function (e) {


                var x = -300;
                var y = 10;
                $("#show")
                    .css({
                        "top": (e.pageY + y) + "px",
                        "left": (e.pageX + x) + "px"
                    }).fadeIn();	  //设置x坐标和y坐标，并且显示
            });

            $("#close").click(function () {


                $("#show").fadeOut();
            });


            $(".modifytip").click(function () {

                $("#content").empty();


                var type = $(this).attr("title");


                switch (type) {
                    case 'order':
                        $('#content').append(
                            $('<div style="width: 575px; height: 330px;">').append(
                                $('<iframe src="order/orderImformation.html" style="width: 575px; height: 330px;" id="a">')
                            )
                        );
                        break;
                    default:
                        ;
                }

            });
        });

        function showEvaluation(msg) {

            for (var i in msg.evaluations) {
                $('#messages').append("<tr  class='evaluationTr'><td  style='padding-left:20px; width:100px;padding-top:10px;'" +
                    " class='leaveMesser'>" + msg.evaluations[i].authorName + ": </td><td   width='650px'>" + msg.evaluations[i].content +
                    "</td></tr><tr style='text-align:right;'  class='evaluationTr'><td colspan='2' width='770px'>" + msg.evaluations[i].createDate + "</td></tr>" +
                    "<tr  class='evaluationTr'><td colspan='2' width='770px' style='border-bottom:#999999  dotted 1px; height:1px;'>&nbsp;</td></tr>");

            }
            $('#messages').append("<tr  style='text-align:right;' class='evaluationTr'>" +
                "<td colspan='2' id='page' width='770px' ><span id='prevPage'></span>" +
                "<span class='numclass' id='num'></span><span id='nextPage'></span><span id='pageNumDiv'></span></td></tr>");


            if (msg.p.hasPrevPage == true) {
                var pp = msg.p.currentPage - 1;
                $('#prevPage').html("<a href='javascript:query(" + pp + ")'>上一页</a>");
            }
            if (msg.p.hasNextPage == true) {
                var np = msg.p.currentPage + 1;
                $('#nextPage').html("<a href='javascript:query(" + np + ")'>下一页</a>");
            }
            if (msg.evaluations.length != 0) {
                $('#pageNumDiv').html("&nbsp;&nbsp;到第<input type=text style=width:20px name=pagenum id=pagenum />页&nbsp;&nbsp;" +
                    "<input type=button value=确定 onclick=query($('#pagenum').val()) />");
            }
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
        }

        function query(i) {

            if (i == "" || i == null) {
                i = 1;
            }

            $('tr.evaluationTr').remove();
            $('#num').html("");
            $('#prevPage').html("");
            $('#nextPage').html("");
            $('#pageNumDiv').html("");
            var goodsId = $('#goodId').val();
            $.ajax({
                type: "GET",
                data: {'currentPage': i, 'goodsId': goodsId},
                url: "<%=request.getContextPath()%>/evaluation/pageEvaluation.do?" + escape(new Date()), //分页查询
                dataType: "json",  //这个指定它是json
                success: function (msg) {
                    showEvaluation(msg);
                }
            });
        }
    </script>

    <script>
        $(function () {
            $("#showTip").mouseover(function () {
                $("#show").draggable({containment: "parent"});
            }).css("cursor", "move");


        });
    </script>
    <script type="text/javascript">
        function ShowOrder() {
            var stock = document.getElementById("stock").value;
            var user = '${user}';
            if (user == "") {
                alert("您还没有登录，请先登录！");
                return;
            } else if (stock == 0) {
                alert("商品库存为0，无法购买！");
                return;
            }
            var goodsId = '${goods.id}';
            var amount = $("#amount").val();
            var path = '<%=path %>/order/selectGoodsOrder.do?goodsId=' + goodsId + '&amount=' + amount + '&keepThis=true&TB_iframe=true&height=500&width=800';
            window.parent.ShowOrder(path);
        }

        function evaluationChectLogin() {
            var goodsId = '${goods.id}';
            var amount = $("#amount").val();
            var path = '<%=path %>/order/selectGoodsOrder.do?goodsId=' + goodsId + '&amount=' + amount + '&keepThis=true&TB_iframe=true&height=500&width=800';
            window.parent.ShowOrder(path);
        }

        function ShowCart() {
            var stock = document.getElementById("stock").value;
            var user = '${user}';
            if (user == "") {
                alert("您还没有登录，请先登录！");
                return;
            } else if (stock == 0) {
                alert("商品库存为0，无法购买！");
                return;
            }
            var goodsId = '${goods.id}';
            var amount = $("#amount").val();
            var path = '<%=path %>/cart/addCart.do?goodsId=' + goodsId + '&amount=' + amount + '&keepThis=true&TB_iframe=true&height=500&width=800';
            window.parent.ShowCart(path);
        }
    </script>

    <!-- liuming -->
    <script type="text/javascript">
        function total() {
            var price = $("#price").val();
            var amount = document.getElementById("amount").value;
            var total = price * amount;
            document.getElementById("total").innerHTML = total.toFixed(2) + "元";
        }

        function check() {
            var price = document.getElementById("price").value;
            var amount = document.getElementById("amount").value;
            var stock = document.getElementById("stock").value;
            var reg = /^[1-9][0-9]{0,}$/;
            if (amount == "" || amount == null) {
                amount = 1;
                document.getElementById("amount").value = "1";
            }
            if (!reg.test(amount)) {
                amount = 1;
                document.getElementById("amount").value = "1";
            }
            if (Number(amount) > Number(stock)) {
                document.getElementById("amount").value = stock;
                amount = stock;
            }
            var total = price * amount;
            document.getElementById("total").innerHTML = total.toFixed(2) + "元";
        }

    </script>
    <style type="text/css">
        #modify {
            width: 600px;
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
            width: 576px;
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
            left: 550px;
        }

        #close img {
            border: none;
        }
    </style>
    <style type="text/css">
        * {
            padding: 0px;
            margin: 0px;
        }

        #describle_top {
            width: 918px;
            background-size: 945px;
            padding-left: 26px;
            height: 59px;
        }

        #describle_middle, #describle_bottom {
            width: 938px;
            background-size: 945px;
        }

        #describle_bottom {
            height: 20px;
        }

        #mess_text {
            width: 942px;
        }

        #mess_text table {
            width: 942px;
        }

        #messages {
            width: 942px !important;
        }

    </style>
</head>

<body onload="execute()">
<div>
    <form action="" method="post" name="goodForm">
        <input type="hidden" name="path" id="path" value="<%=request.getContextPath() %>"/>
        <input type="hidden" name="goodsId" id="goodsId" value="${goods.id }"/>
        <input type="hidden" name="goodId" id="goodId" value="${goods.id }"/>
        <input type="hidden" name="u" id="u" value="${sessionScope.user}"/>

        <table id="pro_datail_table" style="width: 942px;height: 300px;">

            <tr>
                <td rowspan="9"
                    style=" width:599px; height:315px; overflow:hidden;background-repeat: no-repeat; text-align: center;  ">
                    <img src="<%=path %>/${goods.url}" width="557px" height="300px" style="border:#ccc 1px solid;"/>
                </td>
                <td colspan="2" class="commond" style="font-size:15px; color:#000000; font-weight:900; "
                    id="goodTiptitle">宝贝信息
                </td>
            </tr>
            <tr>
                <td class="commond">名称:</td>
                <td style="color:#000000; font-size:14px; font-weight:900;">${goods.name } </td>
            </tr>

            <tr>
                <td class="commond">单 价:</td>
                <td style="color:#ed0000; font-size:14px; font-weight:900;">${goods.price }元 <input type="hidden"
                                                                                                    name="price"
                                                                                                    id="price"
                                                                                                    value="${goods.price }"/>
                </td>
            </tr>
            <tr>
                <td class="commond">特色服务:</td>
                <td>送货上门</td>
            </tr>
            <tr>
                <td class="commond">付货方式:</td>
                <td>货到付货</td>
            </tr>
            <tr>
                <td class="commond">颜 色:</td>
                <td>${goods.color }<br/></td>
            </tr>
            <tr>
                <td class="commond">数 量:</td>
                <td><input type="text" name="amount" id="amount" value="1" onchange="check()"
                           style="border:#bcbcbc solid 1px; width:20px; "/><span
                        style="margin-right:10px; ">(库存量有${goods.amount }件)</span><input type="hidden" name="stock"
                                                                                         id="stock"
                                                                                         value="${goods.amount }"/></td>
            </tr>
            <tr>
                <td class="commond">总 计:</td>
                <td style="color:#ed0000; font-size:14px; font-weight:900;"><span id="total"></span></td>
            </tr>
            <tr>
                <td style="padding-left:10px; vertical-align:bottom;">
                    <a href="javascript:void(0)" id="order" onclick="ShowOrder()"><img
                            src="<%=request.getContextPath() %>/shop/shop_image/buy_button1.jpg"/></a>

                </td>
                <td style=" vertical-align:bottom;">
                    <a href="javascript:void(0)" title="店铺装修对话框" id="cart" onclick="ShowCart()"><img
                            src="<%=request.getContextPath() %>/shop/shop_image/car_button1.jpg"/></a>
                </td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>

        </table>
    </form>
</div>
<div id="describle" style="margin-bottom:50px;">
    <div id="describle_top" style="line-height:40px;">宝贝说明</div>
    <div id="describle_middle">
        <div id="profeatureTop">产品特色</div>
        <div id="profeatureTopMain">
            <p>${goods.description  } </p>


        </div>
    </div>
    <div id="describle_bottom"></div>
</div>

<div style="margin-bottom:50px;">
    <div id="service_top" style=" font-size:18px; font-weight:900;"><span style="margin-left:10px;">售后服务</span></div>
    <div id="service_line">

    </div>
    <div id="service_main">
        <p>退换货服务标准退换货基本条件： </p>
        <p> ·对全部商品：
            ·外包装完整，且不影响二次销售。一旦拆封无法复原商品不可退货（质量问题除外）。 </p>

        <p>&nbsp;</p>
    </div>
</div>

<div id="mess_box">
    <div id="mess_text">
        <form>
            <input type="hidden" name="wordId" id="wordId"/>
            <table>
                <tr>
                    <td colspan="2" class="leaveMesser">给商品评价</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea name="content" style="width:936px; height: 125px;" id="content1"></textarea>
                        &nbsp;<span id="content_msg"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="checkbox" id="anonymity" name="anonymity" value="1"/>
                        <span id="anonymity_text">&nbsp;匿名</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:right;"><input type="button" id="evaluate"
                                                                     onclick="addEvaluation()" value="给宝贝评价"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>

<div id="contain_mess">
    <table id="messages" width="942px;">
        <tr id="messages_top" style="background-size: 942px;">
            <td colspan="2"
                style="padding-left:20px;  width:942px; font-size:14px; font-weight:900; color:#FFFFFF; line-height:40px; ">
                评价信息
            </td>
        </tr>
    </table>
</div>

</body>
</html>
