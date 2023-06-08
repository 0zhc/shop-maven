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
<script type="text/javascript" src="<%=path %>/js/jquery-1.2.6.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#add').click(function(){
			
		});
	});
	
	function isShow(){
	      var shopId='${user.shop.id}';
	      var isShow=$("input[name='isShow']:checked").val();
	     
	     
	      var setType="new";//hot 为最新
                $.ajax({
             type: "post",
             url: "<%=request.getContextPath()%>/shop/modifyIsShow.do?"+escape(new Date()),
             data:{'shopId':shopId,'isShow':isShow,'setType':setType},
             dataType: "html",//(可以不写,默认)
             beforeSend: function(XMLHttpRequest){
                     $("#loading").show();
              },
              success: function(data, textStatus){
               
                if(data=='ok'){
                       $("#loading").hide();
                       $("#tip").text("修改成功,请在后台修改");
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
<style type="text/css"> 

table td {
	border-right: 1px solid #CCC;
	border-bottom: 1px solid #CCC;
}
table {
	border-top: 1px solid #CCC;
	border-left: 1px solid #CCC;
}
table th { background-color:#CCC;
border-right: 1px solid #999;
	border-bottom: 1px solid #999;
}
a { color:blue; text-decoration:none;}
a:hover {top:1px; left:1px; position:relative;} 

input{ 
	
	 border: 1px solid #888;
}

</style>

<title>最热商品</title>
</head>

<body style="background-color:#fafafa">
<div  id="content" style="height:1000px; width:950px;margin-left: 25px; margin-right: 25px;">
<fieldset style="width:950px">
<legend >查询设置最新商品</legend>
<div style="position: absolute;left: 300px; top:20px;"><img src="<%=path %>/images/load/loading.gif" id="loading" style="display: none;" / ></div>
<div style="text-align: right;padding-right: 30px; font-size: 13px;"><span id="tip" style="margin-right: 100px;"></span><span>店铺是否显示该模块：</span>显示<input type="radio" name="isShow" checked="checked" value="1"></input>&nbsp;&nbsp;不显示<input type="radio" name="isShow" value="2"  style="margin-right: 10px;"/><input type="button" value="修改" style="margin-right: 20px;" onclick="isShow();"/></div>
<form action="" method="post" class="regForm" id="regForm">
		
		
            	<div>你还可以添加
            	   ${4-count}
            	个最新商品</div>
                <div>
                <table border="0" cellspacing="0" width="100%">
                  <tr>				
			  		<th  align="center" width="100">商品名称</th>
			  		<th align="center" width="100">商品图片</th>
			  		<th align="center" width="75">价格</th>
                    <th align="center" width="75">数量</th>
                    <th align="center" width="75">上传日期</th>
              		<th align="center" width="150">操作</th>	 
		  		  </tr>
                    
                   <c:forEach items="${newGoods}" var="newGood">
                         <tr >     
						<td style="text-align:center;">${newGood.name }&nbsp;</td>
						<td  style="text-align:center;"><img src="<%=path %>/${newGood.url}"  width="177px" height="118px"/></td>
						<td style="text-align:center;">${newGood.price }&nbsp;</td>
                        <td style="text-align:center;">${newGood.amount }&nbsp;</td>
                        <td style="text-align:center;">${newGood.createDate }&nbsp;</td>
            			<td align="center" >                        
                        	<a href="<%=path %>/system/shop/myshop/goodsDetail.do?JspType=newDatail&goodsId=${newGood.id}" >详情</a>&nbsp; <a href="<%=path %>/system/shop/myshop/goodsDetail.do?JspType=newModifyDatail&goodsId=${newGood.id}">修改</a>&nbsp;<a href="<%=path %>/shop/rollingGoods/delete.do?goodsId=${newGood.id}&userId=${user.id}&userName=${user.userName}&shopId=${user.shop.id}&deleteType=deleteNewgoods">删除</a>
                        </td>
          		        </tr>
                   </c:forEach>
                 <c:if test="${count<4}">
                   <tr>
                	<td id="input" colspan="6"  style="text-align: center;"><a href="<%=path%>/shop/shopModify/productModify/addNewProduct.jsp">--->>>>添加</a></td>
                	
                   </tr>
                 
                 </c:if> 
               
                 <tr>
                                  <td colspan="6" style="height: 100px;font-size: 14px;text-align: center;">温馨提示：添加/修改成功后，请重新筛新一些游览器或者按 F5即可看到查看店铺装修后的效果</td>
                             </tr>
                </table>
                
            </div>
		
	</form>
	</fieldset>
</div>
</body>
</html>
