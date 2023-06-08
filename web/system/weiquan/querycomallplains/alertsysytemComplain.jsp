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
                KE.event.add(KE.$('complaintAlert'), 'submit', function () {
                    KE.sync(id);
                });
            }
        });
        KE.show({
            id: 'content1',
            afterChange: function (id) {
                var count = 500 - KE.count(id, 'text');
                document.getElementById("wordId").value = KE.count(id, 'text');
                if (count < 0) {
                    count = -count;
                    KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>" + count + "</font>字";
                } else {
                    KE.$('word_count').innerHTML = "您还可以输入" + count + "字";
                }
            }
        });

        function isSubmit() {
            var title = document.getElementById("title").value;
            if (title == "" || title == null) {
                alert("请填写警告标题！");
                return false;
            }
            if (title.length > 30) {
                alert("警告标题不能超过30个字！");
                return false;
            }
            if (KE.isEmpty('content1')) {
                alert("请填写警告内容！");
                return false;
            }
            if (KE.count('content1', 'text') > 500) {
                alert("警告内容不能超过500字!");
                return false;
            }
            return true;
        }


    </script>
</head>

<body>
<div id="content">
    <div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">警告商家</a>
    </div>
    <form action="<%=request.getContextPath() %>/complaint/addComplaintAlert.do" method="post" id="complaintAlert"
          onsubmit="return isSubmit()">
        <input type="hidden" name="token" value="<%=session.getAttribute("TOKEN")%>" id="TOKEN"/>
        <table border="0" cellspacing="0" class="myshop">
            <tr>
                <td colspan="8" style="text-align:center; font-size:15px; height:30px;">

                    <table width="100%" border="0" cellspacing="0">
                        <tr>
                            <td width="13%" align="center">警告对象</td>
                            <td width="87%" align="left"><span
                                    style="text-align:center;">${complaint.user.shop.name }</span>
                                <input type="hidden" name="complaintId" value="${complaint.id }">
                                <input type="hidden" name="userId" value="${complaint.user.id }"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">警告标题</td>
                            <td align="left"><input type="text" style="width: 450px" name="title" id="title"/>(限制30字以内)
                            </td>
                        </tr>
                        <tr>
                            <td align="center">警告内容</td>
                            <td><textarea name="alertContent" cols="21" rows="18" id="content1"
                                          style="width:100%"></textarea>
                                <span id="word_count"></span> <input name="word" id="wordId" type="hidden" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><input type="submit" value="提交"/>
                                <input name="reset" type="reset" value="重置"/></td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>
