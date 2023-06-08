//验证用户名
function userNameChect() {

    var reg = /^[a-zA-Z0-9_]{6,16}$/;
    var userName = $("#userName").val();

    if (!reg.test(userName)) {
        $("#errorTip").css("visibility", "visible");
        $("#un_pw_error").html("");
        $("#userNameTip").html('<font color="red">不能为空，英文、数字或下划线，6-16个字符</font>');
        return false;
    } else {
        $("#errorTip").css("visibility", "hidden");
        $("#un_pw_error").html("");
        $("#userNameTip").html("");
        return true;
    }
}

//密码验证
function userPasswordCheck() {

    var reg = /^[a-zA-Z0-9_]{6,16}$/;
    var userPassword = $("#userPassword").val();

    if (!reg.test(userPassword)) {
        $("#userPasswordTip").html('不能为空，英文、数字或下划线，6-16个字符');
        return false;
    } else {
        $("#userPasswordTip").html("");
        return true;
    }

}

//记住密码
$(function () {

    if ($.cookie("userName") != null) {
        $("#userName").val($.cookie("userName"));
    }

    if ($.cookie("userPassword") != null) {
        $("#userPassword").val($.cookie("userPassword"));
    }

    $("#rememberPW").val($.cookie("rememberPW"));

    if ($("#rememberPW").val() == "1") {
        $("#checkPW").attr("checked", true);

    } else {
        $("#checkPW").attr("checked", false);
    }

    //点击选中记住密码，设置cookie到客户端
    $("#checkPW").click(function () {
        if ($("#checkPW").is(":checked")) {
            $.cookie("userName", $("#userName").val(), {path: '/', expires: 7});
            $.cookie("userPassword", $("#userPassword").val(), {path: '/', expires: 7});
            //点击选中记住密码时，给隐藏域rememberPW赋值为1
            $.cookie("rememberPW", "1", {path: '/', expires: 7});
        } else {
            //用户名默认设置到客户端得到cookie里的
            //$.cookie("userName", null, { path: '/', expires: 7 });
            $.cookie("userPassword", null, {path: '/', expires: 7});
            //点击取消选中"记住密码"时，给隐藏域rememberPW赋值为2
            $.cookie("rememberPW", "2", {path: '/', expires: 7});
        }
    });

});

	
