package com.shop.controller;

/*
 *author:wuyixin
 *
 */

import com.shop.entity.CollectionGoods;
import com.shop.entity.Goods;
import com.shop.entity.User;
import com.shop.service.CollectionProductService;
import com.shop.service.GoodsService;
import com.shop.service.UserService;
import com.shop.utils.Pager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@Controller
public class CollectionProduct {
    @Resource
    UserService userService;
    @Resource
    GoodsService goodsService;
    //
    @Resource
    private CollectionProductService collectionProductService;

    //
    //后台收藏管理点击“店铺”查看收藏的所有商品
    @RequestMapping("/collectionProductFindByUserId.do")
    public String collectionProductFindByUserId(HttpServletRequest request, HttpServletResponse response) {

        int userId = Integer.parseInt(request.getParameter("userId"));

        int totalRecords = collectionProductService.collectionGoodsCountByUserId(userId);//根据条件查询共有多少条记录
        //从manager_index.jsp传过来的值为1的currentpage，
        int currentPage = Integer.parseInt(request.getParameter("currentpage"));
        int everyPageRecords = 6;//设置每页显示6条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
        List<CollectionGoods> collectionGoodsList = collectionProductService.collectionProductFindByUserId(userId, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (CollectionGoods collectionGoods : collectionGoodsList) {
            Integer goodsId = collectionGoods.getGoodsId();
            User user = userService.getUserById(userId);
            Goods goodsById = goodsService.findGoodsById(goodsId);
            collectionGoods.setGoods(goodsById);
            collectionGoods.setUser(user);
        }

        request.setAttribute("collectionGoodsList", collectionGoodsList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("userId", userId);
        request.setAttribute("goodName", "");
        request.setAttribute("datetime1", "");
        request.setAttribute("datetime2", "");

        return "system/collect/collectionproduct";
    }

    //后台收藏管理查看商品模块，删除一个收藏的商品
    @RequestMapping("/collectionGoodDeleteByGoodId.do")
    public String collectionGoodDeleteByGoodId(HttpServletRequest request, HttpServletResponse response) {
        try {
            System.out.println(request.getParameter("goodId"));
            System.out.println(request.getParameter("userId"));
            int goodId = Integer.parseInt(request.getParameter("goodId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            // 防止用户通过地址栏修改用户id值去删除其他用户的信息，将session范围的用户Id和reqeust范围的用户Id进行比较

            User user = (User) request.getSession().getAttribute("user");

            if ((user.getId() == userId)) {

                collectionProductService.collectionGoodDeleteByGoodsId(goodId, userId);

                //删除成功后返回查询页面(第一页)
                int currentPage = 1;
                int totalRecords = collectionProductService.collectionGoodsCountByUserId(userId);//根据条件查询共有多少条记录
                //从manager_index.jsp传过来的值为1的currentpage，
//				int currentPage=Integer.parseInt(request.getParameter("currentpage"));
                int everyPageRecords = 6;//设置每页显示6条记录
                Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
                List<CollectionGoods> collectionGoodsList = collectionProductService.collectionProductFindByUserId(userId, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
                for (CollectionGoods collectionGoods : collectionGoodsList) {
                    Integer goodsId = collectionGoods.getGoodsId();
                    User user1 = userService.getUserById(userId);
                    Goods goodsById = goodsService.findGoodsById(goodsId);
                    collectionGoods.setGoods(goodsById);
                    collectionGoods.setUser(user1);
                }

                request.setAttribute("collectionGoodsList", collectionGoodsList);
                request.setAttribute("pager", pager);//设置page对象
                request.setAttribute("userId", userId);
                request.setAttribute("goodName", "");
                request.setAttribute("datetime1", "");
                request.setAttribute("datetime2", "");

                return "system/collect/collectionproduct";
            }
            return "system/error";
        } catch (Exception e) {

            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }


    }
//

    //后台收藏管理查看商品模块，全选删除收藏的商品（改状态）
    @RequestMapping("/collectionGoodDeleteAllGood.do")
    public String collectionGoodDeleteAllGood(HttpServletRequest request, HttpServletResponse response) {
        String[] goodsIdsStr = request.getParameterValues("selectFlag");
        int[] goodsIds = new int[goodsIdsStr.length];
        for (int i = 0; i < goodsIdsStr.length; i++) {
            goodsIds[i] = Integer.parseInt(goodsIdsStr[i]);
        }
        int userId = Integer.parseInt(request.getParameter("userId"));
        // 防止用户通过地址栏修改用户id值去删除其他用户的信息，将session范围的用户Id和reqeust范围的用户Id进行比较
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if ((user.getId() == userId)) {
            for (int j = 0; j < goodsIds.length; j++) {
                collectionProductService.collectionGoodDeleteByGoodsId(goodsIds[j], userId);
            }


            //删除成功后返回查询页面(第一页)
            int currentPage = 1;
            int everyPageRecords = 6;//设置每页显示6条记录

            int totalRecords = collectionProductService.collectionGoodsCountByUserId(userId);//根据条件查询共有多少条记录
            Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
            List<CollectionGoods> collectionGoodsList = collectionProductService.collectionProductFindByUserId(userId, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
            for (CollectionGoods collectionGoods : collectionGoodsList) {
                Integer goodsId = collectionGoods.getGoodsId();
                User user1 = userService.getUserById(userId);
                Goods goodsById = goodsService.findGoodsById(goodsId);
                collectionGoods.setGoods(goodsById);
                collectionGoods.setUser(user1);
            }
            request.setAttribute("collectionGoodsList", collectionGoodsList);
            request.setAttribute("pager", pager);//设置page对象
            request.setAttribute("userId", userId);
            request.setAttribute("goodName", "");
            request.setAttribute("datetime1", "");
            request.setAttribute("datetime2", "");

            return "system/collect/collectionproduct";
        }
        return "system/error";
    }

    //后台收藏管理查看商品模块，按条件查询符合条件的商品
    @RequestMapping("/collectionGoodSelectAllShop.do")
    public String collectionGoodSelectAllShop(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String goodName = java.net.URLDecoder.decode(request.getParameter("goodName"), "UTF-8");//进行解码

        goodName = goodName.replaceAll(" \\s*", "");
        String datetime1 = request.getParameter("datetime1");
        String datetime2 = request.getParameter("datetime2");

        int totalRecords = collectionProductService.collectionGoodstCount(userId, goodName, datetime1, datetime2);//根据条件查询共有多少条记录

        //一开始从隐藏域传过来的当前页为1
        int currentPage = Integer.parseInt(request.getParameter("currentpage"));
        int everyPageRecords = 6;//设置每页显示6条记录
        Pager pager = new Pager(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法

        List<CollectionGoods> collectionGoodsList = collectionProductService.collectionGoodSelectAllShop(userId, goodName, datetime1, datetime2, pager.getBeginIndexRecord(), pager.getEveryPageRecords());
        for (CollectionGoods collectionGoods : collectionGoodsList) {
            Integer goodsId = collectionGoods.getGoodsId();
            User user1 = userService.getUserById(userId);
            Goods goodsById = goodsService.findGoodsById(goodsId);
            collectionGoods.setGoods(goodsById);
            collectionGoods.setUser(user1);
        }

        request.setAttribute("collectionGoodsList", collectionGoodsList);
        request.setAttribute("pager", pager);//设置page对象
        request.setAttribute("userId", userId);

        request.setAttribute("goodName", goodName);
        request.setAttribute("datetime1", datetime1);
        request.setAttribute("datetime2", datetime2);

        //按条件查询成功后返回查询页面
        return "system/collect/collectionproduct";
    }

    //	/**
//	 * 用户点击“收藏商品”，添加一个收藏商品表(collection_good)
//	 * goodId:商品的Id号
//	 * userId:访问店铺的用户id号
//	 */
    @RequestMapping("/userCollectionGood.do")
    public String userCollectionGood(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html");
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = response.getWriter();
        int goodId = Integer.parseInt(request.getParameter("goodId"));
        com.shop.entity.User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int userId = user.getId();
            String isCollectionShop = collectionProductService.userCollectionGood(goodId, userId);
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
