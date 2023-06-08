<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我收藏的店铺</title>
    <link href="<%=request.getContextPath()%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>

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
        function deleteShop() {
            var selectFlags = document.getElementsByName("selectFlag");
            var flag = false;
            for (var i = 0; i < selectFlags.length; i++) {
                if (selectFlags[i].checked) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                alert("请选择需要删除的用户！");
                return;
            }
            if (window.confirm("确认删除吗？")) {

                with (document.getElementById("userform")) {
                    action = "<%=request.getContextPath()%>/collectionShopDeleteAllShop.do?userId=${user.id}";
                    method = "post";
                    submit();
                }
            }
        }

        //确定是否要删除一个店铺
        function deleteOneShop(shopId) {
            if (window.confirm("确定删除？")) {
                window.location.href = "<%=request.getContextPath()%>/collectionShopDeleteByShopId.do?shopId=" + shopId + "&userId=${user.id}";
            }
        }

        //按条件搜索，并提交表单
        function selectShop() {

            with (document.getElementById("userform")) {
                action = "<%=request.getContextPath()%>/collectionShopSelectAllShop.do?userId=${user.id}";
                method = "post";
                submit();
            }
        }


        // 对页码修改对应的样式
        $(function () {
            page = "${pager.currentPage}";
            $(".ACountClass").each(function () {

                if (this.innerHTML == parseInt(page)) {
                    $(this).css({"color": "blue", "text-decoration": "underline"});
                }
            });
        });


        //分页
        function shopPage(currentpage, userId, shopName, datetime1, datetime2) {

            var shopName = encodeURI(encodeURI(shopName));//编码，防止中文乱码

            window.location.href = "<%=request.getContextPath()%>/collectionShopSelectAllShop.do?currentpage=" + currentpage + "&userId=" + userId + "&shopName=" + shopName + "&datetime1=" + datetime1 + "&datetime2=" + datetime2;
        }


    </script>

</head>
<body>
<div id="content">
    <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">店铺收藏</a>
    </div>
    <form id="userform">
        <table class="myshop">
            <tr>
                <td style="text-align:center; font-size:15px; height:30px;" colspan="4">
                    店铺名称：<input type="text" name="shopName" maxlength="50" value="${shopName}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    收藏日期： <input type="text" name="datetime1" value="${datetime1}" readonly="readonly"
                                 style="width: 100px;" onClick="WdatePicker()"/>&nbsp;——&nbsp;
                    <input type="text" name="datetime2" value="${datetime2}" readonly="readonly" style="width: 100px;"
                           onClick="WdatePicker()"/>
                    <input type="hidden" name="currentpage" value="1">
                </td>
            </tr>

            <tr>
                <td style="text-align:center;" colspan="4">
                    <input type="button" value="搜索" onClick="selectShop()"/>
                    <input type="reset" value="重置"/>
                </td>
            </tr>

            <tr>
                <td style="text-align:center;font-size:15px;"><input type="checkbox" name="ifAll"
                                                                     onClick="checkAll(this)"/>全选
                </td>
                <td style="text-align:center;font-size:15px;">店铺名称</td>
                <td style="text-align:center;font-size:15px;">收藏时间</td>
                <td style="text-align:center;font-size:15px;">操作</td>
            </tr>

            <c:forEach items="${collectionShopList}" var="c">
                <tr>
                    <td style="text-align:center;"><input type="checkbox" name="selectFlag" value="${c.shops.id}"/></td>
                    <td style="text-align:center;"><a href="<%=request.getContextPath()%>/shop.do?id=${c.shops.id }"
                                                      target="_top">${c.shops.name}</a></td>
                    <td style="text-align:center;">
                        <fmt:formatDate value="${c.storeDate}" type="both" pattern="yyyy年MM月dd日" var="date"/>
                            ${date}
                    </td>
                    <td style="text-align:center;"><a href="javascript:deleteOneShop(${c.shops.id})">删除</a></td>
                </tr>
            </c:forEach>

            <tr>
                <td style=" padding-left:35px; font-size:15px; height:30px;" colspan="4">
                    <input type="button" value="批量删除" onClick="deleteShop()">
                </td>
            </tr>

            <tr>
                <td style=" text-align:center; font-size:15px; height:30px;" colspan="4">

                    <c:choose>
                        <c:when test="${!empty collectionShopList}">

                            总共有[${pager.totalPages}]页 当前页是第[${pager.currentPage}]页

                            <%--判断首页--%>
                            <c:choose>
                                <c:when test="${pager.totalPages==1}">
                                    首页
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:shopPage('1','${userId}','${shopName}','${datetime1}','${datetime2}');">首页</a>
                                </c:otherwise>
                            </c:choose>

                            <%--判断是否有上一页--%>
                            <c:if test="${pager.hasPrePage}">
                                <a href="javascript:shopPage('${pager.currentPage-1}','${userId}','${shopName}','${datetime1}','${datetime2}');">上一页</a>
                            </c:if>

                            <%--<c:forEach标签的数字迭代 --%>

                            <c:forEach begin="${pager.currentPageStart}" end="${pager.currentPageEnd}" var="count">
                                <c:if test="${count<=pager.totalPages}">
                                    <a href="javascript:shopPage('${count}','${userId}','${shopName}','${datetime1}','${datetime2}');"
                                       class="ACountClass">${count}</a>
                                </c:if>
                            </c:forEach>

                            <%--判断是否有下一页--%>
                            <c:if test="${pager.hasNextPage}">
                                <a href="javascript:shopPage('${pager.currentPage+1 }','${userId}','${shopName}','${datetime1}','${datetime2}');">下一页</a>
                            </c:if>

                            <%--判断尾页--%>
                            <c:choose>
                                <c:when test="${pager.totalPages==1}">
                                    尾页
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:shopPage('${pager.totalPages }','${userId}','${shopName}','${datetime1}','${datetime2}');">尾页</a>
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