<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
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
    <script type="text/javascript">
        function isAddSucessful() {
            var addCodeType = '${param.addCodeType}';
            if (addCodeType != 1) {
                var isAdd = '${isAdd}';
                if (isAdd == 'yes') {
                    alert("添加成功");
                } else {
                    alert("添加不成功,查看是否存在用户名是否存在或者该用户已经有商家激活码");

                }
            }
        }

        function checkActiveCode() {
            var codeActive = document.getElementById("codeActive").value;
            var confirmCodeActive = document.getElementById("confirmCodeActive").value;
            if (codeActive != confirmCodeActive) {
                alert("输入激活码与确定的激活码不一致,请重新输入");
                document.getElementById("codeActive").value = '';
                document.getElementById("confirmCodeActive").value = '';
                return false;

            }
            return true;
        }
    </script>
</head>

<body onload="isAddSucessful()">
<div id="content">
    <form action="<%=path %>/system/addCodeActive.do" onsubmit="return checkActiveCode()">
        <table class="myshop">
            <tr style="line-height:21px;">
                <td colspan="3"><a href="../../../../index.html" target="_parent">首页</a><span>>></span><a
                        href="../../../manager_index.html" target="_parent">后台管理</a><span>>></span>添加商家激活码
                </td>
            </tr>


            <tr>

                <td style="text-align:center;">
                    用户名
                </td>
                <td style="text-align:center; ">
                    <input type="text" style="width:120px;" name="userName"/>
                </td>

            </tr>


            <tr>

                <td style="text-align:center;">
                    输入激活码
                </td>
                <td style="text-align:center; ">
                    <input type="password" style="width:120px;" name="codeActive" id="codeActive"/>
                </td>

            </tr>
            <tr>

                <td style="text-align:center;">
                    确认激活码
                </td>
                <td style="text-align:center;">
                    <input type="password" style="width:120px;" id="confirmCodeActive"/>
                </td>

            </tr>


            <tr>


                <td style="text-align:center;" colspan="2">
                    <input type="submit" value="添加激活码"/> <input type="reset" value="重置"/>

                </td>

            </tr>

        </table>
    </form>
</div>
</body>
</html>
