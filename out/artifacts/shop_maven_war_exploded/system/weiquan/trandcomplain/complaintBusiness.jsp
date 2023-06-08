<%@ page language="java" import="java.util.*,com.shop.entity.*"
	pageEncoding="UTF-8"%>
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
     var submit = false;
			KE.show({
				id : 'content1',
				shadowMode : false,
				autoSetDataMode: false,
				
				allowPreviewEmoticons : false,
				resizeMode:false,
				afterCreate : function(id) {
					KE.event.add(KE.$('complaint'), 'submit', function() {
						KE.sync(id);
					});
				}
			});
			KE.show({
   				id : 'content1',
   				afterChange : function(id) {
   				var count = 300- KE.count(id,'text');
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
		var complain = document.getElementById("complain").value;
        if (!submit){

            if(complain == "" || complain == null){
                alert("请填写投诉原因！");
                return false;
            }
            if(complain.length > 20){
                alert("投诉原因不能超过20个字！");
                return false;
            }
            if(KE.isEmpty('content1')){
                alert("请填写详细描述！");
                return false;
            }
            if(KE.count('content1', 'text')>300){
                alert("详细描述不能超过300字!");
                return false;
            }
            event.returnvalue=false;
            submit=true;
            return true;
        }
        alert("您已提交投诉,请等待回复");
        return false;
    }


	///	document.complaint.add.disabled=true;
		//location.replace(this.href);


			
		</script>
</head>

<body>
<div  id="content">
<div id="navigation">当前位置：<a href="#">首页</a><span>>></span><a href="#">后台管理</a><span>>></span><a href="#">投诉商家</a></div>
      <form action="<%=request.getContextPath() %>/complaint/addComplaint.do" method="post" id="complaint" name="complaint" onsubmit="return isSubmit()">
          <input type="hidden" name="token" value="<%=session.getAttribute("TOKEN")%>" id="TOKEN"/>
<%--             <input type="hidden" name="TOKEN" value='<%=session.getAttribute("org.apache.struts.action.TOKEN")%>' id="TOKEN" />--%>

        <table border="0" cellspacing="0"  class="myshop">
          <tr >
          
           
           <td colspan="8" style="text-align:center; font-size:15px; height:30px;">

           <table width="100%" border="0" cellspacing="0">
             <tr>
               <td width="13%" align="center">投诉对象</td>
               <td width="87%" align="left"><span style="text-align:center;">${tradeRecord.goods.shop.name }</span>
               <input type="hidden" name="tradeId" value="${tradeRecord.id }">
               <input type="hidden" name="userId" value="${tradeRecord.goods.shop.user.id }"/>
               </td>
             </tr>
             <tr>
               <td align="center">投诉原因</td>
               <td align="left"><input type="text" style="width: 450px" name=complain id="complain" />(20个汉字以内)</td>
             </tr>
             <tr>
               <td align="center">详细描述</td>
               <td><textarea name="detailreason" cols="21" rows="18" id="content1" style="width:100%"></textarea>
 		              <span id="word_count"></span> <input name="word" id="wordId" type="hidden" value=""/>
               </td>
             </tr>
             <tr>
               <td colspan="2" align="center"><input type="submit" value="提交" name="add" />
               <input type="button" value="返回" onclick="javaScript:history.back()" /></td>
             </tr>
           </table>
           </td>
          </tr>
         
	    </table>
  </form>
</div>
</body>
</html>
