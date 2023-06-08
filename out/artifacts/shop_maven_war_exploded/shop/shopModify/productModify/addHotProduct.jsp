<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>test</title>
	<!-- 引入相关的js文件，相对路径  -->
    <script type="text/javascript" src="<%=path%>/cutpicture/js/jquery-1.2.6.min.js"></script>
      <script type="text/javascript" src="<%=path%>/cutpicture/js/ajaxfileupload.js"></script>
       <link rel="stylesheet" type="text/css" href="<%=path%>/shop/shopModify/otherProduct/otherProduct1.css" />
       <script type="text/javascript" src="<%=path%>/js/shop/shopValidate.js"></script>
     <!-- 编辑器 -->
            <script src="<%=path %>/cjmqyeditor/kindeditor.js"></script>
            <script type="text/javascript">
            
                  KE.show({
       				id : 'content1',
       				afterChange : function(id) {
       				var count = 500- KE.count(id,'text');
       				document.getElementById("wordId").value =KE.count(id,'text');
       				if(count<0){
       					count = -count;	
       					KE.$('word_count').innerHTML = "您已超出<font style =' color:#ec4501;'>"+count+"</font>字";
       				}else{
       					KE.$('word_count').innerHTML = "您还可以输入"+count+"字";
       				}
       				}
       			});
            
            
                   KE.show({
				id : 'content1',
				shadowMode : false,
				autoSetDataMode: false,
				allowFileManager : true,
				allowPreviewEmoticons : false,
				resizeMode:false,
				afterCreate : function(id) {
					KE.event.add(KE.$('addOtherForm'), 'submit', function() {
						KE.sync(id);
					});
				},
				items : [//这个是新修改的
				'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image','link']
			});


           </script>
    <!-- 执行上传文件操作的函数 -->
      <script type="text/javascript">
          
          function ajaxFileUpload(){
             
             if($("#goodsId").val()>0){
                 alert("商品图片已经存在");
                return false;
             }
             
               
                var x1=$("#x1").val();
                var y1=$("#y1").val();
               var w=$("#w").val();
               var h=$("#h").val();
               var userName='${user.userName}';
               var shopId='${user.shop.id}';
               var goodsType=1;//1最热产品
               
               $("#loading").ajaxStart(function(){
                   $(this).show();
                  })//开始上传文件时显示一个图片
           .ajaxComplete(function(){
            $(this).hide();
        });//文件上传完成将图片隐藏起来
               
               $.ajaxFileUpload(
                   {
      url:'<%=path%>/shop/user/addPicture.do?x1='+x1+'&y1='+y1+'&w='+w+'&h='+h+'&userName='+userName+'&shopId='+shopId+'&goodsType='+goodsType,            //需要链接到服务器地址
                secureuri:false,
                  type: "post",
                fileElementId:'localfile',                        //文件选择框的id属性
                dataType: 'text',                                     //服务器返回的格式，可以是json
                success: function (data, status)            //相当于java中try语句块的用法
                { 
                      
                 var arr=data.split("|"); 
                 if(data=='empty'){
                   alert("请选择文件");
                    return false;
                 }
                 if(data=='out'){
                            alert("您的文件夹已经超过2.5M请删除一些商品");
                        return false;
                        }
                 if(data=='g'){
                  alert("文件格式只能为 jpg/gif");
                  return false;
                 }
                 if(data=='size'){
                   alert("文件大小不能超过100/kb");
                   return false;
                 }
                   if(data=='noUpdate'){
                   alert("上传失败");
                   return false;
                 }
                 if(arr[0]!=''){
                     $('#mypic').html('<img src="<%=path%>/images/Shoper/${user.userName}/'+arr[1]+'" alt=""   style="vertical-align: middle; margin-right: 50px;"/>');
                     alert("保存成功");
                     document.getElementById("updownInfo").innerHTML="";
                     $("#goodsId").val(arr[0]);
                  //   $("#add").hide();
                 //    $("#modify").show();
                   }else{
                      alert("文件不能为空 上传不成功");
                   }
                },
                error: function (data, status, e)            //相当于java中catch语句块的用法
                {
                    $('#result').html('添加失败');
                }
            }
                   
               );
              
          }
      
      </script>
    <script type="text/javascript">
    
$(function () {

  //  $('#preview_fake').imgAreaSelect({x1: 0, y1: 0, x2:0, y2: 0, aspectRatio: '3:2',minWidth:50,minHeight:50, handles: false,onInit:preview });
    
    
});

function preview(img ,selection) {
  
    if (!selection.width || !selection.height)
        return;
    
    var scaleX = 100 / selection.width;
    var scaleY = 100 / selection.height;
 
    $('#preview_fake1 img').css({
        width: Math.round(scaleX*300),
        height: Math.round(scaleY*300),
        marginLeft: -Math.round(scaleX * selection.x1),
        marginTop: -Math.round(scaleY * selection.y1)
    });
 
    $('#x1').val(selection.x1);
    $('#y1').val(selection.y1);
    $('#x2').val(selection.x2);
    $('#y2').val(selection.y2);
    $('#w').val(selection.width);
    $('#h').val(selection.height);    
}
</script>

<!-- ------ -->

<script type="text/javascript">
function onUploadImgChange(sender){ 
      
    if( !sender.value.match( /.jpg|.gif/i ) ){   
        alert('图片格式无效！');   
        return false;   
    }
    var objPreview = document.getElementById('preview');   
    var objPreviewFake = document.getElementById('preview_fake');   
    var objPreviewSizeFake = document.getElementById('preview_size_fake');
    if( sender.files &&  sender.files[0] ){   
        objPreview.style.display = 'block';   
        objPreview.style.width = 'auto';   
        objPreview.style.height = 'auto';   
           
        // Firefox 因安全性问题已无法直接通过 input[file].value 获取完整的文件路径   
        objPreview.src = sender.files[0].getAsDataURL();       
    }else if( objPreviewFake.filters ){    
        // IE7,IE8 在设置本地图片地址为 img.src 时出现莫名其妙的后果   
        //（相同环境有时能显示，有时不显示），因此只能用滤镜来解决   
           
        // IE7, IE8因安全性问题已无法直接通过 input[file].value 获取完整的文件路径   
        sender.select();   
        var imgSrc = document.selection.createRange().text;   
           
        objPreviewFake.filters.item(   
            'DXImageTransform.Microsoft.AlphaImageLoader').src = imgSrc;   
        objPreviewSizeFake.filters.item(   
            'DXImageTransform.Microsoft.AlphaImageLoader').src = imgSrc;   
           
        autoSizePreview( objPreviewFake,    
            objPreviewSizeFake.offsetWidth, objPreviewSizeFake.offsetHeight );   
        objPreview.style.display = 'none';   
    }   
}   
  
function onPreviewLoad(sender){   
    autoSizePreview( sender, sender.offsetWidth, sender.offsetHeight );   
}   
  
function autoSizePreview( objPre, originalWidth, originalHeight ){   
    var zoomParam = clacImgZoomParam( 300, 300, originalWidth, originalHeight );   
 
   objPre.style.width = zoomParam.width + 'px';   
  objPre.style.height = zoomParam.height + 'px';   
    objPre.style.marginTop = zoomParam.top + 'px';   
    objPre.style.marginLeft = zoomParam.left + 'px';   
}   
  
function clacImgZoomParam( maxWidth, maxHeight, width, height ){   
    var param = { width:369, height:246, top:0, left:0 };   
     
 /*   if( width>maxWidth || height>maxHeight ){   
        rateWidth = width / maxWidth;   
        rateHeight = height / maxHeight;   
           
        if( rateWidth > rateHeight ){   
            param.width =  maxWidth;   
            param.height = height / rateWidth;   
        }else{   
            param.width = width / rateHeight;   
            param.height = maxHeight;   
        }   
    }   
       
    param.left = (maxWidth - param.width) / 2;   
    param.top = (maxHeight - param.height) / 2;   */
     
    return param;   
} 
</script>
  <style type="text/css">
#preview_wrapper{   
    display:inline-block;   
  
    background-color:#CCC;
}   
#preview_fake{ /* 该对象用于在IE下显示预览图片 */   
    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);   
   
}   
#preview_size_fake{ /* 该对象只用来在IE下获得图片的原始尺寸，无其它用途 */   
    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);     

}   
#preview{ /* 该对象用于在FF下显示预览图片 */   
    width:369px;        
    height:246px;
}   
</style>
  <style type="text/css">
  #content {
	font-size:14px;
}
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
a { color:#666; text-decoration:none;}
a:hover {top:1px; left:1px; position:relative;}
input{width: 50px;}
#mypic img {width: 177px;height: 118px;}
</style>

  </head>
  
  
  <body>
   <div  id="content"  style="width:950px;margin-left: 25px; margin-right: 27px;">
      <form action="<%=path %>/system/modifyUserGoods.do" method="post" id="addOtherForm" onSubmit="return  isModify();">
      <input   name="jspType" value="hotAdd" type="hidden" >
     <table  class="myshop" cellspacing="0" style="100%px;">
         <tr>
           <th colspan="5" >店铺<span>>></span>店铺装修<span>>></span>添加最热商品</th>
           
         </tr>
		  <tr >
            <td style="">商品名称：</td><td><input type="text" id="name" name="name"  onBlur="checkName()" style="width: 130px;"/><span style="color: red;">*</span></td>
           <td style="" colspan="3">商品属性 &nbsp;&nbsp;<select  style="width: 60px;" name="goodsIsNew">
              <option value="1">全新</option> 
              <option value="2">二手</option>        
           </select><span style="color: red;">*</span>
     
          </td>
         
		  
         </tr>
           <tr>
           <td  rowspan=2>商品信息</td>
		   <td >
		   商品价格：<input type="text" id="price"  name="price" onBlur="checkPrice()"/><span style="color: red;">*</span><span>单位为元</span>
		  
           </td>
          <td >
                       商品尺寸：<input type="text" id="size"  name="size" onBlur="checkSize()"/><br/><span >尺寸单位：<input type="text" id="SizeUnit"  name="sizeUnit" onBlur="checkSizeUnit()"/></span>&nbsp;</td>
                      <td >商品数量：
                      <input type="text" id="amount" name="amount" onBlur="checkAmount()"/>
                      <span style="color: red;">*</span><br/><span>数量单位：
                      <input onBlur="checkAmountUnit()" type="text" id="amountUnit"  name="amountUnit" /></span>&nbsp;<span style="color: red;">*</span></td>
          <td>  商品产地：<input type="text" id="origin" name="origin" onBlur="checkOrigin()"/>&nbsp;</br></td>
  
         </tr>
		 <tr>
           <td>商品毛重：<input type="text" id="weight" name="weight" onBlur="checkWeight()"/><br/><span>毛重单位：<input type="text" id="grossUnit"  name="grossUnit" onBlur="checkGrossUnit()" /></td>
           <td>商品品牌：<input type="text" id="brand" name="brand" onBlur="checkBrand()"/></td>
           <td>商品颜色：&nbsp;&nbsp;<input type="text" id="color" name="color" onBlur="checkColor()"/></td>
           <td colspan="2">生产厂家：<input type="text" id="productAdd" name="productAdd" onBlur="checkProductAdd()"/></td>
         </tr>
    
        


         <tr>
           <td width="150">商品图片</td>
            <td colspan="4" style="height: 270px;padding-left: 20px;">
              
                   
               
       <div id="add">
             <!--以下是预览图片用的-->

                 
                 <div id="preview_fake" style="width:369px; height:246;overflow:hidden;background-color: #ccc;">
                 <img id="preview" src="<%=path %>/cutpicture/imgs/show.gif" onload="onPreviewLoad(this)"/><!-- firefox -->
               <!--  <img id="preview_size_fake"  src="<%=path %>/cutpicture/imgs/show.gif" /> Ie -->
              
                 </div>
                   <div>(<span style="color: #FF8080; font-size: 12px;">注:建议宽为369px，高为246px(3：2),大小不超过100KB,请上传gif,jpg格式.</span>)</div>
           <div id="mypic" style="position:absolute;left: 660px; top:200px; "></div>  
        
           <input name="localfile"  type="file" id="localfile" size="28" onChange="onUploadImgChange(this)" style="width: 250px;"/>

			<input type="hidden" name="x1" id="x1" />
			<input type="hidden" name="y1" id="y1" />
			<input type="hidden" name="w" id="w" />
			<input type="hidden" name="h" id="h" />
            <input type="hidden" name="goodsId"  id="goodsId" /> 
        <input type="button" value="上传图片" onClick="ajaxFileUpload(add)" style="width: 60px; margin-left: 50px;"/>&nbsp;<span style="color:red; font-size: 12px;" id="updownInfo">请先上传图片！</span><img src="<%=path %>/cutpicture/imgs/loading.gif" id="loading" style="display:none;position: absolute;"/>
       
    

                            
                  
                   
            </div>
            </td>           
         </tr>
         
		  <tr><td>商品描述</td><td colspan="4"><textarea rows="18" style="width:850px;height: 150px;" id="content1" name="description" ></textarea><span id="word_count"></span>
         <input name="word" id="wordId" type="hidden" value=""/>
         </td></tr>
         
       
         <tr style="text-align:center;">
           <td colspan="5"><input type="submit" value="提交" style="vertical-align: middle;"/>&nbsp;<a href="<%=path %>/shop/selectRollingGoods.do?shopId=${user.id }&typeJsp=selecHotGoods" style="color: blue;margin-right: 120px;float: right;">返回查看页面</a></td>
         </tr>
     </table>
     </form>
</div>

  </body>

</html>
