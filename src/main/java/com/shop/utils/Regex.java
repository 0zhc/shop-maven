package com.shop.utils;

public class Regex {


    //验证友情店铺链接名称
    private final static String LINKNAME_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{0,}$";

    //验证店铺友情链接网址
    private final static String LINKURL_EXPREG_STR = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";

    //验证用户名（只能用英文、数字或下划线，6-16个字符内）
    private final static String USERNAME_EXPREG_STR = "^[a-zA-Z0-9_]{6,16}$";
    //验证商家昵称(只能用中文、英文、数字或下划线,1-10字符)
    private final static String CALLNAME_EXPREG_STR = "^[\\u4E00-\\u9FA5\\uf900-\\ufa2d\\w]{1,10}$";
    //验证邮箱
    private final static String EMAIL_EXPREG_STR = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$";
    //验证"输入新密码"
    private final static String NEWPASSWORD_EXPREG_STR = "^\\w{6,16}$";
    //验证商家长号
    private final static String TELEPHONE_EXPREG_STR = "^1[3|4|5|8]\\d{9}$";
    //验证商家短号
    private final static String SHORtNUMBER_EXPREG_STR = "^6\\d{5}$";
    //验证QQ
    private final static String QQ_EXPREG_STR = "^[1-9]\\d{4,9}$";
    //验证店铺名称
    private final static String SHOPNAME_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{1,12}$";
    //验证商家地址
    private final static String SHOPADDRESS_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9\\.-]{3,30}$";
    //验证产品名称
    private final static String GOODNAME_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{1,20}$";
    //验证商品品牌
    private final static String BRADND_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{0,20}$";
    //验证商品尺寸
    private final static String GOODSIZE_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{0,10}$";
    //验证商品数量
    private final static String GOODAMOUNT_EXPREG_STR = "^[0-9]{1,4}$";
    //验证商品颜色
    private final static String GOODCOLOR_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z]{0,10}$";
    //验证商品产地
    private final static String GOODORIGIN_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{0,20}$";
    //验证商品毛重
    private final static String GOODWEIGHT_EXPREG_STR = "^[0-9]{0,10}$";
    //验证商品生产厂家
    private final static String GOODOADDRESS_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z0-9]{0,50}$";
    //验证商品数量单位
    private final static String GOODAMOUNTUNIT_EXPREG_STR = "^[\\u4E00-\\u9FA5\\a-zA-Z]{1,10}$";
    //验证商品价格
    private final static String GOODPRICE_EXPREG_STR = "^\\d+(\\.\\d+)?$";

    public static boolean validateUsername(String text) {

        return text.matches(USERNAME_EXPREG_STR);
    }

    public static boolean validatCallName(String text) {

        //String.getBytes().length取的是字节数，因为中文是全角字符，所以每个中文的字节数都为2
        byte[] bs = text.getBytes();

        int len = bs.length;

        if (len < 1 || len > 10) {
            return false;
        }

        return text.matches(CALLNAME_EXPREG_STR);
    }

    public static boolean validateEmail(String text) {

        return text.matches(EMAIL_EXPREG_STR);
    }

    public static boolean validateNewPassword(String text) {

        return text.matches(NEWPASSWORD_EXPREG_STR);
    }

    //验证"确认新密码"
    public static boolean validateConPassword(String text1, String text2) {

        if (text1.equals(text2)) {
            return true;
        }
        return false;
    }

    public static boolean validatTelephone(String text) {

        return text.matches(TELEPHONE_EXPREG_STR);
    }

    public static boolean validatShortNumber(String text) {

        if (text.length() == 0) {
            return true;
        }

        return text.matches(SHORtNUMBER_EXPREG_STR);
    }

    public static boolean validateQQ(String text) {

        return text.matches(QQ_EXPREG_STR);
    }

    //验证店铺第一条店铺公告(不能为空)
    public static boolean validatNewOne(String text) {

        //String.getBytes().length取的是字节数，因为中文是全角字符，所以每个中文的字节数都为2
        byte[] bs = text.getBytes();

        int len = bs.length;

        if (len < 16 || len > 30) {
            return false;
        }

        return true;
    }

    //验证店铺第二、三、四条店铺公告
    public static boolean validatNewTwoThreeFour(String text) {

        //String.getBytes().length取的是字节数，因为中文是全角字符，所以每个中文的字节数都为2
        byte[] bs = text.getBytes();

        int len = bs.length;

        if (len == 0) {

            return true;

        } else if (len < 16 || len > 30) {

            return false;
        }

        return true;
    }

    //验证商家第一条友情链接名称(不能为空)
    public static boolean validateoneLinkName(String text) {

        //String.getBytes().length取的是字节数，因为中文是全角字符，所以每个中文的字节数都为2
        byte[] bs = text.getBytes();

        int len = bs.length;

        if (len < 4 || len > 30) {
            return false;
        }

        return text.matches(LINKNAME_EXPREG_STR);
    }

    //验证商家第一条友情链接网址(不能为空)
    public static boolean validateoneLinkUrl(String text) {

        return text.matches(LINKURL_EXPREG_STR);
    }

    //验证商家第二、三条友情链接名称（可以为空）
    public static boolean validateTwoThreeLinkName(String text) {

        //String.getBytes().length取的是字节数，因为中文是全角字符，所以每个中文的字节数都为2
        byte[] bs = text.getBytes();

        int len = bs.length;

        if (len == 0) {
            return true;
        } else if (len < 4 || len > 30) {
            return false;
        }

        return text.matches(LINKNAME_EXPREG_STR);
    }

    //验证商家第二、三条友情链接网址(可以为空)
    public static boolean validateTwoThreeLinkUrl(String text) {

        //String.getBytes().length取的是字节数，因为中文是全角字符，所以每个中文的字节数都为2
        byte[] bs = text.getBytes();

        int len = bs.length;

        if (len == 0) {
            return true;
        }
        return text.matches(LINKURL_EXPREG_STR);
    }

    //验证文本(不为空)
    public static boolean validateText(String text, long textLen) {
        int len = text.length();
        if (len <= textLen && len > 0) {
            return true;
        }
        return false;
    }

    //验证文本(最小长度，最大长度)
    public static boolean validateText(String text, long minLen, long maxLen) {
        int len = text.length();
        if (len <= maxLen && len >= minLen) {
            return true;
        }
        return false;
    }

    //验证单选框
    public static boolean validateRadio(Integer radio) {
        if (radio == 1 || radio == 2) {
            return true;
        }
        return false;
    }

    public static boolean validateShopName(String text) {
        return text.matches(SHOPNAME_EXPREG_STR);
    }

    public static boolean validateShopAddress(String text) {
        return text.matches(SHOPADDRESS_EXPREG_STR);
    }

    public static boolean validateGoodName(String text) {
        return text.matches(GOODNAME_EXPREG_STR);
    }

    public static boolean validateBrand(String text) {
        return text.matches(BRADND_EXPREG_STR);
    }

    public static boolean validateGoodSize(String text) {
        return text.matches(GOODSIZE_EXPREG_STR);
    }

    public static boolean validateGoodAmount(String text) {
        return text.matches(GOODAMOUNT_EXPREG_STR);
    }

    public static boolean validateGoodColor(String text) {
        return text.matches(GOODCOLOR_EXPREG_STR);
    }

    public static boolean validateGoodOrigin(String text) {
        return text.matches(GOODORIGIN_EXPREG_STR);
    }

    public static boolean validateGoodWeight(String text) {
        return text.matches(GOODWEIGHT_EXPREG_STR);
    }

    public static boolean validateGoodAddress(String text) {
        return text.matches(GOODOADDRESS_EXPREG_STR);
    }

    public static boolean validateGoodAmountUnit(String text) {
        return text.matches(GOODAMOUNTUNIT_EXPREG_STR);
    }

    public static boolean validateGoodPrice(String text) {
        if (Float.parseFloat(text) > 10000) {
            return false;
        }
        return text.matches(GOODPRICE_EXPREG_STR);
    }

}