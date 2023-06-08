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
       <link rel="stylesheet" type="text/css" href="<%=path%>/cutpicture/css/imgareaselect-default.css" />
       <script type="text/javascript" src="<%=path%>/cutpicture/js/jquery.imgareaselect.min.js"></script>
     <!--  -->
     
    <!-- 执行上传文件操作的函数 -->
      <script type="text/javascript">
    
          function ajaxFileUpload(){
                var x1=$("#x1").val();
                var y1=$("#y1").val();
               var w=$("#w").val();
               var h=$("#h").val();
               $("#loading").ajaxStart(function(){
                   $(this).show();
                  })//开始上传文件时显示一个图片
           .ajaxComplete(function(){
            $(this).hide();
        });//文件上传完成将图片隐藏起来
               
               $.ajaxFileUpload(
                   {
                url:'update.do?method=uploader&x1='+x1+'&y1='+y1+'&w='+w+'&h='+h,            //需要链接到服务器地址
                secureuri:false,
                  type: "post",
                fileElementId:'localfile',                        //文件选择框的id属性
                dataType: 'xml',                                     //服务器返回的格式，可以是json
                success: function (data, status)            //相当于java中try语句块的用法
                {      
                   // $('#result').html('添加成功');
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

    $('#preview_fake').imgAreaSelect({x1: 2, y1: 35, x2:196, y2: 164, aspectRatio: '3:2',minWidth:50,minHeight:50, handles: true,onSelectChange:preview,onInit:preview });
    
    
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
 
  // objPre.style.width = zoomParam.width + 'px';   
 // objPre.style.height = zoomParam.height + 'px';   
    objPre.style.marginTop = zoomParam.top + 'px';   
    objPre.style.marginLeft = zoomParam.left + 'px';   
}   
  
function clacImgZoomParam( maxWidth, maxHeight, width, height ){   
    var param = { width:width, height:height, top:0, left:0 };   
     
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
     
}   
</style>
  </head>
  
  <body>
      <form method="post" action="update.do?method=uploader" enctype="multipart/form-data"> 
           <input name="localfile"  type="file" id="localfile" size="28" onchange="onUploadImgChange(this)"/>

			X:<input type="text" name="x1" id="x1" />
			Y:<input type="text" name="y1" id="y1" />
			width:<input type="text" name="w" id="w" />
			height:<input type="text" name="h" id="h" />

        <input type="button" value="提交" onclick="ajaxFileUpload()"/><img src="<%=path%>/cutpicture/imgs/loading.gif" id="loading" style="display:none;position: absolute;">
    </form> 

    <div id="result" ></div>
    



 

<!--以下是预览图片用的-->


<div id="preview_fake" style="width:200px; height:200;overflow:hidden;">
<img id="preview" src="<%=path%>/cutpicture/imgs/show.gif" onload="onPreviewLoad(this)" /><!-- firefox -->
<img id="preview_size_fake"  src="<%=path%>/cutpicture/imgs/show.gif"/><!-- Ie -->
</div>




  </body>

</html>
