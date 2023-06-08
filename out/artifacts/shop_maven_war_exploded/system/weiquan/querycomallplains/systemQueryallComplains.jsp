<%@ page language="java" import="java.util.*,com.shop.entity.*"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<link  href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />

</head>

<body>
<div  id="content">
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">查看所有投诉结果</a></div>
      <form action="#">
        <table border="0" cellspacing="0"  class="myshop">
        <c:if test="${page.num!=0}">
          <tr>
			  <td style="text-align:center;font-size:15px;" >投诉人</td>	
              <td style="text-align:center;font-size:15px;" >投诉原因</td>
              <td  style="text-align:center;font-size:15px;" >投诉时间</td>	
              <td  style="text-align:center;font-size:15px;" >被投诉人</td>	
              <td style="text-align:center;font-size:15px;" >管理员回复</td>
              <td  style="text-align:center;font-size:15px;" >操作</td>				
			</tr>
		<c:forEach items="${complaints}" var="complaints" varStatus="status">
           	  <tr >
            <td style="text-align:center;font-size:15px;">${complaints.complaint.callName }</td> 
            <td style="text-align:center;font-size:15px;">${complaints.complain }</td>
            <td style="text-align:center;font-size:15px;">${complaints.complaintTime }</td>
              <td  style="text-align:center;font-size:15px;" >${complaints.user.shop.name }</td>
            <c:if test="${complaints.adminReply==1 }">
            <td style="text-align:center;font-size:15px;">暂无回复</td>
            </c:if>
            <c:if test="${complaints.adminReply==2 ||complaints.adminReply==3 }">
            <td style="text-align:center;font-size:15px;">已回复</td>
            </c:if>
            <td style="text-align:center;font-size:15px;"><a href="<%=request.getContextPath()%>/complaint/selectSystemComplaint.do?tradeId=${complaints.tradeRecord.id}">查看</a>
            <c:if test="${complaints.alertType==1}">
            <a href="<%=request.getContextPath()%>/complaint/getComplaintAlert.do?complaintId=${complaints.id }">发出警告</a>
            </c:if>
            <c:if test="${complaints.alertType!=1}">
        	    已警告
            </c:if>
            </td>
          </tr>
          </c:forEach>
           <tr>
			<td colspan="6" align="center">
			共${page.total}条记录 |  
			<c:if test="${!page.hasPrePage}"> 首页  | 上一页 |</c:if>
			<c:if test="${page.hasPrePage}">
			<a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=1">首页</a> | 
			<a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=${page.currentPage-1 }">上一页</a> |
			</c:if>
			<c:if test="${!page.hasNextPage}">下一页  | 尾页  | </c:if>
			<c:if test="${page.hasNextPage}">
			<a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=${page.currentPage+1 }">下一页</a> | 
			<a href="<%=request.getContextPath()%>/tradeRecord/searchTradProducts.do?page=${page.num }">尾页</a> | 
			</c:if>
			 当前第${page.currentPage }页   | 共${page.num }页
			 
			</td> 
		</tr>
		</c:if>
		<tr>
			<td colspan="8" align="center" height="50" valign="middle">
				<c:if test="${page.num==0}">记录为空！</c:if>
			</td>
			</tr>
        </table>
  </form>
</div>
</body>
</html>
