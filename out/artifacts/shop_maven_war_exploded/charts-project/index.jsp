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
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>数据可视化项目</title>
    <link rel="stylesheet" href="fonts/icomoon.css" />
    <link rel="stylesheet" href="css/index.css" />
    <script>
      var contextPath = '<%= request.getContextPath() %>';
    </script>
    <script src="js/jquery.min.js"></script>
    <script src="js/echarts.min.js"></script>
    <script src="js/flexible.js"></script>




  </head>

  <body>
<h3 style="position: absolute; top: 522px; left: 1336px; z-index: 999; font-weight:400; color: #fff">商品类别分布</h3>
    <!-- 父容器大盒子 -->
    <div class="viewport">
      <div class="column">
        <!-- 概览区域模块制作 -->
        <div class="panel overview">
          <div class="inner">
            <ul>
              <li>
                <h4 id="userTotal"></h4>
                <span>
                  <i class="icon-dot" style="color: #006cff"></i>
                  用户总数
                </span>
              </li>
              <li class="item">
                <h4 id="sellNum"></h4>
                <span>
                  <i class="icon-dot" style="color: #6acca3"></i>
                  卖家总数
                </span>
              </li>
              <li>
                <h4 id="buyNum"></h4>
                <span>
                  <i class="icon-dot" style="color: #6acca3"></i>
                  买家总数
                </span>
              </li>
              <li>
                <h4 id="errorNum"></h4>
                <span>
                  <i class="icon-dot" style="color: #ed3f35"></i>
                  异常用户
                </span>
              </li>
            </ul>
          </div>
        </div>
        <!-- 监控区域模块制作 -->
        <div class="panel monitor">
          <div class="inner">
            <div class="tabs">
              <a href="javascript:;" class="active">顾客投诉信息</a>
              <a href="javascript:;">管理员警告信息</a>
            </div>
            <div class="content" style="display: block;">
              <div class="head">
                <span class="col">投诉时间</span>
                <span class="col">投诉标题</span>
                <span class="col">是否查看</span>
              </div>
              <div class="marquee-view">
                <div class="marquee" id="Complaint"></div>
              </div>
            </div>
            <div class="content">
              <div class="head">
                <span class="col">警告时间</span>
                <span class="col">警告标题</span>
                <span class="col">是否查看</span>
              </div>
              <div class="marquee-view">
                <div class="marquee" id="ComplaintAlert">
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- 点位分布统计模块制作 -->
        <div class="point panel">
          <div class="inner">
            <h3>男女比例</h3>
            <div class="chart">
              <div class="pie"></div>
              <div class="data">
                <div class="item">
                  <h4 id="girlNum"></h4>
                  <span>
                    <i class="icon-dot" style="color: #ed3f35"></i>
                    女性总数
                  </span>
                </div>
                <div class="item">
                  <h4 id="boyNum"></h4>
                  <span>
                    <i class="icon-dot" style="color: #eacf19"></i>
                    男性总数
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="column">
        <!-- 地图模块 -->
        <div class="map">
          <h3>
            <span class="icon-cube"></span>
            用户群体分布统计
          </h3>
          <div class="chart">
            <div class="geo"></div>
          </div>
        </div>
        <!-- 用户统计模块 -->
        <div class="users panel">
          <div class="inner">
            <h3>用户年龄分布</h3>
            <div class="chart">
              <div class="bar"></div>
              <div class="data">
                <div class="item">
                  <h4 id="userNum">16</h4>
                  <span>
                    <i class="icon-dot" style="color: #ed3f35"></i>
                    用户总量
                  </span>
                </div>
                <div class="item">
                  <h4 id="newUser">4</h4>
                  <span>
                    <i class="icon-dot" style="color: #eacf19"></i>
                    本月新增
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="column">
        <!-- 订单 -->
        <div class="order panel">
          <div class="inner">
            <!-- 筛选 -->
            <div class="filter">
              <a href="javascript:;" class="active">365天</a>
              <a href="javascript:;">90天</a>
              <a href="javascript:;">30天</a>
              <a href="javascript:;">24小时</a>
            </div>
            <!-- 数据 -->
            <div class="data">
              <div class="item">
                <h4 id="orderCount"></h4>
                <span>
                  <i class="icon-dot" style="color: #ed3f35;"></i>
                  订单量
                </span>
              </div>
              <div class="item">
                <h4 id="salesAmount"></h4>
                <span>
                  <i class="icon-dot" style="color: #eacf19;"></i>
                  销售额(元)
                </span>
              </div>
            </div>
          </div>
        </div>
        <!-- 销售额 -->
        <div class="sales panel">
          <div class="inner">
            <div class="caption">
              <h3>销售额统计</h3>
              <a href="javascript:;" class="active" data-type="year">年</a>
              <a href="javascript:;" data-type="quarter">季</a>
              <a href="javascript:;" data-type="month">月</a>
              <a href="javascript:;" data-type="week">周</a>
            </div>
            <div class="chart">
              <div class="label">单位:元</div>
              <div class="line"></div>
            </div>
          </div>
        </div>
        <!-- 渠道分布以及季度销售模块 -->
        <div class="wrap">
          <div class="channel panel">
            <div class="inner">
              <h3>用户群体分布</h3>
              <div class="data">
                <div class="radar"></div>
              </div>
            </div>
          </div>
          <!-- 销售进度模块 -->
          <div class="quarter panel">
            <div class="inner" id="goodsType" style="width: 198px">

            </div>
          </div>
        </div>

        <!-- 全国热榜模块制作 -->
        <div class="top panel">
          <div class="inner">
            <div class="all">
              <h3>店铺热榜</h3>
              <ul>
                <li>
                  <i class="icon-cup1" style="color: #d93f36;"></i>
                  8号当铺
                </li>
                <li>
                  <i class="icon-cup2" style="color: #68d8fe;"></i>
                  DIY
                </li>
                <li>
                  <i class="icon-cup3" style="color: #4c9bfd;"></i>
                  90食
                </li>
              </ul>
            </div>
            <div class="province">
              <h3>地区热销 <i class="date">// 近30日 //</i></h3>
              <div class="data">
                <ul class="sup">
                  <!-- <li>
                    <span>北京</span>
                    <span>25,179 <s class="icon-up"></s></span>
                  </li>
                  <li>
                    <span>河北</span>
                    <span>23,252 <s class="icon-down"></s></span>
                  </li> -->
                </ul>
                <ul class="sub">
                  <!-- <li><span></span><span> <s class="icon-up"></s></span></li> -->
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="js/index.js"></script>
    <!-- 想使用中国地图必须先引用这个china.js文件 -->
    <script src="js/china.js"></script>
    <!-- 引入我们自己的地图js文件 -->
    <script src="js/myMap.js"></script>
    <script type="text/javascript">
      window.onload = function (){
        // 获取数据
        $.ajax({
          type:"POST",
          url:"<%=request.getContextPath()%>/searchComplaintData.do",
          success: function(data) {
            // alert(data[0]);
            // alert(JSON.stringify(data[0]))
            console.log(typeof data)
            // dataObject = JSON.parse(data);
            dataObject = data;

            // 迭代数据并输出
            dataObject.forEach(function(item) {
              var row = document.createElement('div');
              row.classList.add('row');

              var dateCol = document.createElement('span');
              dateCol.classList.add('col');
              dateCol.innerText = item.complaintTime;

              var addressCol = document.createElement('span');
              addressCol.classList.add('col');
              addressCol.innerText = item.complain;

              var idCol = document.createElement('span');
              idCol.classList.add('col');
              var isErad = '';
              if (item.alertType==1){
                isRead='否'
              }else {
                isRead='是'
              }
              // var isRead = item.alertType
              idCol.innerText = isRead;

              var dotIcon = document.createElement('span');
              dotIcon.classList.add('icon-dot');

              row.appendChild(dateCol);
              row.appendChild(addressCol);
              row.appendChild(idCol);
              row.appendChild(dotIcon);

              document.getElementById('Complaint').appendChild(row);
            });
          },
          error: function() {
            console.log('Failed to retrieve data.');
          }
        });
      }
      // window.onload = function (){
        // 获取数据
        $.ajax({
          type:"POST",
          url:"<%=request.getContextPath()%>/searchComplaintAlertData.do",
          success: function(data) {
            // alert(data[0]);
            // alert(JSON.stringify(data[0]))
            // console.log(typeof data)
            // dataObject = JSON.parse(data);
            dataObject = data;
            // 迭代数据并输出
            dataObject.forEach(function(item) {
              var row = document.createElement('div');
              row.classList.add('row');

              var dateCol = document.createElement('span');
              dateCol.classList.add('col');
              dateCol.innerText = item.alertTime;

              var addressCol = document.createElement('span');
              addressCol.classList.add('col');
              addressCol.innerText = item.title;

              var idCol = document.createElement('span');
              idCol.classList.add('col');
              // var isErad = '';
              // if (item.alertType==1){
              //   isRead='否'
              // }else {
              //   isRead='是'
              // }
              // var isRead = item.alertType
              idCol.innerText = '是';

              var dotIcon = document.createElement('span');
              dotIcon.classList.add('icon-dot');

              row.appendChild(dateCol);
              row.appendChild(addressCol);
              row.appendChild(idCol);
              row.appendChild(dotIcon);

              document.getElementById('ComplaintAlert').appendChild(row);
            });
          },
          error: function() {
            console.log('Failed to retrieve data.');
          }
        });
      // }
    </script>
    <script type="text/javascript">
      $(document).ready(function(){
        $.ajax({
          url: "<%=request.getContextPath()%>/searchSellData.do",
          dataType: "json",
          success: function(data){
            // alert(data.orderCount)
            $("#orderCount").text(data.orderCount);
            $("#salesAmount").text(data.salesAmount);
            // document.getElementById("orderCount").innerText("20")
            // // document.getElementById("orderCount").innerText(20);
            // document.getElementById("#salesAmount").innerText(data.salesAmount);
          }
        });
      });
    </script>
<script type="text/javascript">
  $(document).ready(function(){
    $.ajax({
      url: "<%=request.getContextPath()%>/shopSexData.do",
      dataType: "json",
      success: function(data){
        // alert(data.orderCount)
        $("#boyNum").text(data.Boy);
        $("#girlNum").text(data.Girl);
      }
    });
  });
</script>
<script type="text/javascript">
  $(document).ready(function(){
    $.ajax({
      url: "<%=request.getContextPath()%>/userData.do",
      dataType: "json",
      success: function(data){
        // alert(data.orderCount)
        $("#userTotal").text(data.userNum);
        $("#userNum").text(data.userNum);
        $("#sellNum").text(data.sellNum);
        $("#buyNum").text(data.buyNum);
        $("#errorNum").text(data.errorNum);
        $("#newUser").text(data.newUser);

      }
    });
  });
</script>
  </body>

</html>
