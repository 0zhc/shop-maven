<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的店铺</title>
    <script src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript">


        var change = function (chkArray, val) {
            for (var i = 0; i < chkArray.length; i++)    //遍历指定组中的所有项
                chkArray[i].checked = val;              //设置项为指定的值——是否选中
        }

        function checkAll(field) {
            // var selectFlags = document.getElementsByName("selectFlag");
            var delIdArray = document.getElementsByName('delId');

            for (var i = 0; i < delIdArray.length; i++) {
                delIdArray[i].checked = field.checked;
            }
        }

        function checkStartTradeDate() {
            var time = document.getElementById("startTradeTime").value;
            if (time == "" || time == null) {
                alert("请先选择起始日期!");
                searchForm.startTradeTime.focus();
                return false;
            } else {
                return true;
            }
        }

        function checkDate() {
            var startTime = document.getElementById("startTradeTime").value;
            var endTime = document.getElementById("endTradeTime").value;
            if (startTime != "" && endTime == "") {
                alert("请选择结束日期!")
                searchForm.endTradeTime.focus();
                return false;
            }
            if (endTime < startTime) {
                alert("结束日期不能小于起始日期");
                searchForm.endTradeTime.value = "";
                return false;
            }
            if (endTime != "") {
                return checkStartTradeDate();

            }
            return true;

        }

        function isSubmit() {
            return checkDate();
        }


    </script>
</head>

<body>
<div id="content" style="padding-left: 10px;">
    <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">商品已买</a>
    </div>
    <form action="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do" method="post" name="searchForm"
          onsubmit="isSubmit()">
        <table class="myshop">

            <tr>
                <td style="text-align:center; font-size:15px; height:30px;" colspan="10">商品名称：
                    <input type="text" name="goodsName"/>
                    交易时间：
                    <input type="text" name="startTradeTime" id="startTradeTime" readonly="readonly"
                           onClick="WdatePicker()"/>
                    ——
                    <input type="text" name="endTradeTime" readonly="readonly" onClick="WdatePicker()"
                           onfocus="checkStartTradeDate()"/>
                    <input type="hidden" name="page" value="1">
                </td>
            </tr>
            <tr>
                <td style="text-align:center; font-size:15px; height:30px;" colspan="10"><input type="submit" value="搜索"
                                                                                                onfocus="checkDate()"/>
                    <input type="reset" name="button" id="button" value="重置"/></td>
            </tr>
    </form>
    <tr>
        <td colspan="8">
            <div id="dataLoad" style="display: none; text-align: center">
                <img src="<%=request.getContextPath()%>/images/load/loading.gif"
                     width="14" height="14">
                数据载入中，请稍后......
            </div>
            <div id="showLoadingDiv" style="display: block">
                <form action="<%=request.getContextPath()%>/tradeRecord/deleteTradProducts.do?delType=2" method="post">
                    <table class="myshop">
                        <c:if test="${page.num!=0}">
                            <tr>
                                    <%--				<td style="text-align:center;font-size:15px;"><input type="checkbox"  onclick= "change(document.getElementsByName('check'), this.checked)"/>全选</td>--%>
                                <td style="text-align:center;font-size:15px;"><input type="checkbox" name="ifAll"
                                                                                     onClick="checkAll(this)"/>全选
                                </td>
                                <td style="text-align:center;font-size:15px;">订单编号</td>
                                <td style="text-align:center;font-size:15px;">商品名称</td>
                                <td style="text-align:center;font-size:15px;">交易金额</td>
                                <td style="text-align:center;font-size:15px;">交易类型</td>
                                <td style="text-align:center;font-size:15px;">交易时间</td>
                                <td style="text-align:center;font-size:15px;">店铺名称</td>

                                <td style="text-align:center;font-size:15px;">维权</td>
                                <td style="text-align:center;font-size:15px;">操作</td>
                            </tr>
                            <c:forEach items="${tradeRecord}" var="tradeRecord" varStatus="status">
                                <tr>
                                    <td style="text-align:center;">
                                        <input name="delId" type="checkbox" id="check" value="${tradeRecord.id}"/>
                                    </td>
                                    <td style="text-align:center;">${tradeRecord.goodsOrder.orderNum }</td>
                                    <td style="text-align:center;"><a href="#">${tradeRecord.goods.name }</a></td>
                                    <td style="text-align:center;">${tradeRecord.goodsOrder.total }</td>
                                    <td style="text-align:center;">已买</td>
                                    <td style="text-align:center;">${tradeRecord.tradeTime}</td>
                                    <td style="text-align:center;">${tradeRecord.goods.shop.name }</td>
                                    <c:if test="${tradeRecord.preRightsId!=0}">
                                        <td style="text-align:center;font-size:20px;"><a
                                                href="<%=request.getContextPath()%>/tradeRecord/getTradProducts.do?id=${tradeRecord.id}">投诉商家</a>
                                        </td>
                                    </c:if>
                                    <c:if test="${tradeRecord.preRightsId==0}">
                                        <td style="text-align:center;font-size:20px;"><a
                                                href="<%=request.getContextPath()%>/complaint/selectComplaint.do?tradeId=${tradeRecord.id}">查看</a>
                                        </td>
                                    </c:if>
                                    <td style="text-align:center;"><a
                                            href="<%=request.getContextPath()%>/tradeRecord/deleteTradProducts.do?id=${tradeRecord.id}&delType=1"
                                            onClick="return confirm('是否删除?')">删除</a></td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td style=" font-size:15px; height:30px;" colspan="10">
                                    <input type="submit" onClick="return confirm('是否删除选中记录?')" value="批量删除"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="10" align="center">
                                    共${page.total}条记录 |
                                    <c:if test="${!page.hasPrePage}"> 首页 | 上一页 |</c:if>
                                    <c:if test="${page.hasPrePage}">
                                        <a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=1">首页</a> |
                                        <a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=${page.currentPage-1 }">上一页</a> |
                                    </c:if>
                                    <c:if test="${!page.hasNextPage}">下一页 | 尾页 | </c:if>
                                    <c:if test="${page.hasNextPage}">
                                        <a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=${page.currentPage+1 }">下一页</a> |
                                        <a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=${page.num }">尾页</a> |
                                    </c:if>
                                    当前第${page.currentPage }页 | 共${page.num }页

                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td colspan="10" align="center" height="50" valign="middle">
                                <c:if test="${page.num==0}">记录为空！</c:if>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </td>
    </tr>
    </table>
</div>
</body>
</html>
