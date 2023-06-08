package com.shop.controller;

import com.shop.service.DeliverScopeService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class DeliverScopeController {
    //
    @Resource
    private DeliverScopeService deliverScopeService;
    @Resource
    private ShopService shopService;
//

    //在店铺页点击修改导航栏的配送范围，根据用户Id号带数值显示配送范围信息
    @RequestMapping("/linkFindScopeByUserId.do")
    public String linkFindScopeByUserId(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));

        com.shop.entity.Shop shop = shopService.getShopByUserId(userId);

        request.setAttribute("userId", userId);

        request.setAttribute("shop", shop);

        return "shop/pro_scope";
    }

    //在店铺页点击修改导航栏的配送范围，根据用户Id号带数值去修改页面
    @RequestMapping("/findScopeByUserId.do")
    public String findScopeByUserId(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        com.shop.entity.Shop shop = shopService.getShopByUserId(userId);

        request.setAttribute("userId", userId);

        request.setAttribute("shop", shop);

        return "/shop/shopModify/scope/modify_scope";
    }

    //在店铺页点击修改导航栏的配送范围
    @RequestMapping("/modifyShopScope.do")
    public String modifyShopScope(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

        if (user.getId() == userId) {

            String deliverScope1 = request.getParameter("content");

            //输入文本文字数目
            String wordNum = request.getParameter("word");

            //禁掉js的情况
            if ("".equals(wordNum)) {


                if (deliverScope1.length() <= 2000) {

                    //如果用户故意禁掉js，就不能使用html代码的样式了
                    String deliverScope2 = deliverScope1.replaceAll("<", "&lt");

                    String deliverScope3 = deliverScope2.replaceAll(">", "&gt");

                    String deliverScope4 = deliverScope3.replaceAll("&", "&amp;");

                    String deliverScope5 = deliverScope4.replaceAll(" ", "&nbsp");

                    String deliverScope6 = deliverScope5.replaceAll("\r\n", "<br>");

                    com.shop.entity.Shop shop = deliverScopeService.modifyShopScope(userId, deliverScope6);

                    request.setAttribute("shop", shop);

                    request.setAttribute("updateScopeSuccess", "updateScopeSuccess");

                    return "/shop/shopModify/scope/modify_scope";
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
                    String deliverScope2 = deliverScope1.replaceAll("<script", "&ltscript");

                    String deliverScope3 = deliverScope2.replaceAll("</script>", "&lt/script&gt");

                    String deliverScope4 = deliverScope3.replaceAll("<frame", "&ltframe");

                    String deliverScope5 = deliverScope4.replaceAll("</frame>", "&lt/frame&gt");

                    String deliverScope6 = deliverScope5.replaceAll("<iframe", "&ltiframe");

                    String deliverScope7 = deliverScope6.replaceAll("</iframe>", "&lt/iframe&gt");

                    String deliverScope8 = deliverScope7.replaceAll("<form", "&ltform");

                    String deliverScope9 = deliverScope8.replaceAll("</form>", "&lt/form&gt");

                    //如果用户输入很长得字符串，通过设置地址栏，令wordNum小于2000，那么只能让字符串长度不超过数据库的字符串长度，防止出现500错误
                    if (deliverScope9.length() <= 65535) {

                        com.shop.entity.Shop shop = deliverScopeService.modifyShopScope(userId, deliverScope9);

                        request.setAttribute("shop", shop);

                        request.setAttribute("updateScopeSuccess", "updateScopeSuccess");

                        return "/shop/shopModify/scope/modify_scope";

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
