package com.shop.controller;


import com.shop.entity.Friendlink;
import com.shop.entity.Shop;
import com.shop.service.FriendlinkService;
import com.shop.service.ShopService;
import com.shop.utils.Regex;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class FriendlinkController {
    @Resource
    private ShopService shopService;

    @Resource
    private FriendlinkService friendlinkService;

    //
//	public void setFriendlinkService(FriendlinkService friendlinkService) {
//		this.friendlinkService = friendlinkService;
//	}
//
//	//在店铺页第一次点击修改，增加店铺公告
    @RequestMapping("/addFriendLink.do")
    public String addFriendLink(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer shopId = shopByUserId.getId();

        String oneLinkName = request.getParameter("oneLinkName");
        String oneLinkUrl = request.getParameter("oneLinkUrl");
        String twoLinkName = request.getParameter("twoLinkName");
        String twoLinkUrl = request.getParameter("twoLinkUrl");
        String threeLinkName = request.getParameter("threeLinkName");
        String threeLinkUrl = request.getParameter("threeLinkUrl");

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

        if (user.getId() == userId) {

            //进行服务器验证
            boolean flag = Regex.validateoneLinkName(oneLinkName)
                    && Regex.validateoneLinkUrl(oneLinkUrl)
                    && Regex.validateTwoThreeLinkName(twoLinkName)
                    && Regex.validateTwoThreeLinkUrl(twoLinkUrl)
                    && Regex.validateTwoThreeLinkName(threeLinkName)
                    && Regex.validateTwoThreeLinkUrl(threeLinkUrl);
            if (!flag) {
                return "/illegality";

            }

            List<Friendlink> friendlinkList = friendlinkService.addFriendLink(shopId, oneLinkName, oneLinkUrl, twoLinkName, twoLinkUrl, threeLinkName, threeLinkUrl);

            request.setAttribute("friendlinkList", friendlinkList);

            request.setAttribute("AddLinkSuccess", "AddLinkSuccess");

            return "/shop/shopModify/shopmodify_left/modify_fridenlink";
        } else {
            return "/illegality";
        }
    }

    //
//	//在店铺页点击修改友情链接，根据用户Id号带数值去修改页面
    @RequestMapping("/findFriendlinkByUserId.do")
    public String findFriendlinkByUserId(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer id = shopByUserId.getId();


        List<Friendlink> friendlinkList = friendlinkService.findFriendlinkByShopId(id);

        request.setAttribute("friendlinkList", friendlinkList);

        request.setAttribute("userId", userId);

        return "/shop/shopModify/shopmodify_left/modify_fridenlink";
    }

    //
//
//	//在店铺页点击修改友情链接
    @RequestMapping("/modifyFriendlink.do")
    public String modifyFriendlink(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer shopId = shopByUserId.getId();

        String oneLinkName = request.getParameter("oneLinkName");
        String oneLinkUrl = request.getParameter("oneLinkUrl");
        String twoLinkName = request.getParameter("twoLinkName");
        String twoLinkUrl = request.getParameter("twoLinkUrl");
        String threeLinkName = request.getParameter("threeLinkName");
        String threeLinkUrl = request.getParameter("threeLinkUrl");

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

        if (user.getId() == userId) {

            //进行服务器验证
            boolean flag = Regex.validateoneLinkName(oneLinkName)
                    && Regex.validateoneLinkUrl(oneLinkUrl)
                    && Regex.validateTwoThreeLinkName(twoLinkName)
                    && Regex.validateTwoThreeLinkUrl(twoLinkUrl)
                    && Regex.validateTwoThreeLinkName(threeLinkName)
                    && Regex.validateTwoThreeLinkUrl(threeLinkUrl);

            if (!flag) {
                return "/illegality";

            }

            List<Friendlink> friendlinkList = friendlinkService.modifyFriendlink(shopId, oneLinkName, oneLinkUrl, twoLinkName, twoLinkUrl, threeLinkName, threeLinkUrl);

            request.setAttribute("friendlinkList", friendlinkList);

            request.setAttribute("updateLinkSuccess", "updateLinkSuccess");

            return "/shop/shopModify/shopmodify_left/modify_fridenlink";

        } else {
            //session范围的用户Id和request范围的用户id不同的非法操作
            return "/illegality";

        }
    }
}
