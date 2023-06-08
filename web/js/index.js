script.onload = function () {
    // AJAX请求
    var chartDate = [];
    var chartDateForm = [];
    $.ajax({
        type: "POST",
        url: "<%=request.getContextPath()%>/admin/sexCount.do",
        // dataType:"json",
        error: function (data) {
            alert(data);
            alert("出错了！");
        },
        success: function (data) {
            alert(data)
            var jsonData = JSON.parse(data);
            for (var i = 0; i < jsonData.data.length; i++) {
                chartDate.push({
                    value: jsonData.data[i].value,
                    name: jsonData.data[i].name
                })
            }

            // ECharts绘制饼图
            (function () {
                // 1. 实例化对象
                var myChart = echarts.init(document.querySelector(".pie"));
                // 2. 指定配置项和数据
                var option = {
                    tooltip: {
                        trigger: "item",
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    // 注意颜色写的位置
                    series: [
                        {
                            name: "点位统计",
                            type: "pie",
                            // 如果radius是百分比则必须加引号
                            radius: ["10%", "70%"],
                            center: ["50%", "50%"],
                            roseType: "radius",
                            data: chartDate,
                            // 修饰饼形图文字相关的样式 label对象
                            label: {
                                fontSize: 10
                            },
                            // 修饰引导线样式
                            labelLine: {
                                // 连接到图形的线长度
                                length: 6,
                                // 连接到文字的线长度
                                length2: 8
                            }
                        }
                    ]
                };

                // 3. 配置项和数据给我们的实例化对象
                myChart.setOption(option);
                // 4. 当我们浏览器缩放的时候，图表也等比例缩放
                window.addEventListener("resize", function () {
                    // 让我们的图表调用 resize这个方法
                    myChart.resize();
                });
            })();
        }
    });
}