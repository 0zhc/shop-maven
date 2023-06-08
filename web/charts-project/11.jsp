<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="utf-8" %>
<%@ page import="com.shop.entity.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%--    <script src="js/china.js"></script>--%>
    <!-- 引入我们自己的地图js文件 -->
    <%--    <script src="js/myMap.js"></script>--%>
    <script src="js/echarts.min.js"></script>
    <%--    <script src="js/flexible.js"></script>--%>
    <script src="../js/jquery-1.2.6.min.js"></script>


</head>
<body>
<div id='test' style="width: 200px;height: 200px;color: pink"></div>
</body>
<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('test'));
    var chartDate = [];
    var chartDateForm = [];

    // var data={};
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/admin/EChartsTest.do",
        // dataType:"json",
        error: function (data) {
            alert(data);
            alert("出错了！");
        },
        success: function (data) {

            alert(data)
            var jsonData = JSON.parse(data);
            // chartDate = jsonData;
            // console.log(typeof chartDate)

            // alert(jsonData.data);
            // alert(JSON.stringify(jsonData.data))
            // var jsonDataa = JSON.parse(aa);
            // console.log(typeof aa)
            // alert(jsonData)

            for (var i = 0; i < jsonData.data.length; i++) {
                chartDate.push({
                    value: jsonData.data[i].value,
                    name: jsonData.data[i].name
                });
                alert(JSON.stringify(chartDate[i]))
                alert(chartDate[i].value)

                // alert(chartDate[i])

                // alert(chartDate)
                // alert(jsonData[i])
            }
            alert(JSON.stringify(chartDate))
            option = {
                title: {
                    text: 'Referer of a Website',
                    subtext: 'Fake Data',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'right'
                },
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data: chartDate,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option);
            // alert(chartDate)
        },


    })

</script>
</html>
