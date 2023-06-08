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
<script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
<script src="<%=path %>/cjmqyeditor/kindeditor.js"></script>
<link  href="<%=path %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=path %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />


<script>

			KE.show({
				id : 'content1',
				shadowMode : false,
				autoSetDataMode: false,
				syncType : '', //auto: 每次修改时都会同步; form:提交form时同步; 空:不会自动同步;
				allowPreviewEmoticons : false,
				resizeMode:false,
				afterCreate : function(id) {
					KE.event.add(KE.$('addShopForm'), 'submit', function() {
						KE.sync(id);
					});
				},
				items : [               //这个是新修改
				'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'link'],
				
				afterChange : function(id) {
				var count = 2000- KE.count(id, 'text');
				if(count<0){
					count = -count;	
					KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>"+count+"</font>字";
				}else{
					KE.$('word_count').innerHTML = "您还可以输入"+count+"字";
				}
				}
			});

			
			
			</script>
			
	<script type="text/javascript">
	function checkShopName(){
		//将中文字符转换为两个字符
		String.prototype.len= function (){                  
			return this .replace(/[^\x00-\xff]/g, "rr" ).length;           
		}   
			var name =document.getElementById("name").value;
			var reg = /^[\u4E00-\u9FA5 A-Za-z0-9]{0,}$/;
			if(name==""){
				document.getElementById("checkName").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入店铺名称！</font>";
				return false;
			}else if(!reg.test(name)){
				document.getElementById("checkName").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;只能输入中文、英文、数字！</font>";
				return false;
			}else if(name.len()>12){
				document.getElementById("checkName").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长度不能超过12个字符！ </font>";
				return false;
			}else{
				document.getElementById("checkName").innerHTML="";
				return true;
					}
		}
	function checkNumber(){
		var number=$("#number").val();
		if(number==null){
			return true;
			}
		var reg = /^[0-9]{3,6}$/;
		if(number==""){
			document.getElementById("checkNumber").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入宿舍号！</font>";
			return false;
			}else if(!reg.test(number)){
				document.getElementById("checkNumber").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入正确的宿舍号！</font>";
				return false;
			}else{
				document.getElementById("checkNumber").innerHTML="";
				return true;
			}
		}

	function checkNumber1(){
		var number1=$("#number1").val();
		if(number1==null){
			return true;
			}
		var reg = /^[\u4E00-\u9FA5 A-Za-z0-9\-.]{0,}$/;;
		if(number1==""){
			document.getElementById("checkNumber1").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入详细地点！</font>";
			return false;
			}else if(!reg.test(number1)){
				document.getElementById("checkNumber1").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;只能输入中文  英文  数字  '.'  '-'！</font>";
				return false;
			}else if(number1.length>30){
				document.getElementById("checkNumber1").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长度不能超过30个字符！</font>";
				return false;
				}else{
				document.getElementById("checkNumber1").innerHTML="";
				return true;
			}
		}
	function check(){
		
		if(KE.isEmpty('content1')){
			document.getElementById("checkInfo").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请输入店铺介绍！</font>"
			return false;
		}else if(KE.count('content1', 'text')>2000){
			document.getElementById("checkInfo").innerHTML="<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;店铺介绍不能超过2000个字符！</font>"
			return false;
		}else{
			document.getElementById("checkInfo").innerHTML=""
			}
		return checkShopName() && checkNumber() && checkNumber1();
	}
	</script>
</head>

<body>
<div  id="content">
      <form action="<%=path%>/system/userAddShop.do" id="addShopForm" method="post" onsubmit="return check()">
     <table  class="myshop">
         <tr style="line-height:21px;">
           <td colspan="2" ><a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">我的店铺</a></td>
           
         </tr>
         
         <tr >
           <td style="padding-left:10px;">经营类型<span style="color:#FF0000;">*</span></td><td>
           <select  style="width:100px;" name="shopBuyType">
              <option value="开心食品">开心食品</option>
              <option value="零食坊">零食坊</option>
              <option value="数码产品">数码产品</option>
              <option value="常用电器">常用电器</option>
              <option value="服装服饰">服装服饰</option>
              <option value="运动用品">运动用品</option>
              <option value="学习用品">学习用品</option>
              <option value="寸金书城">寸金书城</option>
              <option value="美容护发">美容护发</option>
              <option value="寸金订花">寸金订花</option>
              <option value="订蛋糕">订蛋糕</option>
              <option value="旅游">旅游</option>
              <option value="旅游">快递</option>
              <option value="寸金KTV">寸金KTV</option>
              <option value="餐饮">餐饮</option>
              
           </select></td>
           
         </tr>
         <tr>
           <td  style=" padding-left:10px;">店铺名称<span style="color:#FF0000;">*</span></td><td><input type="text"  name="name" id="name" onblur="checkShopName()"/>（这个比较重要，搜索店铺时，以这个为主）<span id="checkName"></span></td>  
         </tr>
         
         <tr>
           <td  style=" padding-left:10px;">店铺地址<span style="color:#FF0000;">*</span></td>
           <c:choose>
               <c:when test="${userNew.userType==1}">
                   <td>
                <select name="shopBigAddress" style="width:100px;">
                  <option value="崇祥苑">崇祥苑</option>
                  <option value="崇德苑">崇德苑</option>
                  <option value="崇明苑">崇明苑</option>
                  <option value="崇智苑">崇智苑</option>
                  <option value="进德苑">进德苑</option>
                  <option value="厚德苑">厚德苑</option>
                  <option value="齐家苑">齐家苑</option>
                  <option value="同源苑">同源苑</option>
                  <option value="明德苑">明德苑</option>
                  <option value="和馨苑">和馨苑</option>
                  <option value="知远苑">知远苑</option>
                  <option value="桐华A">桐华A</option>
                  <option value="桐华B">桐华B</option>
                  <option value="桐华C">桐华C</option>
                </select>
                                             输入宿舍号<input type="text"  name="shopDetailAddress" id="number" onblur="checkNumber()"/><span id="checkNumber"></span></td>
               </c:when>
               <c:when test="${userNew.userType==2}">
                  <!-- 商家 -->               
                <td>
                    <select name="shopBigAddress">
                     <option>寸金</option>
                    </select>
           
                                                    输入详细地点<input type="text"  name="shopDetailAddress" id="number1" onblur="checkNumber1()"/><span id="checkNumber1"></span>
                 </td>     
               
               </c:when>
             <c:otherwise>
             </c:otherwise>
           </c:choose>
           <td>
         </tr>
         <tr style="border: none;">
           <td style=" padding-left:10px;">店铺介绍<span style="color:#FF0000;">*</span></td><td style="border: none;"><textarea rows="16" cols="81" id="content1"  style="width:690px;"  name="shopInfo">
           </textarea><span id="word_count"></span><span id="checkInfo"></span></td>
         </tr>
         <tr style="text-align:center;">
           <td colspan="2"><input type="submit" value="提交"  onclick="addUserShop()"/>&nbsp;&nbsp;&nbsp;<input type="reset"  value="重置"/></td>
         </tr>
     </table>
     </form>
</div>
</body>
</html>
