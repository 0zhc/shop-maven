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
    <link href="<%=path%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>

</head>

<body>
<div id="content">
    <form action="<%=path %>/system/selectCodeActiveByPage.do">
        <table class="myshop">
            <tr style="line-height:21px;">
                <td colspan="3"><a href="../../../../index.html" target="_parent">首页</a><span>>></span><a
                        href="../../../manager_index.html" target="_parent">后台管理</a><span>>></span><span
                        style="font-size:15px;">查询商家激活码</span></td>
            </tr>

            <tr>
                <td colspan="3" style="text-align:center; font-size:15px;">用户名:&nbsp;&nbsp;<input type="text"
                                                                                                  height="20"
                                                                                                  name="userName"/>&nbsp;&nbsp;&nbsp;激活码:&nbsp;&nbsp;<input
                        type="text" height="20" name="activeCode"/>&nbsp;&nbsp;&nbsp;<input type="submit"
                                                                                            style="width: 50px;"
                                                                                            value="查询"/></td>

            </tr>

            <tr>

                <td style="text-align:center; font-size:15px;">
                    用户名
                </td>

                <td style="text-align:center; font-size:15px;">
                    激活码
                </td>

                <td style="text-align:center; font-size:15px;">
                    是否激活
                </td>

            </tr>

            <!-- 进行分页遍历 -->
            <c:choose>
                <c:when test="${! empty codeActives }">
                    <c:forEach items="${codeActives}" var="codeActive">

                        <tr>
                            <td style="text-align:center; font-size:15px;">
                                    ${codeActive.user.userName }
                            </td>
                            <td style="text-align:center; font-size:15px;">
                                    ${codeActive.active }
                            </td>

                            <td style="text-align:center; font-size:15px;">
                                <c:choose>
                                    <c:when test="${codeActive.isActive==1}">
                                        已激活
                                    </c:when>
                                    <c:otherwise>
                                        未激活
                                    </c:otherwise>
                                </c:choose>

                            </td>

                        </tr>
                    </c:forEach>
                    <tr align="center">
                        <td colspan="3">总共有
                            <span style="color: red"><c:out
                                    value="[${page.totalPages}]"></c:out> </span>页 &nbsp;&nbsp; 当前
                            <font color="red" style="font-size: 18px;">[<c:out
                                    value="${page.currentPage}"></c:out>]</font>页
                            <c:choose>
                                <c:when test="${page.totalPages==1}">
                                    &nbsp; 首页
                                </c:when>
                                <c:otherwise>
                                    <a
                                            href="<%=request.getContextPath()%>/system/selectCodeActiveByPage.do?currentpage=1&userName=${userName}&activeCode=${activeCode}">&nbsp;&nbsp;
                                        首页</a>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${page.hasPrePage}">
                                <a
                                        href="<%=request.getContextPath()%>/system/selectCodeActiveByPage.do?currentpage=${page.currentPage-1 }&userName=${userName}&activeCode=${activeCode}">上一页</a>
                            </c:if>
                            <c:forEach begin="${page.currentPageStart}"
                                       end="${page.currentPageEnd}" var="count">

                                <c:if test="${count<=page.totalPages}">
									<span>
                                   <c:choose>
                                       <c:when test="${count>page.currentPageStart && count<((page.currentPageStart+currentpage)/2)+1 && currentpage>((page.currentPageStart+page.currentPageEnd)/2)}">
                                           <span style="font-size: 20px;">.</span>
                                       </c:when>
                                       <c:otherwise>
                                          <a href="<%=request.getContextPath()%>/system/selectCodeActiveByPage.do?currentpage=${count}&userName=${userName}&activeCode=${activeCode}"
                                             id="ACountId"><span>${count}</span> </a>
                                       </c:otherwise>
                                   </c:choose>

                                 
								
								</span>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page.hasNextPage}">
                                <a
                                        href="<%=request.getContextPath()%>/system/selectCodeActiveByPage.do?currentpage=${page.currentPage+1 }&userName=${userName}&activeCode=${activeCode}">下一页</a>
                            </c:if>
                            <c:choose>
                                <c:when test="${page.totalPages==1}">最后一页<br>

                                </c:when>
                                <c:otherwise>
                                    <a
                                            href="<%=request.getContextPath()%>/system/selectCodeActiveByPage.do?currentpage=${page.totalPages}&userName=${userName}&activeCode=${activeCode}">最后一页</a><br>

                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                </c:when>
                <c:otherwise>
                    <td colspan="3" style="text-align: center;">没有相应的记录</td>
                </c:otherwise>
            </c:choose>


        </table>
    </form>
</div>
</body>
</html>
