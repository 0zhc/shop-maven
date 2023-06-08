<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

 <link href="<%=path%>/css/loginAndrex/top_foot.css" rel="stylesheet" />
 <link href="<%=path%>/css/loginAndrex/login.css" rel="stylesheet" />

<script type="text/javascript" src="../js/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/login/jquery.cookie.js"></script>
<script src="<%=path %>/js/system/managerIndex.js"></script>
<script src="<%=path %>/js/login/login.js"></script>
<title>优复用登录</title>

<script>

var path='<%=path%>';

//表单提交
      function submitForm(){
      
      if(userPasswordCheck() == false)
       return false;
      
       if(userPasswordCheck()==false)
       return false;
       
                $.ajax({
             type: "post",
             url: "<%=request.getContextPath()%>/login.do?"+escape(new Date()),
             data:$("#login").serialize(),
             dataType: "html",//(可以不写,默认)
             beforeSend: function(XMLHttpRequest){
                     $("#loading").css("visibility","visible");
              },
              success: function(data, textStatus){
                //登录成功
                
                if(data=='ok'){
                     window.location.href='<%=request.getContextPath()%>/cjmqylogin/login_ok.jsp';
                  }
                  else{
                  //登录失败
                    $("#errorTip").css("visibility","visible");
                    $("#userNameTip").html("");
                    $("#un_pw_error").html("<span style='color: #FFFFFF;'>空空空空空空</span><span>用户名或者密码不正确</span>");
                     $("#loading").css("visibility","hidden");
                  }
                },
              complete: function(XMLHttpRequest, textStatus){
                     //HideLoading();
                },
              error: function(){
                     //请求出错处理
                 }
             });    
     }

</script>
</head>


<body>
<div id="contain">
      

	  
    
      <div id="content" style="margin-left: 300px; width: 700px">
    
 			
           
      <div id="log" style="background:url(images/lbj.jpg) no-repeat;width: 500px">
             
        	  <form action="" id="login">
                <div id="errorTip">
					<span id="un_pw_error"></span>
					<span id="userNameTip"></span>
				</div>

            	<div class="user">
                	<span id="name">账户名&nbsp;&nbsp;</span>
                	<span><input type="text" name="userName" id="userName" onblur="userNameChect();"/><input type="hidden" name="userType" value="1"/></span>
                </div>

                <div class="pw" >
            		<span id="pass">密<span style="color:#FFFFFF;">空</span>码&nbsp;&nbsp;</span>
                	<span><input type="password" id="userPassword" name="userPassword" onblur="userPasswordCheck();" /></span>
                </div>

				<div id="userPasswordTip"></div>

               	<div id="remember_name">
                	 <input type="checkbox" name="checkPW" id="checkPW"/>记住密码
					 <input type="hidden" name="rememberPW" id="rememberPW"/>
          	   </div>

               <div  id="dl">
                 	<span id="myloding">
						<img src="../images/load/loading.gif" id="loading"/>
					</span>
					<span id="login_forpass">
						<a href="javascript:void(0)" onclick="submitForm()" ><img src="images/buttom.gif" style="border: none;"/></a>
						<a href="#" target="_blank" id="forget_pass">忘记密码？</a>
					</span>
               </div>

                  <div id="reg_foot">
					<a href="res.jsp" id="reg_members">免费注册会员</a>
                    <a href="#" id="setup_shop">免费开店</a>	
                   </div>
                   
        	</form>
		</div>
  </div>
     
    
</div>

</body>
</html>
