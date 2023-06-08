package com.shop.controller;


import com.shop.service.ShopInfoService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class ShopInfoCintroller {
    //
    @Resource
    private ShopInfoService shopInfoService;
    @Resource
    private ShopService shopService;
//

    //在店铺页点击修改导航栏的商家介绍，根据用户Id号显示商家介绍信息
    @RequestMapping("/linkFindBussIntroByUserId.do")
    public String linkFindBussIntroByUserId(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        com.shop.entity.Shop shop = shopService.getShopByUserId(userId);
        request.setAttribute("shop", shop);
        request.setAttribute("userId", userId);
        return "shop/businessman";
    }

    //
//	//在店铺页点击修改导航栏的商家介绍，根据用户Id号带数值去修改页面
    @RequestMapping("/findBussIntroByUserId.do")
    public String findBussIntroByUserId(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        com.shop.entity.Shop shop = shopService.getShopByUserId(userId);

        request.setAttribute("shop", shop);

        request.setAttribute("userId", userId);

        return "/shop/shopModify/bussInfo/modify_bussIntro";
    }

    //
//	//在店铺页点击修改导航栏的商家介绍
    @RequestMapping("/modifyShopIntro.do")
    public String modifyShopIntro(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (user.getId() == userId) {


            String shopInfoText1 = request.getParameter("content");

            //输入文本文字数目
            String wordNum = request.getParameter("word");


            //禁掉js的情况
            if ("".equals(wordNum)) {

                if (shopInfoText1.length() <= 2000) {

                    //如果用户故意禁掉js，就不能使用html代码的样式了
                    String shopInfoText2 = shopInfoText1.replaceAll("<", "&lt");

                    String shopInfoText3 = shopInfoText2.replaceAll(">", "&gt");

                    String shopInfoText4 = shopInfoText3.replaceAll("&", "&amp;");

                    String shopInfoText5 = shopInfoText4.replaceAll(" ", "&nbsp");

                    String shopInfoText6 = shopInfoText5.replaceAll("\r\n", "<br>");

                    com.shop.entity.Shop shop = shopInfoService.modifyShopIntro(userId, shopInfoText6);

                    request.setAttribute("shop", shop);

                    request.setAttribute("updateShopIntroSuccess", "updateShopIntroSuccess");

                    return "/shop/shopModify/bussInfo/modify_bussIntro";
                } else {

                    return "/illegality";

                }
            } else {//没有禁掉js的情况

                if (Integer.parseInt(wordNum) <= 2000) {


                    /**
                     * 富文本框已经对输入的内容进行过滤，但为了防止用户点击“查看html代码”按钮输入以下非法代码，所有要进行以下过滤。
                     *
                     * 因为“查看html代码”按钮是不能去掉的，否则用户输入的“被过滤的非法代码”不能去掉
                     */
                    String shopInfoText2 = shopInfoText1.replaceAll("<script", "&ltscript");

                    String shopInfoText3 = shopInfoText2.replaceAll("</script>", "&lt/script&gt");

                    String shopInfoText4 = shopInfoText3.replaceAll("<frame", "&ltframe");

                    String shopInfoText5 = shopInfoText4.replaceAll("</frame>", "&lt/frame&gt");

                    String shopInfoText6 = shopInfoText5.replaceAll("<iframe", "&ltiframe");

                    String shopInfoText7 = shopInfoText6.replaceAll("</iframe>", "&lt/iframe&gt");

                    String shopInfoText8 = shopInfoText7.replaceAll("<form", "&ltform");

                    String shopInfoText9 = shopInfoText8.replaceAll("</form>", "&lt/form&gt");

                    //如果用户输入很长得字符串，通过设置地址栏，令wordNum小于2000，那么只能让字符串长度不超过数据库的字符串长度，防止出现500错误
                    if (shopInfoText9.length() <= 65535) {

                        com.shop.entity.Shop shop = shopInfoService.modifyShopIntro(userId, shopInfoText9);

                        request.setAttribute("shop", shop);

                        request.setAttribute("updateShopIntroSuccess", "updateShopIntroSuccess");

                        return "/shop/shopModify/bussInfo/modify_bussIntro";
                    } else {
                        return "/illegality";

                    }
                } else {

                    return "/illegality";

                }

            }


        } else {

            //session范围的用户Id和request范围的用户id不同的非法操作
            return "/illegality";

        }

    }

}
