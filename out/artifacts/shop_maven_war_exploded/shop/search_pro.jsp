<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("utf-8");

%>

<html>
<head>
<title>符合条件宝贝</title>
 <link  href="<%=request.getContextPath()%>/shop/shop_css/search_pro.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js"></script>
<script type="text/javascript">

	var userId = "${param.userId}";
	var proKeyWord = "${param.proKeyWord}";
	var oneProPrice = "${param.oneProPrice}";
	var twoProPrice = "${param.twoProPrice}";


	$(function(){
    		
    		$('#searchbtn').click(function(){
    			var num = $('#searchnum').val();
    			query(num);
    		})
    	})
    
    function topQuery(i){
    	
    	proKeyWord = document.getElementById("keyWord").value;
		oneProPrice = document.getElementById("price1").value;
		twoProPrice = document.getElementById("price2").value;
		
		query(i);
    }	
   
	function query(i){
	
    		$('li').remove();//移掉<li>
    		$('#num').html("");
    		$('#prevPage').html("");
    		$('#nextPage').html("");
    		var path='<%=path%>/';
            var basePath='<%=basePath%>/'
    		$.ajax({
		   			type: "POST",
		   			data:{'currentPage':i,'userId':userId,'proKeyWord':proKeyWord,'oneProPrice':oneProPrice,'twoProPrice':twoProPrice},
		   			url: "${pageContext.request.contextPath}/findAllProInShop.do",
		   			dataType:"json",  //这个指定它是json（返回来得json对象）
		   			success: function(msg){
		   			    
		   				for(var i in msg.g){
		   				
		   					// $('ul').append('<li><a href="'+path+'goodsFindShop.do?type=datail&goodsId='+msg.g[i].id+'"  target="_top"><img src="'+path+msg.g[i].url+'" /></a><span class="pro_name"><a href="">'+msg.g[i].name+'</a></span><span class="pro_price">'+msg.g[i].price+'元</span><a href="'+path+'/goodsFindShop.do?type=datail&goodsId='+msg.g[i].id+'" class="buy"  target="_top"></a><a href="javascript:collectGood('+msg.g[i].id+');" class="collect"></a></li>');
                            $('ul').append('<li><a href="'+basePath+'goodsFindShop.do?type=datail&goodsId='+msg.g[i].id+'"  target="_top"><img src="'+path+msg.g[i].url+'" /></a><span class="pro_name"><a href="">'+msg.g[i].name+'</a></span><span class="pro_price">'+msg.g[i].price+'元</span><a href="'+basePath+'goodsFindShop.do?type=datail&goodsId='+msg.g[i].id+'" class="buy"  target="_top"></a><a href="javascript:collectGood('+msg.g[i].id+');" class="collect"></a></li>');

                        }
		   				
		   				$('#totalPage').html(msg.p.totalPage);//共有多少页
		   				$('#totalRecord').html(msg.p.totalRecord);//每月记录数
		   				
		   				if(msg.p.hasPrevPage==true){
		   					var pp = msg.p.currentPage-1;
		   					$('#prevPage').html("<a href='javascript:query("+pp+")'>上一页</a>");
		   				}	 
		   				if(msg.p.hasNextPage==true){
		   					var np = msg.p.currentPage+1;
		   					$('#nextPage').html("<a href='javascript:query("+np+")'>下一页</a>");
		   				}	 
		   				
		   				$('#firstPage').html("<a href='javascript:query(1)'>首页</a>");
		   				$('#lastPage').html("<a href='javascript:query("+msg.p.totalPage+")'>尾页</a>");
		   				$('#currentPage').html(""+msg.p.currentPage);//
		   				
		   				
		   				//以下为计算分页显示的算法
		   				var flat1 = false;
		   				var flat2 = false;
		   				var count = 0;
		   				var totalPage = msg.p.totalPage;
		   				var currentPage = msg.p.currentPage;
		   				
		   				if(totalPage<=7){
		   					for(var x=1;x<=totalPage;x++){
		   						$('#num').append("<a href='javascript:query("+x+")'>"+x+"</a>&nbsp;");
		   					}
		   				}else{
		   					
		   						if(currentPage<=4){
		   							for(var x=1;x<=7;x++){
		   							
		   								if(x==currentPage){
		   									$('#num').append(x+"&nbsp;");
		   								}else{
		   									$('#num').append("<a href='javascript:query("+x+")'>"+x+"</a>&nbsp;");
		   								}
			   							
		   							}
		   							$('#num').append("...");
		   							
		   						}else if(currentPage>=totalPage-3){
		   							$('#num').append("...");
		   							for(var x=totalPage-6;x<=totalPage;x++){
		   								if(x==currentPage){
		   									$('#num').append(x+"&nbsp;");
		   								}else{
		   									$('#num').append("<a href='javascript:query("+x+")'>"+x+"</a>&nbsp;");
		   								}
		   								
		   							}
		   						}else{
		   							$('#num').append("...");
		   							for(var x=currentPage-3;x<=currentPage+3;x++){
		   							
		   								if(x==currentPage){
		   									$('#num').append(x+"&nbsp;");
		   								}else{
		   									$('#num').append("<a href='javascript:query("+x+")'>"+x+"</a>&nbsp;");
		   								}
		   								
		   							}
		   							$('#num').append("...");
		   						}
		   					}
		   					
		   				}		
			}); 
    	}
</script>
</head>
  
<body onload="query(1)">
<div id="search_prolist">
	
  <div id="search_condition">
      <div id="search_condition_title">
        	<div id="condition_title_letter">符合条件的宝贝</div>
      </div> 
      <div id="search_condition_main">
        <span id="pro_quantity">共搜索到<span id="totalRecord"></span>个符合条件的商品。</span>
        <span id="search_price">关键字：<input type="text" maxlength="40" id="keyWord"/>&nbsp;&nbsp;价格：<input type="text" maxlength="10" id="price1" />&nbsp;到&nbsp;<input type="text" maxlength="10"  id="price2" /></span>
        <span id="keyword_price"><a href="javascript:topQuery(1);"></a></span>   
      </div>
  </div>
    
    <div id="condition_goods">
      <ul></ul>
	</div>

    <div id="goods_page">		
			<span id="firstPage"></span>&nbsp;
			<span id="prevPage"></span>&nbsp;	<!-- 上一页  -->
			<span id="num"></span>&nbsp;
			<span id="nextPage"></span>&nbsp;	<!-- 下一页  -->
			<span id="lastPage"></span>&nbsp;
			<span>共<span id="totalPage"></span>页</span>&nbsp; 
			<span>到第&nbsp;<input type="text" id="searchnum" style="width:25px; height:18px;" />&nbsp;页</span>&nbsp;
			<input type="button" id="searchbtn" value="确定" />
    </div>
</div>
</body>
</html>
