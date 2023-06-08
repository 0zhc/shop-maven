<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title></title>

    <script type="text/javascript">

        function remove_loading() {

            var targelem = document.getElementById('loader_container');
            targelem.style.display = 'none';
            targelem.style.visibility = 'hidden';
        }

        function ShowSecurity(path) {

            window.parent.ShowSecurity(path);
        }
    </script>

    <style type="text/css">
        * {
            padding: 0px;
            margin: 0px;
        }
    </style>

</head>
<body onload="remove_loading()">
<iframe src="<%=request.getContextPath()%>/findSecureByUserId.do?userId=${param.userId }&isModify=${param.isModify }&template=${param.template}"
        width="100%" marginwidth="0" height="100%" marginheight="0" frameborder="0"></iframe>
<div id="loader_container" style="text-align: center; position: absolute; left: 300px; top: 100px;"><img
        src="<%=request.getContextPath()%>/system/shop/myshop/loading.gif"/></div>
</body>
</html>
