<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>配送范围</title>
<script src="<%=request.getContextPath()%>/cjmqyeditor/kindeditor.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script>
			KE.show({
				id : 'content1',
				shadowMode : false,
				autoSetDataMode: false,
				syncType : 'auto', //auto: 每次修改时都会同步; form:提交form时同步; 空:不会自动同步;
				allowPreviewEmoticons : false,
				resizeMode:false,
				afterCreate : function(id) {
					KE.event.add(KE.$('myForm'), 'submit', function() {
						KE.sync(id);
					});
				}
			});
			
			//富文本框设置显示输入文本长度
			KE.show({
				id : 'content1',
				afterChange : function(id) {
				
				var countCurrent = KE.count(id, 'text');//输入了多少个字

				var count = 2000- countCurrent;//还可以输入多少个字
				
				document.getElementById("wordId").value =countCurrent;
				
				if(count<0){
					count = -count;	
					KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>"+count+"</font>字";	
				}else{
					KE.$('word_count').innerHTML = "您还可以输入"+count+"字";
					
				}
					
				}
			});
			 
</script>

<script>
$(function(){
	
		//如果店铺 导航栏商家介绍全部为空，隐藏填写商家介绍表单,隐藏装饰按钮
		if('${empty shop.deliverScope}'=='true'){

			$("#ScopeContent").hide();
			$("#updateDecorate").hide();

		}else{
		//否则隐藏“马上添加”，,隐藏添加按钮
			$("#if_add").hide();
			$("#updateDecorate").show();
			
		}
		
		//如果装饰成功，显示“装饰商家介绍信息成功,请先关闭窗口当前窗口，然刷新页面”
		if('${!empty updateScopeSuccess && !empty shop.deliverScope}'=='true'){

			$("#modifyScopeSuccess").show();
		}else{
		//否则不显示“装饰商家介绍信息成功,请先关闭窗口当前窗口，然刷新页面”
			$("#modifyScopeSuccess").hide();
		}
			
	})
	
	//点击马上添加，秀出填写公告内容的表单,装修按钮
	$(function(){
		$("#add").click(function(){
			$("#ScopeContent").show();
			$("#if_add").hide();
			$("#updateDecorate").show();
		})
	})
	
	
	
	//验证文本框文字长度
    function validatTextarea(){
    
		if(KE.count('content1', 'text')>2000){
			document.getElementById("textDiv").innerHTML="<font style =' color:#ec4501;'>&nbsp;&nbsp;&nbsp;&nbsp;输入内容超过2000</font>";
			return false;
		}
			return true;
	}
	
		
</script>

<style type="text/css">
	<!--
	*{margin: 0px; padding: 0px; }
	#container{margin-top:20px; margin-left:33px;}
	#content { width:530px; font-size:14px;}
	a { color:#666; text-decoration:none;}
	a:hover { top:1px; left:1px; position:relative;}
	legend { margin-bottom: 10px;}
	#modifyScopeSuccess{height:40px; line-height:40px; font-family:宋体; font-size:14px; color:#FF7D7D;}	
	-->
</style>
</head>
  
<body>
<div id="container">
<center>
	<div>
		<form action="<%=request.getContextPath()%>/modifyShopScope.do?userId=${userId}" id="myForm"  method="post" onsubmit="return validatTextarea()">
			<fieldset>
			<legend>配送范围</legend>
			<div id="if_add">您还没有添加商家介绍信息！<a href="javascript:void(0)" id="add" >马上添加</a></div>
			<div id="ScopeContent"><textarea name="content" cols="21" rows="10" id="content1" style="width:100%">${shop.deliverScope}</textarea>
				 <span id="word_count"></span>
				 <input name="word" id="wordId" type="hidden" value="" />
			</div>
			<input type="submit" id="updateDecorate" value="装饰"/>
			</fieldset>
		</form>
	</div>
	<div id="modifyScopeSuccess">
			<span>装饰商家介绍信息成功,请先关闭窗口当前窗口，然刷新页面</span>
	</div>
	<div id="textDiv"></div>
</center>
</div>
</body>
</html>
