<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>JVM</title>
</head>
<body>
<%
    double total = (Runtime.getRuntime().totalMemory()) / (1024.0 * 1024);
    double free = (Runtime.getRuntime().freeMemory()) / (1024.0 * 1024);
    double max = (Runtime.getRuntime().maxMemory()) / (1024.0 * 1024);
    out.println("可用: " + (max - total + free) + "M");
    out.println("    JVM最大内存: " + max + "M");
    out.println("    JVM使用内存:" + total + "M");
%>
<script language="JavaScript">
    var countDownInterval = 1;
    var c_reloadwidth = 200
</script>
<ilayer id="c_reload" width=&{c_reloadwidth};>
    <layer id="c_reload2" width=&{c_reloadwidth}; left=0 top=0></layer>
</ilayer>
<script>
    var countDownTime = countDownInterval + 1;

    function countDown() {
        countDownTime--;
        if (countDownTime <= 0) {
            countDownTime = countDownInterval;
            clearTimeout(counter)
            window.location.reload()
            return
        }
        if (document.all) //if IE 4+
            document.all.countDownText.innerText = countDownTime + " ";
        else if (document.getElementById) //else if NS6+
            document.getElementById("countDownText").innerHTML = countDownTime + " "
        else if (document.layers) {
            document.c_reload.document.c_reload2.document.write('Next <a href="javascript:window.location.reload()">refresh</a> in <b id="countDownText">' + countDownTime + ' </b> seconds')
            document.c_reload.document.c_reload2.document.close()
        }
        counter = setTimeout("countDown()", 100);
    }

    function startit() {
        if (document.all || document.getElementById)
            document.write('<b id="countDownText"></b>')
        countDown()
    }

    if (document.all || document.getElementById)
        startit()
    else
        window.onload = startit

</script>
</body>
</html>
