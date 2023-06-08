<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title></title>
    <script src="<%=request.getContextPath()%>/js/jquery-1.2.6.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(function () {

            //如果店铺公告全部为空，隐藏填写公告内容的表单,隐藏修改按钮
            if ('${empty shopAnnouceList[0].content && empty shopAnnouceList[1].content && empty shopAnnouceList[2].content && empty shopAnnouceList[3].content}' == 'true') {

                $("#addComplete").hide();
                $("#updateDecorate").hide();

            } else {
                //否则隐藏“马上添加”，,隐藏添加按钮
                $("#if_add").hide();
                $("#addDecorate").hide();
            }

            //如果修改成功，显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
            if ('${!empty updateNewSuccess}' == 'true') {

                $("#modifyNewSuccess").show();
            } else {
                //否则不显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
                $("#modifyNewSuccess").hide();
            }

            //如果天添加成功，显示“修改信息成功,请先关闭窗口当前窗口，然刷新页面”
            if ('${!empty AddNewSuccess}' == 'true') {

                $("#addAnnouceSuccess").show();
            } else {
                //否则不显示“添加信息成功,请先关闭窗口当前窗口，然刷新页面”
                $("#addAnnouceSuccess").hide();
            }


        })

        //点击马上添加，秀出填写公告内容的表单
        $(function () {
            $("#add").click(function () {
                $("#addComplete").show();
                $("#if_add").hide();
            })
        })

        //使用jq,使商家填写店铺公告信息时显示提示内容
        $(function () {
            $(".new").focus(function () {
                $(this).addClass("focus");
                $(this).next("span").show();
                $(this).next("span").next("span").html("");
            }).blur(function () {
                $(this).removeClass("focus");
                $(this).next("span").hide();
            });
        })


        //验证商家第一个公布信息
        function validatNewOne() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var newOne = document.getElementById("newOneId").value;

            if (newOne.len() == 0) {//第一个店铺公告不能为空
                document.getElementById("newOneSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;第一条店铺公告不能为空</font>";
                return false;
            } else if (newOne.len() > 30) {
                document.getElementById("newOneSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容超过15个字符</font>";
                return false;
            } else if (newOne.len() < 16) {
                document.getElementById("newOneSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容不能少于8个字符</font>";
                return false;
            } else {
                document.getElementById("newOneSpan").innerHTML = "";
                return true;
            }
        }


        //验证商家第二个公布信息
        function validatNewTwo() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var newTwo = document.getElementById("newTwoId").value;

            if (newTwo.len() == 0) {//可以为空
                document.getElementById("newOneSpan").innerHTML = "";
                return true;
            } else if (newTwo.len() > 30) {
                document.getElementById("newTwoSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容超过15个字符</font>";
                return false;
            } else if (newTwo.len() < 16) {
                document.getElementById("newTwoSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容不能少于8个字符</font>";
                return false;
            } else {
                document.getElementById("newTwoSpan").innerHTML = "";
                return true;
            }
        }


        //验证商家第三个公布信息
        function validatNewThree() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var newThree = document.getElementById("newThreeId").value;

            if (newThree.len() == 0) {//可以为空
                document.getElementById("newOneSpan").innerHTML = "";
                return true;
            } else if (newThree.len() > 30) {
                document.getElementById("newThreeSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容超过15个字符</font>";
                return false;
            } else if (newThree.len() < 16) {
                document.getElementById("newThreeSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容不能少于8个字符</font>";
                return false;
            } else {
                document.getElementById("newThreeSpan").innerHTML = "";
                return true;
            }
        }


        //验证商家第四个公布信息
        function validatNewFour() {

            //将中文字符转换为两个字符
            String.prototype.len = function () {
                return this.replace(/[^\x00-\xff]/g, "rr").length;
            }

            var newFour = document.getElementById("newFourId").value;

            if (newFour.len() == 0) {//可以为空
                document.getElementById("newOneSpan").innerHTML = "";
                return true;
            } else if (newFour.len() > 30) {
                document.getElementById("newFourSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容超过15个字符</font>";
                return false;
            } else if (newFour.len() < 16) {
                document.getElementById("newFourSpan").innerHTML = "<font style='background:url(<%=request.getContextPath()%>/shop/shop_image/shopModifyShow/vali_error.gif) no-repeat left top' color='#ec4501'>&nbsp;&nbsp;&nbsp;输入内容不能少于8个字符</font>";
                return false;
            } else {
                document.getElementById("newFourSpan").innerHTML = "";
                return true;
            }
        }

        //第一次按修改按钮，提交表单增加公告内容
        function addNew() {

            with (document.getElementById("regForm")) {
                action = "<%=request.getContextPath()%>/addShopAnnouce.do?userId=${userId}";
                method = "post";
                if (validateForm()) {
                    submit();
                }
            }
        }

        //按修改按钮，提交表单修改公告内容
        function modifyNew() {

            with (document.getElementById("regForm")) {
                action = "<%=request.getContextPath()%>/modifyShopAnnouce.do?userId=${userId}";
                method = "post";
                if (validateForm()) {
                    submit();
                }
            }
        }


        //表单提交验证
        function validateForm() {
            return validatNewOne() && validatNewTwo() && validatNewThree() && validatNewFour();
        }

    </script>

    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        #modify_businfo {
            margin-top: 20px;
            margin-left: 33px;
        }

        #if_add {
            width: 600px;
            margin-top: 15px;
            margin-left: 50px;
            font-family: 宋体;
            font-size: 14px;
            color: #424242;
        }

        #addComplete {
            width: 600px;
            margin-left: 50px;
        }

        #addComplete div {
            margin-top: 15px;
            font-family: 宋体;
            font-size: 14px;
            color: #424242;
        }

        #modifyNewSuccess, #addAnnouceSuccess {
            height: 30px;
            margin-top: 15px;
            margin-left: 20px;
            font-family: 宋体;
            font-size: 14px;
            color: #FF7D7D;
        }


        #addDecorate, #updateDecorate {
            margin-left: 120px;
        }

        .new {
            width: 190px;
            color: #2D2D2D;
        }

        #if_add {
            padding-left: 12px;
        }

        #if_add a {
            text-decoration: none;
            color: #969696;
        }

        #if_add a:hover {
            color: #424242;
        }

        .new_condition {
            color: #CC0000;
            display: none;
        }

        .focus {
            border: #60C8FD 1px solid;
            background: #CEEFFF;
        }
    </style>
</head>

<body>
<div id="modify_businfo">
    <form id="regForm">
        <fieldset>
            <legend>店铺公告</legend>
            <div id="if_add"><span>你还没有添加店铺公告信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><a id="add" href="#">马上添加</a>
            </div>
            <div id="addComplete">
                <div>
                    <label>最新动态一：<span style="color: red;">*</span></label>
                    <input class="new" id="newOneId" type="text" name="newOne" maxlength="45"
                           value="${shopAnnouceList[0].content}" onBlur="validatNewOne()"/>&nbsp;<span
                        class="new_condition">第一条店铺公告不能为空，并且为16-30个字符</span><span id="newOneSpan"></span>
                </div>
                <div>
                    <label>最新动态二：&nbsp;</label>
                    <input class="new" id="newTwoId" type="text" name="newTwo" maxlength="45"
                           value="${shopAnnouceList[1].content}" onBlur="validatNewTwo()"/>&nbsp;<span
                        class="new_condition">请输入16-30个字符</span><span id="newTwoSpan"></span>
                </div>
                <div>
                    <label>最新动态三：&nbsp;</label>
                    <input class="new" id="newThreeId" type="text" name="newThree" maxlength="45"
                           value="${shopAnnouceList[2].content}" onBlur="validatNewThree()"/>&nbsp;<span
                        class="new_condition">请输入16-30个字符</span><span id="newThreeSpan"></span>
                </div>
                <div>
                    <label>最新动态四：&nbsp;</label>
                    <input class="new" id="newFourId" type="text" name="newFour" maxlength="45"
                           value="${shopAnnouceList[3].content}" onBlur="validatNewFour()"/>&nbsp;<span
                        class="new_condition">请输入16-30个字符</span><span id="newFourSpan"></span>
                </div>
                <div>
                    <input id="addDecorate" type="button" value="添加" onClick="addNew()"/>
                    <input id="updateDecorate" type="button" value="修改" onClick="modifyNew()"/>
                </div>
            </div>
            <div id="modifyNewSuccess">
                <span>修改信息成功,请先关闭窗口当前窗口，然刷新页面</span>
            </div>
            <div id="addAnnouceSuccess">
                <span>添加信息成功,请先关闭窗口当前窗口，然刷新页面</span>
            </div>
        </fieldset>
    </form>
</div>

</body>
</html>