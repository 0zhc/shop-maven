package com.shop.utils;

public class TextFilterUtil {

    public static String replaceIllegalCode(String text) {

        /**
         * 富文本框已经对输入的内容进行过滤，但为了防止用户点击“查看html代码”按钮输入以下非法代码，所有要进行以下过滤。
         *
         * 因为“查看html代码”按钮是不能去掉的，否则用户输入的“被过滤的非法代码”不能去掉
         */
        String text2 = text.replaceAll("<script", "&ltscript");

        String text3 = text2.replaceAll("</script>", "&lt/script&gt");

        String text4 = text3.replaceAll("<frame", "&ltframe");

        String text5 = text4.replaceAll("</frame>", "&lt/frame&gt");

        String text6 = text5.replaceAll("<iframe", "&ltiframe");

        String text7 = text6.replaceAll("</iframe>", "&lt/iframe&gt");

        String text8 = text7.replaceAll("<form", "&ltform");

        String text9 = text8.replaceAll("</form>", "&lt/form&gt");

        return text9;
    }

    public static String replaceCode(String text) {
        //如果用户故意禁掉js，就不能使用html代码的样式了
        String text2 = text.replaceAll("<", "&lt");

        String text3 = text2.replaceAll(">", "&gt");

        String text4 = text3.replaceAll("&", "&amp;");

        String text5 = text4.replaceAll(" ", "&nbsp;");

        String text6 = text5.replaceAll("\r\n", "<br>");

        return text6;
    }

}
