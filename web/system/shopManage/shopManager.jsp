<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>查看经营店铺</title>
    <link href="<%=request.getContextPath()%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="<%=request.getContextPath()%>/cjmqyeditor/kindeditor.js"></script>
    <script src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>

    <style type="text/css">
        .ACount {
            color: blue;
        }

        a {
            text-decoration: none;
            color: #000000;
            margin-left: 3px;
        }

        a:hover {
            color: #000000;
        }
    </style>

    <script type="text/javascript">

        //删除功能，若ifAll选中，则全部selectFlag选中。
        //删除功能，若ifAll没选中，则全部selectFlag不选中。
        function checkAll(field) {
            var selectFlags = document.getElementsByName("selectFlag");
            for (var i = 0; i < selectFlags.length; i++) {
                selectFlags[i].checked = field.checked;
            }
        }

        //删除的时候，判断是否有选中的删除项目
        function deleteShopManager() {
            var selectFlags = document.getElementsByName("selectFlag");
            var flag = false;
            for (var i = 0; i < selectFlags.length; i++) {
                if (selectFlags[i].checked) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                alert("请选择需要删除的违规店铺！");
                return;
            }
            if (window.confirm("确认删除吗？")) {

                with (document.getElementById("userform")) {
                    action = "<%=request.getContextPath()%>/shopManagerDeleteAllShop.do";
                    method = "post";
                    submit();
                }
            }
        }

        //确定是否要删除一个店铺
        function deleteIllegalityShop(shopId) {
            if (window.confirm("确定删除？")) {
                window.location.href = "<%=request.getContextPath()%>/shopManageDeleteByShopId.do?shopId=" + shopId;
            }
        }


        //按条件搜索，并提交表单
        function selectShopManger() {

            with (document.getElementById("userform")) {
                action = "<%=request.getContextPath()%>/shopManagerSelectAllShop.do";
                method = "post";
                submit();
            }
        }

        // 对页码修改对应的样式
        $(function () {
            page = "${pager.currentPage}";
            $(".ACountClass").each(function () {

                if (this.innerHTML == parseInt(page)) {
                    $(this).addClass("ACount");
                }
            });
        });

    </script>

</head>

<body>
<div id="content">
    <form id="userform">
        <table class="myshop">
            <tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
                <td colspan="9"><a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">店铺管理</a>
                </td>
            </tr>

            <tr>
                <td style=" text-align:center; font-size:15px; height:30px;" colspan="8">
                    店名：<input type="text" name="shopName" maxlength="35" value="${shopName}" style="width: 95px;">&nbsp;&nbsp;
                    店主：<input type="text" name="shopUser" maxlength="35" value="${shopUser}" style="width: 90px;">&nbsp;&nbsp;
                    开店时间：<input type="text" name="datetime1" value="${datetime1}" readonly="readonly"
                                style="width: 95px;" onClick="WdatePicker()"/>&nbsp;——&nbsp;<input type="text"
                                                                                                   name="datetime2"
                                                                                                   value="${datetime2}"
                                                                                                   readonly="readonly"
                                                                                                   style="width:95px;"
                                                                                                   onClick="WdatePicker()"/>
                    <input type="hidden" name="currentpage" value="1">
                </td>
            </tr>

            <tr>
                <td style="text-align:center;" colspan="8">
                    <input type="button" value="搜索" onClick="selectShopManger()"/>
                    <input type="reset" value="重置"/>
                </td>
            </tr>

            <tr height="30px">
                <td style="text-align:center;"><input type="checkbox" name="ifAll" onClick="checkAll(this)"/>全选</td>
                <td style="text-align:center;font-size:15px;">店名</td>
                <td style="text-align:center;font-size:15px;">店标</td>
                <td style="text-align:center;font-size:15px;">类型</td>
                <td style="text-align:center;font-size:15px;">开店时间</td>
                <td style="text-align:center;font-size:15px;">店主</td>
                <td style="text-align:center;font-size:15px;">介绍</td>
                <td style="text-align:center;font-size:15px;">操作</td>
            </tr>

            <c:forEach items="${shopList}" var="s">
                <tr height="30px">
                    <td style="text-align:center;"><input type="checkbox" name="selectFlag" value="${s.id}"/></td>
                    <td style="text-align:center;font-size:15px;"><a
                            href="<%=request.getContextPath()%>/shop.do?id=${s.id}" target="_top">${s.name}</a></td>
                    <td style="text-align:center;font-size:15px;">${s.logoUrl}</td>
                    <td style="text-align:center;font-size:15px;">${s.shopBuyType}</td>
                    <td style="text-align:center;font-size:15px;">
                        <fmt:formatDate value="${s.createDate}" type="both" pattern="yyyy年MM月dd日" var="date"/>
                            ${date}
                    </td>
                    <td style="text-align:center;font-size:15px;">${s.user.userName}</td>
                    <td style="text-align:center;font-size:15px;">${s.shopInfo}</td>
                    <td style="text-align:center;font-size:15px;">
                        <a href="javascript:deleteIllegalityShop(${s.id})">关闭违规店铺</a>
                    </td>
                </tr>
            </c:forEach>

            <tr height="30px">
                <td style=" padding-left:35px; font-size:15px; height:30px;" colspan="8">
                    <input type="button" value="批量删除" onClick="deleteShopManager()">
            </tr>

            <tr>
                <td style="text-align:center; font-size:15px; height:30px;" colspan="8">
                    <c:choose>
                        <c:when test="${!empty shopList}">

                            总共有[${pager.totalPages}]页 当前页是第[${pager.currentPage}]页

                            <%--判断首页--%>
                            <c:choose>
                                <c:when test="${pager.totalPages==1}">
                                    首页
                                </c:when>
                                <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/shopManagerSelectAllShop.do?currentpage=1&shopName=${shopName}&shopUser=${shopUser}&datetime1=${datetime1}&datetime2=${datetime2}">首页</a>
                                </c:otherwise>
                            </c:choose>

                            <%--判断是否有上一页--%>
                            <c:if test="${pager.hasPrePage}">
                                <a href="<%=request.getContextPath()%>/shopManagerSelectAllShop.do?currentpage=${pager.currentPage-1}&shopName=${shopName}&shopUser=${shopUser}&datetime1=${datetime1}&datetime2=${datetime2}">上一页</a>
                            </c:if>

                            <%--<c:forEach标签的数字迭代 --%>

                            <c:forEach begin="${pager.currentPageStart}" end="${pager.currentPageEnd}" var="count">
                                <c:if test="${count<=pager.totalPages}">
                                    <a href="<%=request.getContextPath()%>/shopManagerSelectAllShop.do?currentpage=${count}&shopName=${shopName}&shopUser=${shopUser}&datetime1=${datetime1}&datetime2=${datetime2}"
                                       class="ACountClass">${count}</a>
                                </c:if>
                            </c:forEach>

                            <%--判断是否有下一页--%>
                            <c:if test="${pager.hasNextPage}">
                                <a href="<%=request.getContextPath()%>/shopManagerSelectAllShop.do?currentpage=${pager.currentPage+1 }&shopName=${shopName}&shopUser=${shopUser}&datetime1=${datetime1}&datetime2=${datetime2}">下一页</a>
                            </c:if>

                            <%--判断尾页--%>
                            <c:choose>
                                <c:when test="${pager.totalPages==1}">
                                    尾页
                                </c:when>
                                <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/shopManagerSelectAllShop.do?currentpage=${pager.totalPages}&shopName=${shopName}&shopUser=${shopUser}&datetime1=${datetime1}&datetime2=${datetime2}">尾页</a>
                                </c:otherwise>
                            </c:choose>

                        </c:when>
                        <c:otherwise>
                            没有找到符合条件的商品
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>