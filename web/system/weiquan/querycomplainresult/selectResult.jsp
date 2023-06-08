<%@ page language="java" import="java.util.*,com.shop.entity.*"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%org.apache.struts.util.TokenProcessor.getInstance().saveToken(request); %>--%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的店铺</title>
    <link href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="<%=request.getContextPath() %>/cjmqyeditor/kindeditor.js"></script>
    <script>
        KE.show({
            id: 'content1',
            shadowMode: false,
            autoSetDataMode: false,
            syncType: '', //auto: 每次修改时都会同步; form:提交form时同步; 空:不会自动同步;
            allowPreviewEmoticons: false,
            resizeMode: false,
            afterCreate: function (id) {
                KE.event.add(KE.$('complaint'), 'submit', function () {
                    KE.sync(id);
                });
            }
        });

        KE.show({
            id: 'content1',
            afterChange: function (id) {
                var count = 200 - KE.count(id, 'text');
                document.getElementById("wordId").value = KE.count(id, 'text');
                if (count < 0) {
                    count = -count;
                    KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>" + count + "</font>字";
                } else {
                    KE.$('word_count').innerHTML = "您还可以输入" + count + "字";
                }
            }
        });

        function check() {
            if (KE.isEmpty('content1')) {
                alert("请填写回复内容！");
                return false;
            }
            if (KE.count('content1', 'text') > 200) {
                alert("回复内容不能超过200字!");
                return false;
            }
            document.complaint.add.disabled = true;
            location.replace(this.href);
            event.returnvalue = false;
            return true;
        }
    </script>
</head>

<body>
<div id="content">
    <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">投诉商家</a>
    </div>
    <form action="<%=request.getContextPath() %>/complaint/addComplaintReply.do" id="complaint" name="complaint"
          method="post" onsubmit="return check()">
        <%--    <input type="hidden" name="TOKEN" value='<%=session.getAttribute("org.apache.struts.action.TOKEN")%>' id="TOKEN" />--%>
        <input type="hidden" name="token" value="<%=session.getAttribute("TOKEN")%>" id="TOKEN"/>
        <table border="0" cellspacing="0" class="myshop">
            <c:if test="${complaint.tag==1}">
            <tr>


                <td colspan="8" style="text-align:center; font-size:15px; height:30px;">
                    <input type="hidden" name="complaintId" value="${complaint.id }">
                    <table width="100%" border="0" cellspacing="0">
                        <tr>
                            <td width="13%" style="text-align:center;font-size:15px;">投诉对象</td>
                            <td width="38%" style="text-align:center;font-size:15px;"><span
                                    style="text-align:center;">${complaint.user.shop.name }</span></td>
                            <td width="11%" style="text-align:center;font-size:15px;">投诉时间</td>
                            <td width="38%" style="text-align:center;font-size:15px;">${complaint.complaintTime }</td>
                        </tr>
                        <tr>
                            <td align="center">投诉原因</td>
                            <td colspan="3" style="font-size:15px;">${complaint.complain }</span></td>
                        </tr>
                        <tr>
                            <td style="text-align:center;font-size:15px;">详细描述</td>
                            <td colspan="3" style="text-align:left;font-size:15px;">${complaint.detailreason }</td>
                        </tr>
                        <c:if test="${complaint.adminReply==1}">
                            <tr>
                                <td style="text-align:center;font-size:15px;">管理员回复</td>
                                <td colspan="3" style="text-align:left;font-size:15px;">暂无回复</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${complaintReply}" var="complaintReply" varStatus="status">
                            <tr>
                                <td style="text-align:center;font-size:15px;">
                                    <c:if test="${complaintReply.writer.id==user.id }">我的回复</c:if>
                                    <c:if test="${complaintReply.writer.id!=user.id }">管理员回复</c:if>
                                </td>
                                <td colspan="3" style="text-align:left;font-size:15px;">${complaintReply.replyContent }
                                    <br/>回复时间：${complaintReply.replyTime }</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td align="center">回复内容 <br/>(200字以内)</td>
                            <td colspan="3"><textarea name="replyContent" cols="21" rows="9" id="content1"
                                                      style="width:100%"></textarea>
                                <span id="word_count"></span> <input name="word" id="wordId" type="hidden" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <input type="submit" value="回复" name="add"/>
                                <input type="button" value="返回" onclick="history.back()"/></td>
                        </tr>
                        </c:if>
                        <tr>
                            <td colspan="8" align="center" height="50" valign="middle">
                                <c:if test="${complaint.tag==2}">对不起！该商品的维权信息已被您删除！<a href="javaScript:history.back()">返回</a></c:if>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>
