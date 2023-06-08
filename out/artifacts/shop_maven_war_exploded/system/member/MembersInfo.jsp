<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<link  href="<%=path %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
     function isDelete(){
         var isDelete='${isDelete}';
         if(isDelete!=''){
            if(isDelete=='yes'){
               alert(删除成功);
            }
            else{
               alert(删除失败);
            }
         }
      }
</script>
</head>

<body onload="isDelete()">
<div  id="content">
      <form action="<%=path %>/system/findAllUsersByPage.do" method="post">
        <table  class="myshop">
			<tr style="background-image:url(../images/sysytem/tableTip.jpg); background-repeat:no-repeat; line-height:21px;">
				<td colspan="5" ><a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">会员信息管理</a></td>
			</tr>
			<tr >
				<td style="text-align:center; font-size:15px; height:30px;" colspan="5">
				用户名：<input type="text" name="userName"/>&nbsp;&nbsp;
				注册时间：<input type="text" name="beginDate" readonly="readonly" style="width: 80px;" onClick="WdatePicker()"/>&nbsp;——&nbsp;
						<input type="text" name="endDate" readonly="readonly" style="width: 80px;"  onClick="WdatePicker()"/>&nbsp;&nbsp;
						<input type="submit" style="width: 50px;" value="搜索" /></td>
			</tr>
         
			<tr>
				<td style="text-align:center;font-size:15px;" >会员账号</td>
				<td style="text-align:center;font-size:15px;" >会员昵称</td>
				<td style="text-align:center;font-size:15px;" >注册时间</td>
                <td style="text-align:center;font-size:15px;" >是否有效</td>
                <td style="text-align:center;font-size:15px;" >操作</td>				
			</tr>
            <!-- 进行分页遍历 -->
         <c:choose>
             <c:when test="${! empty users }">
              <c:forEach  items="${users}" var="user" >
 
             <tr >            
	               <td  style="text-align:center; font-size:15px;">
                           ${user.userName }                           
                   </td>
			       <td  style="text-align:center; font-size:15px;">
                           ${user.callName }
                   </td>

			    
                    <td  style="text-align:center; font-size:15px;">
                       
                             ${user.createDateStr }
                   </td>
                     
                     <td style="text-align:center;font-size:15px;" >
                           <c:choose>
                               <c:when test="${user.tag==1}">有效</c:when>
                               <c:when test="${user.tag==2}">无效</c:when>
                               <c:otherwise>
                                                                                          未知
                               </c:otherwise>
                           </c:choose>
                      </td>
                   	<td style="text-align:center;"><a href="<%=path %>/system/detail/MemberManageDetail.do?id=${user.id }" target="mainContent">详细</a>&nbsp;&nbsp;<a href="<%=path %>/system/detail/MemberManageDelete.do?id=${user.id }&beginDate=${beginDate}&endDate=${endDate}&userName=${userName}" >删除</a></td>
           
               </tr>
                </c:forEach>
                                       <tr align="center">
						<td colspan="5">共${page.totalRecords}条记录 &nbsp;&nbsp;共
							<span style="color: red"><c:out
									value="[${page.totalPages}]"></c:out> </span>页 &nbsp;&nbsp; 当前
							<font color="red" style="font-size: 18px;">[<c:out
									value="${page.currentPage}"></c:out>]</font>页
							<c:choose>
								<c:when test="${page.totalPages==1}"> 
                        &nbsp; 首页 
          </c:when>
								<c:otherwise>
									<a
										href="<%=request.getContextPath()%>/system/findAllUsersByPage.do?currentpage=1&userName=${userName}&beginDate=${beginDate}&endDate=${endDate}">&nbsp;&nbsp; 首页</a>
								</c:otherwise>
							</c:choose>

							<c:if test="${page.hasPrePage}">
								<a
									href="<%=request.getContextPath()%>/system/findAllUsersByPage.do?currentpage=${page.currentPage-1 }&userName=${userName}&beginDate=${beginDate}&endDate=${endDate}">上一页</a>
							</c:if>
							<c:forEach begin="${page.currentPageStart}"
								end="${page.currentPageEnd}" var="count">

								<c:if test="${count<=page.totalPages}">
									<span>
                                   <c:choose>
                                      <c:when test="${count>page.currentPageStart && count<((page.currentPageStart+currentpage)/2)+1 && currentpage>((page.currentPageStart+page.currentPageEnd)/2)}">
                                       <span style="font-size: 20px;">.</span>
                                      </c:when>
                                       <c:otherwise>
                                          <a href="<%=request.getContextPath()%>/system/findAllUsersByPage.do?currentpage=${count}&userName=${userName}&beginDate=${beginDate}&endDate=${endDate}"
										id="ACountId"><span>${count}</span> </a>
                                       </c:otherwise>
                                   </c:choose>

                                 
								
								</span>
                                </c:if>
							</c:forEach>
							<c:if test="${page.hasNextPage}">
								<a
									href="<%=request.getContextPath()%>/system/findAllUsersByPage.do?currentpage=${page.currentPage+1 }&userName=${userName}&beginDate=${beginDate}&endDate=${endDate}">下一页</a>
							</c:if>
							<c:choose>
								<c:when test="${page.totalPages==1}">最后一页<br/> 
                       
          </c:when>
								<c:otherwise>
									<a
										href="<%=request.getContextPath()%>/system/findAllUsersByPage.do?currentpage=${page.totalPages}&userName=${userName}&beginDate=${beginDate}&endDate=${endDate}">最后一页</a><br/>
									
								</c:otherwise>
							</c:choose>
						</td>
					</tr>

             </c:when>
             <c:otherwise>
                  <td colspan="5" style="text-align: center;">没有相应的记录</td>
             </c:otherwise>
         </c:choose>
           



		

          
		  
		   
         
        </table>
      </form>
</div>
</body>
</html>
