<%@ page language="java" import="java.util.*,com.shop.entity.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%org.apache.struts.util.TokenProcessor.getInstance().saveToken(request); %>--%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的店铺</title>
<link  href="<%=request.getContextPath() %>/css/sysytem/content_conmond.css" type="text/css" rel="stylesheet" />
<link  href="<%=request.getContextPath() %>/css/sysytem/myshop.css" type="text/css" rel="stylesheet" />
<script src="<%=request.getContextPath() %>/cjmqyeditor/kindeditor.js"></script>
<script>
			KE.show({
				id : 'content1',
				shadowMode : false,
				autoSetDataMode: false,
				syncType : '', //auto: 每次修改时都会同步; form:提交form时同步; 空:不会自动同步;
				allowPreviewEmoticons : false,
				resizeMode:false,
				afterCreate : function(id) {
					KE.event.add(KE.$('annouce'), 'submit', function() {
						KE.sync(id);
					});
				}
			});
			KE.show({
				id : 'content1',
				afterChange : function(id) {
				var count = 1200- KE.count(id, 'text');
				document.getElementById("wordId").value =KE.count(id,'text');
				if(count<0){
					count = -count;	
					KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>"+count+"</font>字";
				}else{
					KE.$('word_count').innerHTML = "您还可以输入"+count+"字";
				}
				}
			});

			
	function isSubmit(){
		var title = document.getElementById("title").value;
		if(title==null || title==""){
			alert("请填写标题！");
			return false;
			}
		if(title.length>30){
			alert("标题不能超过 30字！ ");
			return false;
			}
		if(KE.isEmpty('content1')){
			alert("请填写公告内容！");
			return false;
		}
		if(KE.count('content1', 'text')>1200){
		alert("公告内容不能超过1200字!");
		return false;
		}
		return true;

	
	}
			
		</script>
</head>

<body>
<div  id="content">
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">查看站内公告</a></div>
      <form action="<%=request.getContextPath() %>/stationAnnouce/modifyStationAnnouces.do" id="annouce" method="post" onsubmit="return isSubmit()">
          <input type="hidden" name="token" value="<%=session.getAttribute("TOKEN")%>" id="TOKEN"/>
     <input type="hidden" name="id" value="${stationAnnouce.id }"/>
     <table  class="myshop">
         <c:if test="${stationAnnouce.state==1}">
         <tr >
           <td style="padding-left:10px;">标题</td>
           <td>
              <input type="text" name="title" value="${stationAnnouce.title }" style="width: 450px" />(限制30字以内)
           </td>
         </tr>
         <tr>
           <td style=" padding-left:10px;">公告内容</td><td><textarea rows="16" cols="81" id="content1" name="content"  style="width:690px;" >${stationAnnouce.content }</textarea>
        	   <span id="word_count"></span> <input name="word" id="wordId" type="hidden" value=""/>
           </td>
         </tr>
          <tr >
           <td style="padding-left:10px;">是否要发送</td>
           <td align="center">
              是<input type="radio"  name="state" value="2"  />&nbsp;&nbsp;否<input type="radio"  checked="checked" name="state" value="1"/>
           </td>
         </tr>
         <tr style="text-align:center;">
           <td colspan="2"><input type="submit" value="修改" /> <input type="button" value="返回" onclick="javaScript:history.back()"/></td>
         </tr>
         </c:if>
         <c:if test="${stationAnnouce.state==2}">
         <tr >
           <td style="padding-left:10px;" width="10%">标题</td>
           <td width="90%">
             ${stationAnnouce.title }
           </td>
         </tr>
         <tr>
           <td style=" padding-left:10px;">公告内容</td><td>${stationAnnouce.content }</td>
         </tr>
          <tr >
           <td style="padding-left:10px;">状态</td>
           <td >
       	       已发送
           </td>
         </tr>
         <td style="padding-left:10px;">公告时间</td>
           <td >
       	       ${stationAnnouce.inTime }
           </td>
         </tr>
         <tr style="text-align:center;">
          <td colspan="2"> <input type="button" value="返回" onclick="javaScript:history.back()"/></td>
         </tr>
         </c:if>
     </table>
     </form>
</div>
</body>
</html>
