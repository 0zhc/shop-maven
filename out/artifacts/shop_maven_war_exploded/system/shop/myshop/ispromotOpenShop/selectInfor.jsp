<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<link href="../../../../css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link href="../../../../css/sysytem/myshop.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../../../../js/jquery-1.2.6.min.js"></script>
<script>
   $(function(){
      
   
   });
   function goshop(){
     
      if($("input[name=selectInfor][checked]").val()=='1'){
	       window.location.href="<%=request.getContextPath()%>/system/shop/prompt.do?Jsptype=selectStudent"; 
	  }else
	  if($("input[name=selectInfor][checked]").val()=='2'){
	       window.location.href="loginImformBussinesst.jsp"; 
	  }
	   
	   
   }
</script>
</head>

<body>
<div  id="content">
      <form action="">
        <table border="0" cellspacing="0"  class="myshop">
          <tr style="line-height:21px;">
            <td colspan="3" ><a href="../../../../index.html" target="_parent">首页</a><span>>></span><a href="../../../manager_index.html" target="_parent">后台管理</a><span>>></span>请选择开店身份</td>
          </tr>
         
		  <tr>				
			
			  <td align="center" colspan="2">用户类型</td>
		
		  </tr>
       	  <tr >            
			
			<td  style="text-align:center;">学生<input type="radio" checked="checked" name="selectInfor"  value="1"/></td>
		
            <td  style="text-align:center;">商家
            <input type="radio"  name="selectInfor"  value="2"/></td>
     
         
         
          </tr>
          
          <tr >            
			
			<td  style="text-align:center;" colspan="5">
                <input type="button" value="提交" onclick="goshop();" />
            </td>
			
          </tr>
 		  
        </table>
      </form>
</div>
</body>
</html>
