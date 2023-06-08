<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的店铺</title>
    <script src="<%=path %>/js/jquery-1.2.6.min.js"></script>
    <link href="../../../css/sysytem/content_conmond.css" type="text/css" rel="stylesheet"/>
    <link href="../../../css/sysytem/myshop.css" type="text/css" rel="stylesheet"/>
    <script src="../../../cjmqyeditor/kindeditor.js"></script>
    <script>
        KE.show({
            id: 'content1',
            shadowMode: false,
            autoSetDataMode: false,
            syncType: '', //auto: 每次修改时都会同步; form:提交form时同步; 空:不会自动同步;
            allowPreviewEmoticons: false,
            resizeMode: false,
            afterCreate: function (id) {
                KE.event.add(KE.$('goodsModifForm'), 'submit', function () {
                    KE.sync(id);
                });
            }
        });
    </script>
    <script>
        $(function () {
            KE.html('content1', '${goods.description}');

        });
    </script>
</head>

<body>
<div id="content">
    <form action="<%=path %>/system/modifyUserGoods.do" id="goodsModifForm" method="post">
        <input type="hidden" value="${goods.id }" name="goodsId"/>
        <table class="myshop">
            <tr style="line-height:21px;">
                <td colspan="2"><a>首页</a><span>>></span><a>后台管理</a><span>>></span><a>我的商品</a></td>

            </tr>

            <tr>
                <td style="padding-left:10px; padding-right:10px;">商品成色</td>
                <td>
                    <select style="width:100px;" name="goodsIsNew">
                        <option value="1">全新</option>
                        <option value="2">二手</option>
                    </select></td>
                </td>
            </tr>

            <tr>
                <td style="padding-left:10px; padding-right:10px;">商品名称</td>
                <td><input name="name" type="text" value="${goods.name}"/></td>


            </tr>


            <tr>
                <td style=" padding-left:10px; padding-right:10px;">商品图片</td>
                <td>${goods.goodsUrl }</td>
            </tr>

            <tr>
                <td rowspan=3 style=" padding-left:10px; padding-right:10px;">商品信息</td>
                <td style="padding-left:5px;">
                    商品价格：<input type="text" name="price" value="${goods.price}"/>&nbsp;&nbsp;
                    商品类别：<input type="text" value="${goods.goodsType}" name="goodsType"/>&nbsp;&nbsp;
                    商品品牌：<input type="text" value="${goods.brand}" name="brand"/>&nbsp;&nbsp;
                </td>
            </tr>

            <tr>
                <td style="padding-left:5px;">
                    商品尺寸：<input type="text" value="${goods.size}" name="size"/>&nbsp;&nbsp;
                    商品数量：<input type="text" value="${goods.amount}" name="amount"/>&nbsp;&nbsp;
                    商品颜色：<input type="text" value="${goods.color}" name="color"/>&nbsp;&nbsp;
                </td>
            </tr>

            <tr>
                <td style="padding-left:5px;">
                    商品产地：<input type="text" value="${goods.origin}" name="origin"/>&nbsp;&nbsp;
                    商品毛重：<input type="text" value="${goods.weight}" name="weight"/>&nbsp;&nbsp;
                    生产厂家：<input type="text" value="${goods.productAdd}" name="productAdd"/>&nbsp;&nbsp;
                </td>
            </tr>


            <tr>
                <td style=" padding-left:10px; padding-right:10px;">商品描述</td>
                <td><textarea rows="16" cols="81" id="content1" style="width:690px;" name="description"></textarea></td>

            </tr>

            <tr>
                <td colspan="2">
                    <input type="submit" value="修改"/><input type="reset" value="重置"/>&nbsp;&nbsp;<a
                        href="../modiGoods.html">返回</a>
                </td>


            </tr>
        </table>
    </form>
</div>
</body>
</html>
