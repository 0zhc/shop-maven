$(function () {
    // alert($(".prolist_content ul li").eq(0).width());
    //  alert($("h3").eq(0).height()+$(".prolist_content").height());
    /*新款上市模块横向滚动*/
    $(".goLeft,.goRight").fadeTo(0, 0.5);

    $(".prolist_content ul li").each(function (index) {
        if (index % 3 == 0) {
            $(this).css("border-left", "none");

        }

    });
    $(".prolist_content ul li").hover(function () {
        $(this).children("span").css("color", "#4b4a4a")
    }, function () {
        $(this).children("span").css("color", "#9c9c9c")
    });
    $(function () {
        var page = 1;
        var i = 4; //每版放4个图片
        var len = $(".prolist_content ul li").length;
        var page_count = Math.ceil(len / i);   //只要不是整数，就往大的方向取最小的整数
        var none_unit_width = $(".prolist").width(); //获取框架内容的宽度,不带单位
        var $parent = $(".prolist_content");
        //向右 按钮
        $(".goRight,.goLeft").hover(function () {
            $(this).fadeTo(0, 1);
        }, function () {
            $(this).fadeTo(0, 0.7);

        }).css("cursor", "pointer");


        $(".goRight").click(function () {
            if (!$parent.is(":animated")) {
                if (page == page_count) {  //已经到最后一个版面了,如果再向后，必须跳转到第一个版面。
                    $parent.animate({left: 0}, 800); //通过改变left值，跳转到第一个版面
                    page = 1;
                } else {
                    $parent.animate({left: '-=' + none_unit_width}, 800);  //通过改变left值，达到每次换一个版面
                    page++;
                }
            }
        });
        //往左 按钮
        $(".goLeft").click(function () {
            if (!$parent.is(":animated")) {
                if (page == 1) {  //已经到第一个版面了,如果再向前，必须跳转到最后一个版面。
                    $parent.animate({left: '-=' + none_unit_width * (page_count - 1)}, 800); //通过改变left值，跳转到最后一个版面
                    page = page_count;
                } else {
                    $parent.animate({left: '+=' + none_unit_width}, 800);  //通过改变left值，达到每次换一个版面
                    page--;
                }
            }
        });
    });


});