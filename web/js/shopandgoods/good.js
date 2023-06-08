// JavaScript Document
$(function () {
    $("#sortPrice").hover(function () {
        $(".sort").show();
        $(this).children("a").css("background-image", "url(" + path + "/images/index/tip.jpg)");
    }, function () {
        $(this).children("a").css("background-image", "url(" + path + "/images/index/tip1.jpg)");
        $(".sort").hide();
    });

});