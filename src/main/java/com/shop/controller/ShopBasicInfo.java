package com.shop.controller;

import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.service.ShopBasicInfoService;
import com.shop.service.ShopService;
import com.shop.service.UserService;
import com.shop.utils.Regex;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
public class ShopBasicInfo {

    @Resource
    private ShopBasicInfoService shopBasicInfoService;
    @Resource
    private ShopService shopService;
    @Resource
    private UserService userService;

    //
//	//在店铺页点击修改店主个人信息时，根据用户Id号带数值去修改页面
    @RequestMapping("/findUserById.do")
    public String findUserById(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        //设置一个request范围的User对象
        com.shop.entity.User userRequest = shopBasicInfoService.findUserById(userId);

        request.setAttribute("userRequest", userRequest);

        request.setAttribute("userId", userId);

        return "/shop/shopModify/shopmodify_left/modify_businfo";
    }

    //
//	//在店铺页点击修改店主个人信息
    @RequestMapping("/modifyUserInfo.do")
    public String modifyUserInfo(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String callName = request.getParameter("callName");
        String telephone = request.getParameter("telephone");
        String shortNumber = request.getParameter("shortNumber");
        String qq = request.getParameter("qq");


//		UserForm userForm = (UserForm)form;

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

        if (user.getId() == id) {

            //进行服务器验证
//		boolean flag = Regex.validatCallName(userForm.getCallName())
//						&&Regex.validatTelephone(userForm.getTelephone())
//						&&Regex.validatShortNumber(userForm.getShortNumber())
//						&&Regex.validateQQ(userForm.getQq());
            boolean flag = Regex.validatCallName(callName)
                    && Regex.validatTelephone(telephone)
                    && Regex.validatShortNumber(shortNumber)
                    && Regex.validateQQ(qq);

            if (!flag) {
                return "/illegality";
            }

            com.shop.entity.User user1 = new com.shop.entity.User();
//		user1.setId(userForm.getId());
//		user1.setCallName(userForm.getCallName());
//		user1.setTelephone(userForm.getTelephone());
//		user1.setShortNumber(userForm.getShortNumber());
//		user1.setQq(userForm.getQq());

            user1.setId(id);
            user1.setCallName(callName);
            user1.setTelephone(telephone);
            user1.setShortNumber(shortNumber);
            user1.setQq(qq);

            shopBasicInfoService.modifyUserInfo(user1);

            request.setAttribute("userRequest", user1);

            request.setAttribute("updateUserInfoSuccess", "updateUserINfoSuccess");

            return "/shop/shopModify/shopmodify_left/modify_businfo";


        } else {
            //session范围的用户Id和request范围的用户id不同的非法操作
            return "/illegality";
        }

    }

    //	//在店铺页点击修改店铺名称时，根据用户Id号带数值去修改页面
    @RequestMapping("/shopNameByuserId.do")
    public String shopNameByuserId(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        //设置一个request范围的User对象
//		Shop shop = shopBasicInfoService.shopNameByuserId(userId);

        Shop shop = shopService.getShopByUserId(userId);
        Integer userId1 = shop.getUserId();
        User userById = userService.getUserById(userId1);
        shop.setUser(userById);

        request.setAttribute("shop", shop);

        request.setAttribute("userId", userId);

        return "/shop/shopModify/shopmodify_left/modify_shopName";

    }

    //
//	//在店铺页点击修改店铺名称
    @RequestMapping("/modifyShopName.do")
    public String modifyShopName(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

//		UserForm userForm = (UserForm)form;
//
//		int userId = userForm.getId();
        int userId = Integer.parseInt(request.getParameter("id"));
        String shopName = request.getParameter("shopName");


        //判读session范围的用户和request范围的用户是否相同
        User user = (User) request.getSession().getAttribute("user");
        if (user.getId() == userId) {

            //进行服务器验证
            boolean flag = Regex.validateShopName(shopName);

            if (!flag) {
                return "/illegality";
            }


            com.shop.entity.Shop shop = shopBasicInfoService.modifyShopName(userId, shopName);

            request.setAttribute("shop", shop);

            request.setAttribute("updateShopNameSuccess", "updateShopNameSuccess");

            return "/shop/shopModify/shopmodify_left/modify_shopName";


        } else {
            //session范围的用户Id和request范围的用户id不同的非法操作
            return "/illegality";

        }

    }

}
