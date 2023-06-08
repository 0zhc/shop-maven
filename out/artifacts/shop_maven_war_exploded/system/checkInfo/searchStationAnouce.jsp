<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
	<script src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/js/Calendar3.js" type="text/javascript"></script>
<link  href="<%=request.getContextPath()%>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=request.getContextPath()%>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">

function checkStartDate(){
	var time = document.getElementById("startTime").value;
	if(time == "" || time == null){
			alert("请先选择起始日期!");
			annouceForm.startTime.focus();
			return false;
		}else{
			return true;
			}
}
function checkDate() {
	var startTime = document.getElementById("startTime").value;
	var endTime = document.getElementById("endTime").value;
	if(startTime !="" && endTime==""){
			alert("请选择结束日期!")
			annouceForm.endTime.focus();
			return false;
		}
	if(endTime < startTime){
			alert("结束日期不能小于起始日期");
			annouceForm.endTime.value="";
			return false;
	}
	if(endTime !=""){
		return checkStartDate();

	}
	return true;
	
}
function isSubmit(){
	return checkDate();
}



</script>
</head>

<body>
<div  id="content">
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">站内公告</a></div>
      <form action="<%=request.getContextPath() %>/stationAnnouce/searchTimeSendStationAnnouces.do" method="post" name="annouceForm" onsubmit="return isSubmit()">
        <table  class="myshop">
          <tr >      
               <td style="text-align:center;font-size:15px;"  colspan="5">公告时间：
               <input type="text" name="startTime" readonly="readonly"
								onclick="WdatePicker()" />
							——
							<input type="text" name="endTime" readonly="readonly"
								onclick="WdatePicker()"  onfocus="checkStartDate()"/>
                <input type="submit" value="搜索" onfocus="checkDate()"  />
                </td>
          </tr>
          <c:if test="${page.num!=0}">
		  <tr>
			  <td style="text-align:center;font-size:15px;" >公告标题</td>
			  <td style="text-align:center;font-size:15px;" >公告人</td>
		    <td style="text-align:center;font-size:15px;" >公告时间</td>
            <td style="text-align:center;font-size:15px;" >操作</td>	
		  </tr>
       	  <c:forEach items="${stationAnnouce}" var="stationAnnouce" varStatus="status">
		   <tr >            
			<td style="text-align:center;">${stationAnnouce.title }</td>
			<td  style="text-align:center;">${stationAnnouce.user.callName }</td>
			<td  style="text-align:center;">${stationAnnouce.inTime }</td>
            <td style="text-align:center;"><a href="<%=request.getContextPath() %>/stationAnnouce/selectSendStationAnnouce.do?id=${stationAnnouce.id} ">查看</a>
            </td>
          </tr>
          </c:forEach>
		<tr>
			<td colspan="4" align="center">
				共${page.total}条记录 |
				<c:if test="${!page.hasPrePage}"> 首页  | 上一页 |</c:if>
				<c:if test="${page.hasPrePage}">
			<a href="<%=request.getContextPath()%>/stationAnnouce/searchSendStationAnnouces.do?page=1">首页</a> | 
			<a href="<%=request.getContextPath()%>/stationAnnouce/searchSendStationAnnouces.do?page=${page.currentPage-1 }">上一页</a> |
			</c:if>
			<c:if test="${!page.hasNextPage}">下一页  | 尾页  | </c:if>
			<c:if test="${page.hasNextPage}">
			<a href="<%=request.getContextPath()%>/stationAnnouce/searchSendStationAnnouces.do?page=${page.currentPage+1 }">下一页</a> | 
			<a href="<%=request.getContextPath()%>/stationAnnouce/searchSendStationAnnouces.do?page=${page.num }">尾页</a> | 
			</c:if>
				当前第${page.currentPage }页 | 共${page.num }页

			</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="5" align="center" height="50" valign="middle">
					<c:if test="${page.num==0}">记录为空！</c:if>
				</td>
			</tr>
		
        </table>
      </form>
</div>
</body>
</html>
