package com.shop.controller;


import com.shop.entity.Shop;
import com.shop.entity.ShopAnnouce;
import com.shop.service.ShopAnnouceService;
import com.shop.service.ShopService;
import com.shop.utils.Regex;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class ShopAnnouceController {

    @Resource
    private ShopAnnouceService shopAnnouceService;

    @Resource
    private ShopService shopService;


    //在店铺页第一次点击修改，增加店铺公告
    @RequestMapping("/addShopAnnouce.do")
    public String addShopAnnouce(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        String newOne = request.getParameter("newOne");
        String newTwo = request.getParameter("newTwo");
        String newThree = request.getParameter("newThree");
        String newFour = request.getParameter("newFour");

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer id = shopByUserId.getId();

        if (user.getId() == userId) {

            //进行服务器验证
            boolean flag = Regex.validatNewOne(newOne)
                    && Regex.validatNewTwoThreeFour(newTwo)
                    && Regex.validatNewTwoThreeFour(newThree)
                    && Regex.validatNewTwoThreeFour(newFour);
            if (!flag) {
                return "/illegality";
            }

            List<ShopAnnouce> shopAnnouceList = shopAnnouceService.addShopAnnouce(id, newOne, newTwo, newThree, newFour);
//		List<ShopAnnouce> newByShopId = shopAnnouceService.findNewByShopId(id);
//		Set<ShopAnnouce> shopAnnouceSet = new HashSet(0);
//		if (newByShopId!=null){
//			for (int i =0;i<newByShopId.size();i++){
//				ShopAnnouce shopAnnouce = newByShopId.get(i);
//				shopAnnouceSet.add(shopAnnouce);
//			}
//			shopByUserId.setShopAnnouces(shopAnnouceSet);
//		}
//
//
////		System.out.println("++++++++++"+shop.getUserId()+"----------");
////		System.out.println("++++++++++"+shop.getTemplate()+"----------");
//		user.setShop(shopByUserId);
//		request.setAttribute("userNew", user);

            request.setAttribute("shopAnnouceList", shopAnnouceList);

            request.setAttribute("AddNewSuccess", "AddNewSuccess");

            return "/shop/shopModify/shopmodify_left/modify_new";

        } else {
            return "/illegality";

        }
    }

    //	//在店铺页点击修改店铺公告，根据用户Id号带数值去修改页面
    @RequestMapping("/findNewByUserId.do")
    public String findNewByUserId(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));
//		com.shop.entity.User userById = userService.getUserById(userId);
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer id = shopByUserId.getId();


//		List<ShopAnnouce> shopAnnouceList = shopAnnouceService.findNewByUserId(userId);
        List<ShopAnnouce> shopAnnouceList = shopAnnouceService.findNewByShopId(id);


        request.setAttribute("shopAnnouceList", shopAnnouceList);

        request.setAttribute("userId", userId);

        return "/shop/shopModify/shopmodify_left/modify_new";
    }

    //在店铺页点击修改店铺公告
    @RequestMapping("/modifyShopAnnouce.do")
    public String modifyShopAnnouce(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        int userId = Integer.parseInt(request.getParameter("userId"));

        String newOne = request.getParameter("newOne");
        String newTwo = request.getParameter("newTwo");
        String newThree = request.getParameter("newThree");
        String newFour = request.getParameter("newFour");

        //判读session范围的用户和request范围的用户是否相同
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer id = shopByUserId.getId();

        if (user.getId() == userId) {

            //进行服务器验证
            boolean flag = Regex.validatNewOne(newOne)
                    && Regex.validatNewTwoThreeFour(newTwo)
                    && Regex.validatNewTwoThreeFour(newThree)
                    && Regex.validatNewTwoThreeFour(newFour);
            if (!flag) {
                return "/illegality";

            }


            List<ShopAnnouce> shopAnnouceList = shopAnnouceService.modifyShopAnnouce(id, newOne, newTwo, newThree, newFour);

            request.setAttribute("shopAnnouceList", shopAnnouceList);

            request.setAttribute("updateNewSuccess", "updateNewSuccess");

            return "/shop/shopModify/shopmodify_left/modify_new";

        } else {
            //session范围的用户Id和request范围的用户id不同的非法操作
            return "/illegality";

        }
    }

}
