package com.shop.controller;

import com.shop.service.ContactUsService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class ContactUsController {
    @Resource
    private ShopService shopService;
    @Resource
    private ContactUsService contactUsService;
//

    //
    //在店铺页点击修改导航栏的联系我们，根据用户Id号带数值显示联系我们信息
    @RequestMapping("/linkFindContactUsByUserId.do")
    public String linkFindContactUsByUserId(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        com.shop.entity.Shop shop = shopService.getShopByUserId(userId);
        request.setAttribute("shop", shop);
        request.setAttribute("userId", userId);
        return "shop/contact_us";
    }

    //
    //在店铺页点击修改导航栏的联系我们，根据用户Id号带数值去修改页面
    @RequestMapping("/findContactUsByUserId.do")
    public String findContactUsByUserId(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int userId = Integer.parseInt(request.getParameter("userId"));

        com.shop.entity.Shop shop = shopService.getShopByUserId(userId);

        request.setAttribute("userId", userId);

        request.setAttribute("shop", shop);

        return "/shop/shopModify/bussContact/modify_contact";
    }

    //在店铺页点击修改导航栏的联系我们
    @RequestMapping("/modifySContactUs.do")
    public String modifySContactUs(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

        if (user.getId() == userId) {

            String contactUs1 = request.getParameter("content");

            //输入文本文字数目
            String wordNum = request.getParameter("word");

            //禁掉js的情况
            if ("".equals(wordNum)) {

                if (contactUs1.length() <= 2000) {

                    //如果用户故意禁掉js，就不能使用html代码的样式了
                    String contactUs2 = contactUs1.replaceAll("<", "&lt");

                    String contactUs3 = contactUs2.replaceAll(">", "&gt");

                    String contactUs4 = contactUs3.replaceAll("&", "&amp;");

                    String contactUs5 = contactUs4.replaceAll(" ", "&nbsp");

                    String contactUs6 = contactUs5.replaceAll("\r\n", "<br>");

                    com.shop.entity.Shop shop = contactUsService.modifySContactUs(userId, contactUs6);

                    request.setAttribute("shop", shop);

                    request.setAttribute("updateContactUsSuccess", "updateContactUsSuccess");

                    return "/shop/shopModify/bussContact/modify_contact";

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
                    String contactUs2 = contactUs1.replaceAll("<script", "&ltscript");

                    String contactUs3 = contactUs2.replaceAll("</script>", "&lt/script&gt");

                    String contactUs4 = contactUs3.replaceAll("<frame", "&ltframe");

                    String contactUs5 = contactUs4.replaceAll("</frame>", "&lt/frame&gt");

                    String contactUs6 = contactUs5.replaceAll("<iframe", "&ltiframe");

                    String contactUs7 = contactUs6.replaceAll("</iframe>", "&lt/iframe&gt");

                    String contactUs8 = contactUs7.replaceAll("<form", "&ltform");

                    String contactUs9 = contactUs8.replaceAll("</form>", "&lt/form&gt");

                    //如果用户输入很长得字符串，通过设置地址栏，令wordNum小于2000，那么只能让字符串长度不超过数据库的字符串长度，防止出现500错误
                    if (contactUs9.length() <= 65535) {

                        com.shop.entity.Shop shop = contactUsService.modifySContactUs(userId, contactUs9);

                        request.setAttribute("shop", shop);

                        request.setAttribute("updateContactUsSuccess", "updateContactUsSuccess");
                        return "/shop/shopModify/bussContact/modify_contact";
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
