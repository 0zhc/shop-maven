package com.shop.controller;

import com.shop.entity.Shop;
import com.shop.service.CollectionShopService;
import com.shop.service.ShopService;
import com.shop.utils.Pager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@Controller
public class CollectionShop {
    @Resource
    private CollectionShopService collectionShopService;
    @Resource
    private ShopService shopService;
//

    //后台收藏管理点击“店铺”查看收藏的所有店铺
    @RequestMapping("/collectionShopFindByUserId.do")
    public String collectionShopFindByUserId(HttpServletRequest request, HttpServletResponse response) {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int totalRecords = collectionShopService.collectionShopCountByUserId(userId);//根据条件查询共有多少条记录
        //从manager_index.jsp传过来的值为1的currentpage，
        int currentPage = Integer.parseInt(request.getParameter("currentpage"));

        int everyPageRecords = 6;//设置每页显示6条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法


        List<com.shop.entity.CollectionShop> collectionShopList = collectionShopService.collectionShopFindByUserId(userId, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (com.shop.entity.CollectionShop collectionShop : collectionShopList) {
            Integer shopsId = collectionShop.getShopsId();
            Shop shop = shopService.getShopById(shopsId);
            collectionShop.setShops(shop);

        }


        request.setAttribute("collectionShopList", collectionShopList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("userId", userId);
        request.setAttribute("shopName", "");
        request.setAttribute("datetime1", "");
        request.setAttribute("datetime2", "");

        return "system/collect/collectionshop";
    }


    //后台收藏管理查看店铺模块，按条件查询符合条件的店铺
    @RequestMapping("/collectionShopSelectAllShop.do")
    public String collectionShopSelectAllShop(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String shopName = java.net.URLDecoder.decode(request.getParameter("shopName"), "UTF-8");//进行解码
        shopName = shopName.replaceAll(" \\s*", "");
        String datetime1 = request.getParameter("datetime1");
        String datetime2 = request.getParameter("datetime2");

        int totalRecords = collectionShopService.collectionShopCount(userId, shopName, datetime1, datetime2);//根据条件查询共有多少条记录

        //一开始从隐藏域传过来的当前页为1
        int currentPage = Integer.parseInt(request.getParameter("currentpage"));
        int everyPageRecords = 6;//设置每页显示6条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法

        List<com.shop.entity.CollectionShop> collectionShopList = collectionShopService.collectionShopSelectAllShop(userId, shopName, datetime1, datetime2, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (com.shop.entity.CollectionShop collectionShop : collectionShopList) {
            Integer shopsId = collectionShop.getShopsId();
            Shop shop = shopService.getShopById(shopsId);
            collectionShop.setShops(shop);
        }

        request.setAttribute("collectionShopList", collectionShopList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("userId", userId);
        request.setAttribute("shopName", shopName);
        request.setAttribute("datetime1", datetime1);
        request.setAttribute("datetime2", datetime2);

        //按条件查询成功后返回查询页面
        return "system/collect/collectionshop";
    }

    //后台收藏管理查看店铺模块，删除一个收藏的店铺
    @RequestMapping("/collectionShopDeleteByShopId.do")
    public String collectionShopDeleteByShopId(HttpServletRequest request, HttpServletResponse response) {

        int shopId = Integer.parseInt(request.getParameter("shopId"));
        int userId = Integer.parseInt(request.getParameter("userId"));

        /**
         * 为了防止用户通过地址栏修改用户id值去删除其他用户的信息，所有要将session范围的userId和reqeust范围的userId进行比较
         * 比如id号为1的用户，通过地址栏
         * http://localhost:8080/cjmqy/collectionShopDeleteByShopId.do?shopId=61&userId=2
         * 删除了用户id为2的用户的id值为61的收藏店铺
         */

        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if ((user.getId() == userId)) {
            collectionShopService.collectionShopDeleteByShopId(shopId, userId);

            //删除成功后返回查询页面(第一页)
            int currentPage = 1;
            int everyPageRecords = 6;//设置每页显示6条记录

            int totalRecordsRe = collectionShopService.collectionShopCountByUserId(userId);//根据条件查询共有多少条记录
            Pager pager = new Pager(totalRecordsRe, everyPageRecords, currentPage);//调用有三个参数的构造方法
            List<com.shop.entity.CollectionShop> collectionShopList = collectionShopService.collectionShopFindByUserId(userId, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
            for (com.shop.entity.CollectionShop collectionShop : collectionShopList) {
                Integer shopsId = collectionShop.getShopsId();
                Shop shop = shopService.getShopById(shopsId);
                collectionShop.setShops(shop);

            }


            request.setAttribute("collectionShopList", collectionShopList);
            request.setAttribute("pager", pager);//设置page对象
            request.setAttribute("userId", userId);
            request.setAttribute("shopName", "");
            request.setAttribute("datetime1", "");
            request.setAttribute("datetime2", "");

            return "system/collect/collectionshop";
        }

        return "system/error";
    }

    //后台收藏管理查看店铺模块，全选删除收藏的店铺（改状态）
    @RequestMapping("/collectionShopDeleteAllShop.do")
    public String collectionShopDeleteByShopIds(HttpServletRequest request, HttpServletResponse response) {
        try {
            String[] shopIdsStr = request.getParameterValues("selectFlag");
            System.out.println(shopIdsStr.length);
            int[] shopIds = new int[shopIdsStr.length];
            for (int i = 0; i < shopIdsStr.length; i++) {
                System.out.println("+++++++++" + shopIdsStr[i]);
                shopIds[i] = Integer.parseInt(shopIdsStr[i]);
                System.out.println(shopIds[i]);
            }
            int userId = Integer.parseInt(request.getParameter("userId"));

            // 防止用户通过地址栏修改用户id值去删除其他用户的信息，将session范围的用户Id和reqeust范围的用户Id进行比较
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

            if ((user.getId() == userId)) {
                for (int j = 0; j < shopIds.length; j++) {
                    System.out.println(shopIds[j]);
                    collectionShopService.collectionShopDeleteByShopId(shopIds[j], userId);
                }

                int currentPage = 1;
                int everyPageRecords = 6;//设置每页显示6条记录

                int totalRecordsRe = collectionShopService.collectionShopCountByUserId(userId);//根据条件查询共有多少条记录
                Pager pager = new Pager(totalRecordsRe, everyPageRecords, currentPage);//调用有三个参数的构造方法
                List<com.shop.entity.CollectionShop> collectionShopList = collectionShopService.collectionShopFindByUserId(userId, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
                for (com.shop.entity.CollectionShop collectionShop : collectionShopList) {
                    Integer shopsId = collectionShop.getShopsId();
                    Shop shop = shopService.getShopById(shopsId);
                    collectionShop.setShops(shop);

                }
                request.setAttribute("collectionShopList", collectionShopList);
                request.setAttribute("pager", pager);//设置page对象
                request.setAttribute("userId", userId);
                request.setAttribute("shopName", "");
                request.setAttribute("datetime1", "");
                request.setAttribute("datetime2", "");
                return "system/collect/collectionshop";
            }
            return "system/error";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            System.out.println(e);
            return "system/error";
        }


    }


    /**
     * 用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
     * shoperUserId:店主的Id号
     * userId:访问店铺的用户id号
     */
    @RequestMapping("/userCollectionShop.do")
    public String userCollectionShop(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = response.getWriter();
        int shopId = Integer.parseInt(request.getParameter("shopId"));
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getId();

            String isCollectionShop = collectionShopService.userCollectionShop(shopId, userId);


            if (isCollectionShop.equals("noCollection")) {

                out.print("collectSuccess");
            } else if (isCollectionShop.equals("hasCollection")) {

                out.print("hasCollection");
            }

        } else {

            out.print("donotLogin");

        }
        out.flush();
        out.close();

        return null;
    }
}
