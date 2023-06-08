$(function () {
    $("#collect_file").css("background-image", "none");
    $("#trade_record,#collect_file").hover(function () {
            $(this).children("ul").fadeIn(600);
            $(this).children("a").css("background-image", "url(images/index/tip1.jpg)");
        },
        function () {
            $(this).children("ul").stop(true, true).hide();
            $(this).children("a").css("background-image", "url(images/index/tip.jpg)");

        });


    $("#studentAgencies").hover(function () {
            $(this).children("ul").slideDown(600);
        },

        function () {
            $(this).children("ul").stop(true, true).hide();

        });

    $("#good_introduce_left_middle ul li p span:even").addClass("firstSpan").css("color", "#9c9c9c");
    $("#ratherPrice_middle ul li p span:even").addClass("firstSpan").css("color", "#9c9c9c");
    $("#newGoods_middle	 ul li p span:even").addClass("firstSpan").css("color", "#9c9c9c");

    $("#good_introduce_right_middle ul li div:first-child").addClass("good_introduce_right_first_div");

    $("#hotTopic_middle ul li").hover(function () {
        $(this).css("color", "#048bd6");
    }, function () {
        $(this).css("color", "#9c9c9c");
    }).css("cursor", "pointer");
    $("#hotTopic_middle ul li a").mouseover(function () {
        $("#hotTopic_middle ul li a").children("img").stop(true, true).hide();
        $(this).children("img").fadeIn();
    });
    $("#studentNewMidlle ul li ").hover(function () {
        $("#studentNewMidlle ul li").children("img").stop(true, true).hide();
        $(this).children("img").fadeIn();
    }, function () {
        $(this).children("img").stop(true, true).hide();


    });

    $("#search_main_top ul li").click(function () {
        $("#search_main_top ul li").removeClass("search_top_hover");
        $(this).addClass("search_top_hover");

    });


})


//֧��ͼƬ������

$(function () {

    $("#shop_introduce img,good_introduce img").lazyload({
        placeholder: "images/load/grey.gif",

        effect: "fadeIn"
    });


});