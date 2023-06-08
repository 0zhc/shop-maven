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
<title>无标题文档</title>
<link type="text/css" rel="stylesheet" href="<%=path %>/shop/shopModify/otherProduct/otherProduct.css" />
<script type="text/javascript" src="<%=path %>/js/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
     function setOterText(){
	      var shopId='${user.shop.id}';
	      var otherText=$("#otherText").val();
	     
	     
	      var setType="new";//hot 为最新
                $.ajax({
             type: "post",
             url: "<%=request.getContextPath()%>/shop/setOtherText.do?"+escape(new Date()),
             data:{'shopId':shopId,'otherText':otherText},
             dataType: "html",//(可以不写,默认)
             beforeSend: function(XMLHttpRequest){
                     $("#loading").show();
              },
              success: function(data, textStatus){
               
                if(data=='ok'){
                       $("#loading").hide();
                       $("#tip").text("修改成功");
                  }
                  else{
                  //注册失败
                     $("#tip").html('<font color="red">修改失败</font>');
                  }

                },
              complete: function(XMLHttpRequest, textStatus){
                     //HideLoading();
                    $("#loading").hide();

                },

              error: function(){

                     //请求出错处理
                 }

             }); 
         
     }


</script>
</head>

<body>

<div  id="content"  id="content" style="height:1000px; width:950px;margin-left: 25px; margin-right: 25px;">
<fieldset>
<legend>更多产品设置->查询</legend>
<div style="position: absolute;left: 300px; top:20px;"><img src="<%=path %>/images/load/loading.gif" id="loading" style="display: none;" / ></div>
<div style="text-align: right;padding-right: 30px; font-size: 13px;"><span id="tip" style="margin-right: 100px;"></span><span>设置标题：</span><input type="text" name="otherText" id="otherText" style="width: 150px;"/><input type="button" value="修改" style="margin-right: 20px;" onclick="setOterText();" /></div>
      <form action="<%=path%>/system/selectUserGoodsByPage.do?">
          <input name="jspType" value="otherGoods" type="hidden"/>
          <input name="goodsType" value="4" type="hidden"/>
        <table width="100%" border="0" cellspacing="0"  class="myshop">
         
          <tr >      
				 <td style="text-align:center; font-size:15px; height:30px;" colspan="6">商品关键字： <input type="text" name="name" /> 
                 <input type="submit" value="搜索" /> 
                  
                 </td>
          </tr>
         
		  <tr>				
			  
			  <th width="20%" align="center">商品名称</th>
			  <th width="22%" align="center">商品图片</th>
			  <th width="14%" align="center">商品价格</th>
               <th width="13%" align="center">商品数量</th>
              <th width="13%" align="center">商品发布时间</th>
              <th width="31%" align="center">操作</th>	 
		  </tr>
           <!-- 分页显示 -->
         <c:choose>
             <c:when test="${! empty goodses }">
              <c:forEach  items="${goodses}" var="goods" >
 
             <tr >            
	               <td  style="text-align:center; font-size:15px;">
                           ${goods.name }   &nbsp;                        
                   </td>
			     
                     <td  style="text-align:center; font-size:15px;">
                           <img src="<%=path %>/${goods.url}" width="177px" height="118px"/>&nbsp; 
                   </td>
                      <td  style="text-align:center; font-size:15px;">
                           ${goods.price}&nbsp; 
                   </td>
                      <td  style="text-align:center; font-size:15px;">
                           ${goods.amount}&nbsp; 
                   </td>
                   <td>${goods.createDate}&nbsp; </td>
                    <td  style="text-align:center; font-size:15px;">
                         <a href="<%=path %>/system/shop/myshop/goodsDetail.do?JspType=otherDatail&goodsId=${goods.id}">详情</a> <a href="<%=path %>/system/shop/myshop/goodsDetail.do?JspType=otherModifyDatail&goodsId=${goods.id}">&nbsp;&nbsp;修改&nbsp;&nbsp;&nbsp;&nbsp;</a><a href="<%=path %>/shop/otherGoods/delete.do?goodsId=${goods.id}&userId=${user.id}&userName=${user.userName}&shopId=${user.shop.id}&name=${name}">删除</a>
                   </td>
			       
               </tr>
                </c:forEach>
                                       <tr align="center">
						<td colspan="7">总共有
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
										href="<%=request.getContextPath()%>/system/selectUserGoodsByPage.do?jspType=otherGoods&currentpage=1&goodsType=${goodsType}&name=${name}">&nbsp;&nbsp; 首页</a>
								</c:otherwise>
							</c:choose>

							<c:if test="${page.hasPrePage}">
								<a
									href="<%=request.getContextPath()%>/system/selectUserGoodsByPage.do?jspType=otherGoods&currentpage=${page.currentPage-1 }&goodsType=${goodsType}&name=${name}">上一页</a>
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
                                          <a href="<%=request.getContextPath()%>/system/selectUserGoodsByPage.do?jspType=otherGoods&currentpage=${count}&goodsType=${goodsType}&name=${name}"
										id="ACountId"><span>${count}</span> </a>
                                       </c:otherwise>
                                   </c:choose>

                                 
								
								</span>
                                </c:if>
							</c:forEach>
							<c:if test="${page.hasNextPage}">
								<a
									href="<%=request.getContextPath()%>/system/selectUserGoodsByPage.do?jspType=otherGoods&currentpage=${page.currentPage+1 }&goodsType=${goodsType}&name=${name}">下一页</a>
							</c:if>
							<c:choose>
								<c:when test="${page.totalPages==1}">最后一页&nbsp;<br/> 
                       
          </c:when>
								<c:otherwise>
									<a
										href="<%=request.getContextPath()%>/system/selectUserGoodsByPage.do?jspType=otherGoods&currentpage=${page.totalPages}&goodsType=${goodsType}&name=${name}">&nbsp;最后一页</a><br/>
									
								</c:otherwise>
							</c:choose>
						</td>
					</tr>

             </c:when>
             <c:otherwise>
                  <td colspan="6" style="text-align: center;">没有相应的记录</td>
             </c:otherwise>
         </c:choose>  
          <tr><td colspan="6" style="text-align: center;font-size: 16px;"><a href="<%=path %>/shop/shopModify/otherProduct/add_otherProduct.jsp" style="color: blue;">--->>我要添加</a></td></tr>
           <tr>
                                  <td colspan="6" style="height: 100px;font-size: 14px;text-align: center;">温馨提示：添加/修改成功后，请重新筛新一些游览器或者按 F5即可看到查看店铺装修后的效果</td>
                             </tr>
        </table>
      </form>
  </fieldset>
</div>

</body>
</html>
