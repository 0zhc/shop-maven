<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>test</title>
    <!-- 引入相关的js文件，相对路径  -->
    <script type="text/javascript" src="<%=path%>/cutpicture/js/jquery-1.2.6.min.js"></script>
    <script type="text/javascript" src="<%=path%>/cutpicture/js/ajaxfileupload.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/shop/shopModify/otherProduct/otherProduct1.css"/>
    <!-- 编辑器 -->
    <script src="<%=path %>/cjmqyeditor/kindeditor.js"></script>
    <script type="text/javascript">
        KE.show({
            id: 'content1',
            shadowMode: false,
            autoSetDataMode: false,
            allowFileManager: true,
            allowPreviewEmoticons: false,
            resizeMode: false,
            afterCreate: function (id) {
                KE.event.add(KE.$('addOtherForm'), 'submit', function () {
                    KE.sync(id);
                });
            },
            items: [//这个是新修改的
                'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link']
        });
    </script>
    <!-- 执行上传文件操作的函数 -->
    <script type="text/javascript">

        function ajaxFileUpload() {

            if ($("#goodsId").val() > 0) {
                alert("商品图片已经存在");
                return false;
            }


            var x1 = $("#x1").val();
            var y1 = $("#y1").val();
            var w = $("#w").val();
            var h = $("#h").val();
            var userName = '${user.userName}';
            var shopId = '${user.shop.id}';
            var goodsType = 0;//0为滚动图片

            $("#loading").ajaxStart(function () {
                $(this).show();
            })//开始上传文件时显示一个图片
                .ajaxComplete(function () {
                    $(this).hide();
                });//文件上传完成将图片隐藏起来

            $.ajaxFileUpload(
                {
                    url: '<%=path%>/shop/user/addPicture.do?isRolling=1&x1=' + x1 + '&y1=' + y1 + '&w=' + w + '&h=' + h + '&userName=' + userName + '&shopId=' + shopId + '&goodsType=' + goodsType,            //需要链接到服务器地址
                    secureuri: false,
                    type: "post",
                    fileElementId: 'localfile',                        //文件选择框的id属性
                    dataType: 'text',                                     //服务器返回的格式，可以是json
                    success: function (data, status)            //相当于java中try语句块的用法
                    {

                        var arr = data.split("|");
                        if (data == 'empty') {
                            alert("请选择文件");
                            return false;
                        }
                        if (data == 'out') {
                            alert("您的文件夹已经超过2.5M请删除一些商品");
                            return false;
                        }
                        if (data == 'g') {
                            alert("文件格式只能为 jpg/gif");
                            return false;
                        }
                        if (data == 'size') {
                            alert("文件大小不能超过200/kb");
                            return false;
                        }
                        if (data == 'noUpdate') {
                            alert("上传失败");
                            return false;
                        }
                        if (data == 'yes') {
                            //  $('#mypic').html('<img src="<%=path%>/images/Shoper/${user.userName}/'+arr[1]+'"alt=""   style="vertical-align: middle; margin-right: 50px;"/>'+'上传成功');
                            alert("保存成功");
                            //     $("#goodsId").val(arr[0]);
                            //   $("#add").hide();
                            //    $("#modify").show();
                        } else {
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

    <!-- ------ -->

    <script type="text/javascript">
        function onUploadImgChange(sender) {

            if (!sender.value.match(/.jpg|.gif/i)) {
                alert('图片格式无效！');
                return false;
            }
            var objPreview = document.getElementById('preview');
            var objPreviewFake = document.getElementById('preview_fake');
            var objPreviewSizeFake = document.getElementById('preview_size_fake');
            if (sender.files && sender.files[0]) {
                objPreview.style.display = 'block';
                objPreview.style.width = 'auto';
                objPreview.style.height = 'auto';

                // Firefox 因安全性问题已无法直接通过 input[file].value 获取完整的文件路径
                objPreview.src = sender.files[0].getAsDataURL();
            } else if (objPreviewFake.filters) {
                // IE7,IE8 在设置本地图片地址为 img.src 时出现莫名其妙的后果
                //（相同环境有时能显示，有时不显示），因此只能用滤镜来解决

                // IE7, IE8因安全性问题已无法直接通过 input[file].value 获取完整的文件路径
                sender.select();
                var imgSrc = document.selection.createRange().text;

                objPreviewFake.filters.item(
                    'DXImageTransform.Microsoft.AlphaImageLoader').src = imgSrc;
                objPreviewSizeFake.filters.item(
                    'DXImageTransform.Microsoft.AlphaImageLoader').src = imgSrc;

                autoSizePreview(objPreviewFake,
                    objPreviewSizeFake.offsetWidth, objPreviewSizeFake.offsetHeight);
                objPreview.style.display = 'none';
            }
        }

        function onPreviewLoad(sender) {
            autoSizePreview(sender, sender.offsetWidth, sender.offsetHeight);
        }

        function autoSizePreview(objPre, originalWidth, originalHeight) {
            var zoomParam = clacImgZoomParam(300, 300, originalWidth, originalHeight);

            objPre.style.width = zoomParam.width + 'px';
            objPre.style.height = zoomParam.height + 'px';
            objPre.style.marginTop = zoomParam.top + 'px';
            objPre.style.marginLeft = zoomParam.left + 'px';
        }

        function clacImgZoomParam(maxWidth, maxHeight, width, height) {
            var param = {width: 777, height: 234, top: 0, left: 0};

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
        #preview_wrapper {
            display: inline-block;

            background-color: #CCC;
        }

        #preview_fake { /* 该对象用于在IE下显示预览图片 */
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);

        }

        #preview_size_fake { /* 该对象只用来在IE下获得图片的原始尺寸，无其它用途 */
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);

        }

        #preview { /* 该对象用于在FF下显示预览图片 */
            width: 777px;
            height: 234px;
        }
    </style>
    <style type="text/css">
        #content {
            font-size: 14px;
        }

        table td {
            border-right: 1px solid #CCC;
            border-bottom: 1px solid #CCC;
        }

        table {
            border-top: 1px solid #CCC;
            border-left: 1px solid #CCC;
        }

        table th {
            background-color: #CCC;
            border-right: 1px solid #999;
            border-bottom: 1px solid #999;
        }

        a {
            color: #666;
            text-decoration: none;
        }

        a:hover {
            top: 1px;
            left: 1px;
            position: relative;
        }

        input {
            width: 50px;
        }
    </style>

</head>


<body>
<div id="content" style="padding-left: 30px;padding-top: 3px;">
    <form action="<%=path %>/system/modifyUserGoods.do" method="post" id="addOtherForm" onsubmit="return  isModify();">
        <input name="jspType" value="hotAdd" type="hidden">
        <table class="myshop" cellspacing="0" style="100%px;">
            <tr>
                <th colspan="5">店铺<span>>></span>店铺装修<span>>></span>添加滚动商品</th>

            </tr>


            <tr>
                <td style="padding-left: 10px;">商品图片</td>
                <td colspan="4" style="height: 270px;padding-left: 20px;">


                    <div id="add">
                        <!--以下是预览图片用的-->


                        <div id="preview_fake" style="width:777px; height:234; background-color: #ccc;">
                            <img id="preview" src="<%=path %>/cutpicture/imgs/show.gif" onload="onPreviewLoad(this)"/>
                            <!-- firefox -->
                            <img id="preview_size_fake" src="<%=path %>/cutpicture/imgs/show.gif"/><!-- Ie -->

                        </div>
                        <div>(<span style="color: red; font-size: 12px;">注</span>:长度777px和高度234px,大小不要超过200KB,只能使用gif,jpg格式)
                        </div>
                        <div id="mypic" style="position:absolute;left: 630px; top:120px;"></div>

                        <input name="localfile" type="file" id="localfile" size="28" onchange="onUploadImgChange(this)"
                               style="width: 250px;"/>

                        <input type="hidden" name="x1" id="x1"/>
                        <input type="hidden" name="y1" id="y1"/>
                        <input type="hidden" name="w" id="w"/>
                        <input type="hidden" name="h" id="h"/>
                        <input type="hidden" name="goodsId" id="goodsId"/>
                        <input type="button" value="上传图片" onclick="ajaxFileUpload(add)"
                               style="width: 60px; margin-left: 50px;"/><img
                            src="<%=path %>/cutpicture/imgs/loading.gif" id="loading"
                            style="display:none;position: absolute;"/>
                        <br/> <a
                            href="<%=path %>/shop/selectRollingGoods.do?shopId=${user.shop.id }&typeJsp=selecRollingGoods"
                            style="float: right;margin-right: 40px;color: blue;">返回查询页面</a>


                    </div>
                </td>
            </tr>

        </table>
    </form>
</div>

</body>

</html>
