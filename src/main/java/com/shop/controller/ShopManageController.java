package com.shop.controller;


import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.service.ShopManageService;
import com.shop.service.UserService;
import com.shop.utils.Pager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class ShopManageController {
    @Resource
    private ShopManageService shopManageService;
    @Resource
    private UserService userService;

    //后台超级管理员点击“经营店铺管理”查看所有商家经营的店铺
    @RequestMapping("/findAllshopManage.do")
    public String findAllshopManage(HttpServletRequest request, HttpServletResponse response) {

        int totalRecords = shopManageService.shopManagetCount("", "", "", "");//根据条件查询共有多少条记录

        //从manager_index.jsp传过来的值为1的currentpage，
        int currentPage = Integer.parseInt(request.getParameter("currentpage"));

        int everyPageRecords = 6;//设置每页显示6条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法

        List<com.shop.entity.Shop> shopList = shopManageService.findAllshopManage(pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (Shop shop : shopList) {
            Integer userId = shop.getUserId();
            User userById = userService.getUserById(userId);
            shop.setUser(userById);
        }

        request.setAttribute("shopList", shopList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("shopName", "");
        request.setAttribute("shopUser", "");
        request.setAttribute("datetime1", "");
        request.setAttribute("datetime2", "");

        return "system/shopManage/shopManager";

    }

    //后台超级管理员查看“经营店铺管理”模块，按条件查询符合条件的店铺
    @RequestMapping("/shopManagerSelectAllShop.do")
    public String shopManagerSelectAllShop(HttpServletRequest request, HttpServletResponse response) {
        String shopName = request.getParameter("shopName").replaceAll(" \\s*", "");
        String shopUser = request.getParameter("shopUser").replaceAll(" \\s*", "");

        String datetime1 = request.getParameter("datetime1");
        String datetime2 = request.getParameter("datetime2");

        int totalRecords = shopManageService.shopManagetCount(shopName, shopUser, datetime1, datetime2);//根据条件查询共有多少条记录

        //一开始从隐藏域传过来的当前页为1
        int currentPage = Integer.parseInt(request.getParameter("currentpage"));
        int everyPageRecords = 6;//设置每页显示6条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法

        List<Shop> shopList = shopManageService.shopManagerSelectAllShop(shopName, shopUser, datetime1, datetime2, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (Shop shop : shopList) {
            Integer userId = shop.getUserId();
            User userById = userService.getUserById(userId);
            shop.setUser(userById);
        }

        request.setAttribute("shopList", shopList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("shopName", shopName);
        request.setAttribute("shopUser", shopUser);
        request.setAttribute("datetime1", datetime1);
        request.setAttribute("datetime2", datetime2);

        //按条件查询成功后返回查询页面
        return "system/shopManage/shopManager";
    }

    //后台超级管理员点击“经营店铺管理”，删除（关闭违法店铺）商家的店铺（改状态）
    @RequestMapping("/shopManageDeleteByShopId.do")
    public String shopManageDeleteByShopId(HttpServletRequest request, HttpServletResponse response) {

        int shopId = Integer.parseInt(request.getParameter("shopId"));
        shopManageService.shopManageDeleteByShopId(shopId);
        //删除成功后返回查询页面(第一页)
        int currentPage = 1;
        int everyPageRecords = 6;//设置每页显示6条记录
        int totalRecords = shopManageService.shopManagetCount("", "", "", "");//根据条件查询共有多少条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
        List<Shop> shopList = shopManageService.findAllshopManage(pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (Shop shop : shopList) {
            Integer userId = shop.getUserId();
            User userById = userService.getUserById(userId);
            shop.setUser(userById);
        }
        request.setAttribute("shopList", shopList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("shopName", "");
        request.setAttribute("shopUser", "");
        request.setAttribute("datetime1", "");
        request.setAttribute("datetime2", "");


        return "system/shopManage/shopManager";
    }

    //后台超级管理员点击“经营店铺管理”，全选删除（关闭违法店铺）商家的店铺（改状态）
    @RequestMapping("/shopManagerDeleteAllShop.do")
    public String shopManagerDeleteAllShop(HttpServletRequest request, HttpServletResponse response) {
        String[] shopAllId = request.getParameterValues("selectFlag");
        for (int i = 0; i < shopAllId.length; i++) {
            int id = Integer.parseInt(shopAllId[i]);
            shopManageService.shopManageDeleteByShopId(id);
        }

//		shopManageService.shopManagerDeleteAllShop(shopAllId);

        //删除成功后返回查询页面(第一页)
        int currentPage = 1;
        int everyPageRecords = 6;//设置每页显示6条记录
        int totalRecords = shopManageService.shopManagetCount("", "", "", "");//根据条件查询共有多少条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
        List<Shop> shopList = shopManageService.findAllshopManage(pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (Shop shop : shopList) {
            Integer userId = shop.getUserId();
            User userById = userService.getUserById(userId);
            shop.setUser(userById);
        }


        request.setAttribute("shopList", shopList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("shopName", "");
        request.setAttribute("shopUser", "");
        request.setAttribute("datetime1", "");
        request.setAttribute("datetime2", "");

        return "system/shopManage/shopManager";

    }


}
