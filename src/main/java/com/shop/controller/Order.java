package com.shop.controller;

import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.entity.*;
import com.shop.service.*;
import com.shop.utils.CountUtil;
import com.shop.utils.DateTime;
import com.shop.utils.Regex;
import com.shop.utils.pageUtil.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class Order {
    //
    private int currentpage = 1;
    @Resource
    private OrderService orderService;
    @Resource
    private TradeRecordService tradeRecordService;
    @Resource
    private GoodsService goodsService;
    @Resource
    private UserService userService;
    @Resource
    private ShopService shopService;
//	private TradeRecordService tradeRecordService;
//
// 分页

    public void page(HttpServletRequest request, int userId, int totalSize, int isBuy) {
        int max = 10;
        List<GoodsOrder> list = null;
        String num = request.getParameter("page");
        if (num != null) {
            currentpage = Integer.parseInt(num);
        }
        Page page = (Page) request.getAttribute("page");
        if (page == null) {
            page = new Page(totalSize, max, currentpage);
            request.setAttribute("page", page);
        } else {
            page.setCurrentPage(currentpage);
            request.setAttribute("page", page);
        }
        if (isBuy == 2) {
            list = orderService.findIsSoleGoodsOrdersByUserId(userId, page.getBeginIndex(), max);
            for (GoodsOrder goodsOrder : list) {
                Integer goodId = goodsOrder.getGoodId();
                Integer userId2 = goodsOrder.getUserId();
                com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
                Integer shopId = goods.getShopId();
                Shop shop = shopService.getShopById(shopId);
//            Integer userId1 = shop.getUserId();
                User userById = userService.getUserById(userId2);
                shop.setUser(userById);
                goods.setShop(shop);
                goodsOrder.setGood(goods);
                goodsOrder.setUser(userById);

            }
        } else {
            list = orderService.findIsBuyGoodsOrdersByUserId(userId, page.getBeginIndex(), max);
            for (GoodsOrder goodsOrder : list) {
                Integer goodId = goodsOrder.getGoodId();
//                Integer userId2 = goodsOrder.getUserId();
                com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
                Integer shopId = goods.getShopId();
                Shop shop = shopService.getShopById(shopId);
                Integer userId1 = shop.getUserId();
                User userById = userService.getUserById(userId1);
                shop.setUser(userById);
                goods.setShop(shop);
                goodsOrder.setGood(goods);
                goodsOrder.setUser(userById);

            }
        }


        request.setAttribute("goodsOrder", list);
    }

    //查询所有顾客订单
    @RequestMapping("/order/searchAllCusOrders.do")

    public String searchAllCusOrders(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
//            int totalSize = tradeRecordService.getTotalSizeIsSole(userId);
//            String hql = "from GoodsOrder as g where g.good.shop.user.id="+userId+" and g.tag=1 order by g.tradeTime desc";
            int totalSize = orderService.getIsSoleTotalByUserId(userId);
            this.page(request, userId, totalSize, 2);
            return "system/order/queryCusOrder";
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    //查询所有已下订单
    @RequestMapping("/order/searchAllOwnOrders.do")
    public String searchAllOwnOrders(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            int totalSize = orderService.getIsBuyTotalByUserId(userId);
//            String hql = "from GoodsOrder as g where g.user.id="+userId+" and g.tag=1 order by g.tradeTime desc";
            this.page(request, userId, totalSize, 1);
            return "system/order/queryOwnOrder";
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    //查看订单
    @RequestMapping("/order/selectOrders.do")
    public String selectOrders(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            // 服务器验证
            String getId = request.getParameter("id");
            if (getId == null || getId.equals("")) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }

            Integer id = Integer.parseInt(getId);
            GoodsOrder goodsOrder = orderService.getGoodsOrderById(id);
            Integer goodId = goodsOrder.getGoodId();
            com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
            Integer shopId = goods.getShopId();
            Shop shop = shopService.getShopById(shopId);
            Integer userId1 = shop.getUserId();
            User userById = userService.getUserById(userId1);
            shop.setUser(userById);
            goods.setShop(shop);
            goodsOrder.setGood(goods);
            goodsOrder.setUser(userById);
//            String hql = "from ReceiveAddress as r where r.goodsOrder.id="+id;
            ReceiveAddress receiveAddress = orderService.getReceiveAddressByGoodsOrderId(id);
            request.setAttribute("receiveAddress", receiveAddress);
            request.setAttribute("goodsOrder", goodsOrder);
            return "system/order/selectCusOrder";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    @RequestMapping("/order/selectOwnOrders.do")
    public String selectOwnOrders(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            // 服务器验证
            String getId = request.getParameter("id");
            if (getId == null || getId.equals("")) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }
            Integer id = Integer.parseInt(getId);
            GoodsOrder goodsOrder = orderService.getGoodsOrderById(id);
//            Integer userId = goodsOrder.getUserId();

            Integer goodId = goodsOrder.getGoodId();
            com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
            Integer shopId = goods.getShopId();
            Shop shop = shopService.getShopById(shopId);
            Integer userId1 = shop.getUserId();
            User userById = userService.getUserById(userId1);
            shop.setUser(userById);
            goods.setShop(shop);
            goodsOrder.setGood(goods);
            goodsOrder.setUser(userById);
//            String hql = "from ReceiveAddress as r where r.goodsOrder.id="+id;
            ReceiveAddress receiveAddress = orderService.getReceiveAddressByGoodsOrderId(id);
            request.setAttribute("receiveAddress", receiveAddress);
            request.setAttribute("goodsOrder", goodsOrder);
            return "system/order/selectCusOrder";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    //根据条件查询顾客订单
    @RequestMapping("/order/searchCusOrders.do")
    public String searchCusOrders(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            int max = 10;
            String orderNum = request.getParameter("orderNum");
            int state = 0;
            if (request.getParameter("state") != null) {
                state = Integer.parseInt(request.getParameter("state"));
            }
//            int state = Integer.parseInt(request.getParameter("state"));
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            if (orderNum != null && !orderNum.equals("")) {
                orderNum = orderNum.trim();
            }
            String num = request.getParameter("page");
            int totalSize = orderService.findIsSoleGoodsOrdersCountByCondition(userId, orderNum, state, startTime, endTime);
            if (num != null) {
                currentpage = Integer.parseInt(num);
            }
            Page page = (Page) request.getAttribute("page");
            if (page == null) {
                page = new Page(totalSize, max, currentpage);
                request.setAttribute("page", page);
            } else {
                page.setCurrentPage(currentpage);
                request.setAttribute("page", page);
            }
            List<GoodsOrder> list = orderService.findIsSoleGoodsOrdersByCondition(userId, orderNum, state, startTime, endTime, page.getBeginIndex(), max);
            for (GoodsOrder goodsOrder : list) {
                Integer goodId = goodsOrder.getGoodId();
                com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
                Integer shopId = goods.getShopId();
                Shop shop = shopService.getShopById(shopId);
                Integer userId1 = shop.getUserId();
                User userById = userService.getUserById(userId1);
                shop.setUser(userById);
                goods.setShop(shop);
                goodsOrder.setGood(goods);
                goodsOrder.setUser(userById);

            }
            request.setAttribute("goodsOrder", list);
//            OrderForm orderForm = (OrderForm) form;
//            String orderNum = orderForm.getOrderNum();
//            if(orderNum==null || orderNum.equals("")){
//                orderNum="";
//            }else{
//                orderNum = " and g.orderNum like '%"+orderNum.trim() + "%' ";
//            }
//            Integer state = orderForm.getState();
//            String stateSpan = "";
//            if(state != 0){
//                stateSpan = " and g.state="+state;
//            }
//            String startTime = orderForm.getStartTime();
//            String endTime = orderForm.getEndTime();
//            String timeSpan = "";
//            if (startTime != null && !startTime.equals("")
//                    && endTime != null && !endTime.equals("")) {
//                timeSpan = "and g.tradeTime between '"
//                        + CutDateTime.cut(startTime) + " 00' and '"
//                        + CutDateTime.cut(endTime) + " 24'";
//            }
//            String hql = "from GoodsOrder as g where g.good.shop.user.id="+userId+orderNum+timeSpan+stateSpan+" and g.tag=1 order by g.tradeTime desc";
//            this.page(request, hql);
            return "system/order/queryCusOrder";
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }


    //根据条件查询已下订单
    @RequestMapping("/order/searchOwnOrders.do")
    public String searchOwnOrders(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            int max = 10;
            String orderNum = request.getParameter("orderNum");
            int state = 0;
            System.out.println("iiii" + request.getParameter("state"));
            if (request.getParameter("state") != null) {
                state = Integer.parseInt(request.getParameter("state"));
            }
//            int state = Integer.parseInt(request.getParameter("state"));
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            if (orderNum != null && !orderNum.equals("")) {
                orderNum = orderNum.trim();
            }
            String num = request.getParameter("page");
            int totalSize = orderService.findIsBuyGoodsOrdersCountByCondition(userId, orderNum, state, startTime, endTime);
            if (num != null) {
                currentpage = Integer.parseInt(num);
            }
            Page page = (Page) request.getAttribute("page");
            if (page == null) {
                page = new Page(totalSize, max, currentpage);
                request.setAttribute("page", page);
            } else {
                page.setCurrentPage(currentpage);
                request.setAttribute("page", page);
            }
            List<GoodsOrder> list = orderService.findIsBuyGoodsOrdersByCondition(userId, orderNum, state, startTime, endTime, page.getBeginIndex(), max);
            for (GoodsOrder goodsOrder : list) {
                Integer goodId = goodsOrder.getGoodId();
//                Integer userId2 = goodsOrder.getUserId();
                com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
                Integer shopId = goods.getShopId();
                Shop shop = shopService.getShopById(shopId);
                Integer userId1 = shop.getUserId();
                User userById = userService.getUserById(userId1);
                shop.setUser(userById);
                goods.setShop(shop);
                goodsOrder.setGood(goods);
                goodsOrder.setUser(userById);

            }
            request.setAttribute("goodsOrder", list);

            return "system/order/queryOwnOrder";
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    //发货
    @RequestMapping("/order/deliverGoods.do")
    public String deliverGoods(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            // 服务器验证
            String getId = request.getParameter("id");
            if (getId == null || getId.equals("")) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }
            Integer id = Integer.parseInt(getId);
            GoodsOrder goodsOrder = orderService.getGoodsOrderById(id);
            Integer goodId = goodsOrder.getGoodId();
            com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
            Integer shopId = goods.getShopId();
            Shop shop = shopService.getShopById(shopId);
            Integer userId = shop.getUserId();
            User userById = userService.getUserById(userId);
            shop.setUser(userById);
            goods.setShop(shop);
            goodsOrder.setGood(goods);
            //判断是否为该用户的信息
            if (!goodsOrder.getGood().getShop().getUser().getId().equals(user.getId())) {
                request.setAttribute("errorInfo", "非法操作！您无权发货！");
                return "system/error";
            }
            goodsOrder.setState(2);
            orderService.updateGoodsOrderById(id, 2);

            //更新顾客订单数
            ServletContext application = request.getSession().getServletContext();
//            String cusOrderHql = "from GoodsOrder as g where g.good.shop.user.id="+user.getId()+" and g.tag=1 and g.state=1 order by g.tradeTime desc";
            Integer cusOrderCount = orderService.getTotalUNSHIPPED(user.getId(), 1);
            Map<Integer, Integer> cusOrderMap = CountUtil.getCusOrderMap();
            cusOrderMap.put(user.getId(), cusOrderCount);
            application.setAttribute("cusOrderCount", cusOrderMap);

            //更新已下订单数
//            Integer cusId = goodsOrder.getUser().getId();
//            Integer userId1 = user.getId();
//            String ownOrderHql = "from GoodsOrder as g where g.user.id="+cusId+" and g.tag=1 and g.state=2 order by g.tradeTime desc";
            Integer ownOrderCount = orderService.getTotalSize(user.getId(), 2);
            Map<Integer, Integer> ownOrderMap = CountUtil.getOwnOrderMap();
            ownOrderMap.put(user.getId(), ownOrderCount);
            application.setAttribute("ownOrderCount", ownOrderMap);
            int totalSize = orderService.getIsSoleTotalByUserId(user.getId());
            this.page(request, user.getId(), totalSize, 2);

            return "system/order/queryCusOrder";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }


    //已收到
    @RequestMapping("/order/takeDelivery.do")
    public String takeDelivery(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            com.shop.entity.User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            // 服务器验证
            String getId = request.getParameter("id");
            if (getId == null || getId.equals("")) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }

            Integer id = Integer.parseInt(getId);
            GoodsOrder goodsOrder = orderService.getGoodsOrderById(id);
            Integer goodId = goodsOrder.getGoodId();
            com.shop.entity.Goods goodsById = goodsService.findGoodsById(goodId);
            Integer shopId = goodsById.getShopId();
            Shop shopById = shopService.getShopById(shopId);
            Integer soleUserId = shopById.getUserId();
            Integer buyUserId = goodsOrder.getUserId();
            String tradeTime = goodsOrder.getTradeTime();

            //判断是否为该用户的信息
            if (!goodsOrder.getUserId().equals(user.getId())) {
                request.setAttribute("errorInfo", "非法操作！您无权更改！");
                return "system/error";
            }
            goodsOrder.setState(3);
            orderService.updateGoodsOrderById(id, 3);
            //增加已买记录
            com.shop.entity.TradeRecord buyTradeRecord = new com.shop.entity.TradeRecord();
            buyTradeRecord.setUserId(buyUserId);
            buyTradeRecord.setGoodsId(goodId);
            buyTradeRecord.setGoodOrderId(id);
            buyTradeRecord.setTradeTime(tradeTime);
            buyTradeRecord.setIsBuy(1);
            buyTradeRecord.setTag(1);
            tradeRecordService.saveBuyTradeRecord(buyTradeRecord);
            //增加已卖记录
            com.shop.entity.TradeRecord soleTradeRecord = new com.shop.entity.TradeRecord();
            soleTradeRecord.setUserId(soleUserId);
            soleTradeRecord.setGoodsId(goodId);
            soleTradeRecord.setGoodOrderId(id);
            soleTradeRecord.setBuyerId(user.getId());
            soleTradeRecord.setTradeTime(tradeTime);
            soleTradeRecord.setIsBuy(2);
            soleTradeRecord.setTag(1);
//            sole.setBuyer(user);
//            sole.setGoodsOrder(goodsOrder);
//            sole.setGoods(goodsOrder.getGood());
//            sole.setIsBuy(2);
//            sole.setTag(1);
//            sole.setTradeTime(goodsOrder.getTradeTime());
//            sole.setUser(goodsOrder.getGood().getShop().getUser());
            tradeRecordService.saveSoleTradeRecord(soleTradeRecord);

            //更新已下订单数
            ServletContext application = request.getSession().getServletContext();
            Integer ownOrderCount = orderService.getTotalSize(user.getId(), 2);
            Map<Integer, Integer> ownOrderMap = CountUtil.getOwnOrderMap();
            ownOrderMap.put(user.getId(), ownOrderCount);
            application.setAttribute("ownOrderCount", ownOrderMap);


//            String ownOrderHql = "from GoodsOrder as g where g.user.id="+user.getId()+" and g.tag=1 and g.state=2 order by g.tradeTime desc";
//            Integer ownOrderCount = orderService.getTotalSize(ownOrderHql);
//            Map<Integer,Integer> ownOrderMap = CountUtil.getOwnOrderMap();
//            ownOrderMap.put(user.getId(), ownOrderCount);
//            application.setAttribute("ownOrderCount", ownOrderMap);


            return "system/order/takeDelivery";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    //删除订单
    @RequestMapping("/order/deleteOrder.do")
    public String deleteOrder(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            // 服务器验证
            String getId = request.getParameter("id");
            if (getId == null || getId.equals("")) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }

            Integer id = Integer.parseInt(getId);
            GoodsOrder goodsOrder = orderService.getGoodsOrderById(id);
            Integer goodId = goodsOrder.getGoodId();
            com.shop.entity.Goods goods = goodsService.findGoodsById(goodId);
            Integer shopId = goods.getShopId();
            Shop shop = shopService.getShopById(shopId);
            Integer userId = shop.getUserId();
            User userById = userService.getUserById(userId);
            shop.setUser(userById);
            goods.setShop(shop);
            goodsOrder.setGood(goods);

            //判断是否为该用户的信息
            if (!goodsOrder.getGood().getShop().getUser().getId().equals(user.getId())) {
                request.setAttribute("errorInfo", "非法操作！您无权删除订单！");
                return "system/error";
            }
            orderService.deleteGoodsOrder(id);
            ServletContext application = request.getSession().getServletContext();
//            String cusOrderHql = "from GoodsOrder as g where g.good.shop.user.id="+user.getId()+" and g.tag=1 and g.state=1 order by g.tradeTime desc";
            Integer cusOrderCount = orderService.getTotalUNSHIPPED(user.getId(), 1);
            Map<Integer, Integer> cusOrderMap = CountUtil.getCusOrderMap();
            cusOrderMap.put(user.getId(), cusOrderCount);
            application.setAttribute("cusOrderCount", cusOrderMap);

            //更新已下订单数
//            Integer cusId = goodsOrder.getUser().getId();
//            Integer userId1 = user.getId();
//            String ownOrderHql = "from GoodsOrder as g where g.user.id="+cusId+" and g.tag=1 and g.state=2 order by g.tradeTime desc";
            Integer ownOrderCount = orderService.getTotalSize(user.getId(), 2);
            Map<Integer, Integer> ownOrderMap = CountUtil.getOwnOrderMap();
            ownOrderMap.put(user.getId(), ownOrderCount);
            application.setAttribute("ownOrderCount", ownOrderMap);
            int totalSize = orderService.getIsSoleTotalByUserId(user.getId());
            this.page(request, user.getId(), totalSize, 2);

            //更新顾客订单数
//            ServletContext application = request.getSession().getServletContext();
//            String cusOrderHql = "from GoodsOrder as g where g.good.shop.user.id="+user.getId()+" and g.tag=1 and g.state=1 order by g.tradeTime desc";
//            Integer cusOrderCount = orderService.getTotalSize(cusOrderHql);
//            Map<Integer,Integer> cusOrderMap = CountUtil.getCusOrderMap();
//            cusOrderMap.put(user.getId(), cusOrderCount);
//            application.setAttribute("cusOrderCount", cusOrderMap);
//
//            //更新已下订单数
//            Integer cusId = goodsOrder.getUser().getId();
//            String ownOrderHql = "from GoodsOrder as g where g.user.id="+cusId+" and g.tag=1 and g.state=2 order by g.tradeTime desc";
//            Integer ownOrderCount = orderService.getTotalSize(ownOrderHql);
//            Map<Integer,Integer> ownOrderMap = CountUtil.getOwnOrderMap();
//            ownOrderMap.put(cusId, ownOrderCount);
//            application.setAttribute("ownOrderCount", ownOrderMap);

            return "system/order/queryCusOrder";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    //购物车结算
    @RequestMapping("/order/addOrderInCart.do")
    public String addOrderInCart(HttpServletRequest request, HttpServletResponse response) {
        try {
            /*防止重复提交*/
//        String token = request.getParameter("TOKEN");
//        String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//        request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
            Object sessionTokenObj = request.getParameter("token");
//		String paramToken = request.getParameter("TOKEN");
            request.getSession().removeAttribute("TOKEN");
            if (sessionTokenObj != null) {
                try {
                    User user = (User) request.getSession().getAttribute("user");
                    if (user == null || user.equals("")) {
                        request.getSession().invalidate();
                        return "cjmqylogin/login";
                    }
                    Integer userId = user.getId();
                    Vector cart = (Vector) request.getSession().getAttribute("cart" + userId);
                    String receiverName = request.getParameter("receiverName");
                    String phone = request.getParameter("phone");
                    String shortPhone = request.getParameter("shortPhone");
                    String address = request.getParameter("address");
                    String[] goodIdsStr = request.getParameterValues("goodId");
                    String[] amountIdStr = request.getParameterValues("amountId");
                    int[] goodId = null;
                    int[] amountId = null;
                    if (goodIdsStr != null) {
                        goodId = new int[goodIdsStr.length];
                        for (int i = 0; i < goodIdsStr.length; i++) {
                            goodId[i] = Integer.parseInt(goodIdsStr[i]);
                        }
                    }
                    if (amountIdStr != null) {
                        amountId = new int[amountIdStr.length];
                        for (int i = 0; i < amountIdStr.length; i++) {
                            amountId[i] = Integer.parseInt(amountIdStr[i]);
                        }
                    }


//                OrderForm orderForm = (OrderForm) form;
//                Integer[]  = orderForm.getGoodId();
//                Integer[] amountId = orderForm.getAmountId();
//                String receiverName = orderForm.getReceiverName();
//                String phone = orderForm.getPhone();
//                String shortPhone = orderForm.getShortPhone();
//                String address = orderForm.getAddress();

                    //服务器验证
                    if (goodId == null || amountId == null || receiverName == null || phone == null || shortPhone == null || address == null) {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    } else {
                        boolean flag = (Regex.validateText(receiverName, 5) && Regex.validatTelephone(phone) && Regex.validateText(shortPhone, 0, 6) && Regex.validateText(address, 30));
                        if (!flag) {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    }
                    for (int i = 0; i < goodId.length; i++) {
                        /* 根据日期、用户ID生成订单号 */
                        Date now = new Date();
                        SimpleDateFormat num1 = new SimpleDateFormat("yyMMdd");
                        SimpleDateFormat num2 = new SimpleDateFormat("HHmmss");
                        String orderNum = userId + num1.format(now) + num2.format(now) + i;
                        String tradeTime = DateTime.getNow();
                        com.shop.entity.Goods good = goodsService.findGoodsById(goodId[i]);
                        int newAmount = good.getAmount() - amountId[i];
                        if (newAmount < 0) {
                            request.setAttribute("errorInfo", goodId[i] + "对不起！您购买的数量大于库存量，请重新购买！");
                            return "shop/shoppingCart/cartOrderEnd";
//                        return mapping.findForward("addOrderInCart");
                        }
                        good.setAmount(newAmount);
                        int updateNum = goodsService.updateGoods(good);
                        if (updateNum != 1) {
                            request.setAttribute("errorInfo", "服务器繁忙！");
                            return "system/error";
                        }

                        //计算总价
                        float price = good.getPrice();
                        NumberFormat numberFormat = DecimalFormat.getInstance();
                        numberFormat.setMinimumFractionDigits(2);
                        String total = numberFormat.format(price * amountId[i]) + "元";


                        GoodsOrder goodsOrder = new GoodsOrder();
                        goodsOrder.setAmount(amountId[i]);
                        goodsOrder.setOrderNum(orderNum);
                        goodsOrder.setGood(good);
                        goodsOrder.setGoodId(goodId[i]);
                        goodsOrder.setState(1);
                        goodsOrder.setTag(1);
                        goodsOrder.setTotal(total);
                        goodsOrder.setTradeTime(tradeTime);
                        goodsOrder.setUserId(userId);
                        goodsOrder.setUser(user);
                        orderService.saveOrder(goodsOrder);
                        int goodsOrderId = goodsOrder.getId();

                        ReceiveAddress receiveAddress = new ReceiveAddress();
                        receiveAddress.setAddress(address);
                        receiveAddress.setOrderId(goodsOrderId);
//                    receiveAddress.setGoodsOrder(order);
                        receiveAddress.setPhone(phone);
                        receiveAddress.setReceiverName(receiverName);
                        receiveAddress.setShortPhone(shortPhone);
                        receiveAddress.setTag(1);
                        orderService.saveReceiveAddress(receiveAddress);

                        ShoppingCart cartForm = (ShoppingCart) cart.elementAt(0);
                        cart.remove(cartForm);

                        //更新顾客订单数
                        ServletContext application = request.getSession().getServletContext();
//            String cusOrderHql = "from GoodsOrder as g where g.good.shop.user.id="+user.getId()+" and g.tag=1 and g.state=1 order by g.tradeTime desc";
                        Integer cusOrderCount = orderService.getTotalUNSHIPPED(user.getId(), 1);
                        Map<Integer, Integer> cusOrderMap = CountUtil.getCusOrderMap();
                        cusOrderMap.put(user.getId(), cusOrderCount);
                        application.setAttribute("cusOrderCount", cusOrderMap);
                    }
                    request.setAttribute("success", "提交成功！");
                    request.getSession().removeAttribute("cart" + user.getId());
                    return "shop/shoppingCart/cartOrderEnd";
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
                    return "system/error";
                }
            } else {
                request.setAttribute("errorInfo", "不允许重复提交！");
                return "shop/shoppingCart/cartOrderEnd";
            }
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";

        }

    }

    //选择购买产品
    @RequestMapping("/order/selectGoodsOrder.do")
    public String selectGoodsOrder(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }

            //服务器验证
            String getGoodId = request.getParameter("goodsId");
            System.out.println("---" + getGoodId);

            String getAmount = request.getParameter("amount");
            System.out.println("+++" + getAmount);
            if (getGoodId == null || getAmount == null) {
                request.setAttribute("errorInfo", "非法操作！");
                return "shop/order/ordersubmit";
            }

            Integer goodsId = Integer.parseInt(getGoodId);
            Integer amount = Integer.parseInt(getAmount);
            com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);
            request.setAttribute("good", goods);
            request.setAttribute("amount", amount);
            return "shop/order/orderImformation";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "shop/order/ordersubmit";
        }
    }

    //验证订单
    @RequestMapping("/order/confirmOrder.do")
    public String confirmOrder(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }

            String goodIdStr = request.getParameter("goodsId");
            System.out.println("11111" + goodIdStr);
            String amountStr = request.getParameter("amount");
            System.out.println("222" + amountStr);
//            if (goodIdStr!=null && amountStr !=null){
//                int goodsId = Integer.parseInt(goodIdStr);
//                int amount = Integer.parseInt(amountStr);
//            }


            String receiverName = request.getParameter("receiverName");
            String phone = request.getParameter("phone");
            String shortPhone = request.getParameter("shortPhone");
            String address = request.getParameter("address");

//			OrderForm orderForm = (OrderForm) form;
//			Integer goodsId = orderForm.getGoodsId();
//			Integer amount = orderForm.getAmount();
//			String receiverName = orderForm.getReceiverName();
//			String phone = orderForm.getPhone();
//			String shortPhone = orderForm.getShortPhone();
//			String address = orderForm.getAddress();

            //服务器验证
            if (goodIdStr == null || amountStr == null || receiverName == null || phone == null || shortPhone == null || address == null) {
                request.setAttribute("errorInfo", "非法操作！");
                return "shop/order/ordersubmit";
            } else {
                boolean flag = (Regex.validateText(receiverName, 5) && Regex.validatTelephone(phone) && Regex.validateText(shortPhone, 0, 6) && Regex.validateText(address, 30));
                if (!flag) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "shop/order/ordersubmit";
                }
            }

            com.shop.entity.Goods goods = goodsService.findGoodsById(Integer.parseInt(goodIdStr));
            Integer shopId = goods.getShopId();
            Shop shopById = shopService.getShopById(shopId);
            Integer userId = shopById.getUserId();
            User userById = userService.getUserById(userId);
            shopById.setUser(userById);
            goods.setShop(shopById);
            float price = goods.getPrice();

            //计算总价
            NumberFormat numberFormat = DecimalFormat.getInstance();
            numberFormat.setMinimumFractionDigits(2);
            String total = numberFormat.format(price * Integer.parseInt(amountStr)) + "元";
            request.setAttribute("good", goods);
            ReceiveAddress receiveAddress = new ReceiveAddress();
            receiveAddress.setReceiverName(receiverName);
            receiveAddress.setPhone(phone);
            receiveAddress.setShortPhone(shortPhone);
            receiveAddress.setAddress(address);
            request.setAttribute("receiveAddress", receiveAddress);
            request.setAttribute("amount", Integer.parseInt(amountStr));
            request.setAttribute("total", total);
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            return "shop/order/ordedetail";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "shop/order/ordersubmit";
        }
    }

    //提交订单
    @RequestMapping("/order/addOrder.do")
    public String addOrder(HttpServletRequest request, HttpServletResponse response) {
        /*防止重复提交*/
        String sessionTokenObj = request.getParameter("token");
        request.getSession().removeAttribute("TOKEN");
//		 String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//		 request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
        if (sessionTokenObj != null) {
            try {
                com.shop.entity.User user = (User) request.getSession().getAttribute("user");
                if (user == null || user.equals("")) {
                    request.getSession().invalidate();
                    return "cjmqylogin/login";
                }
                Integer userId = user.getId();
                String goodsIdStr = request.getParameter("goodsId");
                String amountStr = request.getParameter("amount");

                String receiverName = request.getParameter("receiverName");
                String phone = request.getParameter("phone");
                String shortPhone = request.getParameter("shortPhone");
                String address = request.getParameter("address");

//			OrderForm orderForm = (OrderForm) form;
//			Integer goodsId = orderForm.getGoodsId();
//			Integer amount = orderForm.getAmount();
//			String receiverName = orderForm.getReceiverName();
//			String phone = orderForm.getPhone();
//			String shortPhone = orderForm.getShortPhone();
//			String address = orderForm.getAddress();

                //服务器验证
                if (goodsIdStr == null || amountStr == null || receiverName == null || phone == null || shortPhone == null || address == null) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "shop/order/ordersubmit";
                } else {
                    boolean flag = (Regex.validateText(receiverName, 5) && Regex.validatTelephone(phone) && Regex.validateText(shortPhone, 0, 6) && Regex.validateText(address, 30));
                    if (!flag) {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "shop/order/ordersubmit";
                    }
                }
                int goodsId = Integer.parseInt(goodsIdStr);
                int amount = Integer.parseInt(amountStr);

                /* 根据日期、用户ID生成订单号 */
                Date now = new Date();
                SimpleDateFormat num1 = new SimpleDateFormat("yyMMdd");
                SimpleDateFormat num2 = new SimpleDateFormat("HHmmss");
                String orderNum = userId + num1.format(now) + num2.format(now);
                String tradeTime = DateTime.getNow();

                com.shop.entity.Goods good = goodsService.findGoodsById(goodsId);
                int newAmount = good.getAmount() - amount;
                if (newAmount < 0) {
                    request.setAttribute("errorInfo", "对不起！您购买的数量大于库存量，请重新购买！");
                    return "shop/order/ordersubmit";
                }
                good.setAmount(newAmount);
                int updateNum = goodsService.updateGoods(good);
                if (updateNum != 1) {
                    request.setAttribute("errorInfo", "服务器繁忙！");
                    return "shop/order/ordersubmit";
                }

                //计算总价
                float price = good.getPrice();
                NumberFormat numberFormat = DecimalFormat.getInstance();
                numberFormat.setMinimumFractionDigits(2);
                String total = numberFormat.format(price * amount) + "元";

                GoodsOrder goodsOrder = new GoodsOrder();
                goodsOrder.setAmount((int) (price * amount));
                goodsOrder.setOrderNum(orderNum);
                goodsOrder.setGood(good);
                goodsOrder.setGoodId(goodsId);
                goodsOrder.setState(1);
                goodsOrder.setTag(1);
                goodsOrder.setTotal(total);
                goodsOrder.setTradeTime(tradeTime);
                goodsOrder.setUser(user);
                goodsOrder.setUserId(userId);
                orderService.saveOrder(goodsOrder);
                int goodsOrderId = goodsOrder.getId();

                ReceiveAddress receiveAddress = new ReceiveAddress();
                receiveAddress.setAddress(address);
                receiveAddress.setOrderId(goodsOrderId);
                receiveAddress.setPhone(phone);
                receiveAddress.setReceiverName(receiverName);
                receiveAddress.setShortPhone(shortPhone);
                receiveAddress.setTag(1);
                orderService.saveReceiveAddress(receiveAddress);

                request.setAttribute("success", "提交成功！");

                //更新顾客订单数
                ServletContext application = request.getSession().getServletContext();
//            String cusOrderHql = "from GoodsOrder as g where g.good.shop.user.id="+user.getId()+" and g.tag=1 and g.state=1 order by g.tradeTime desc";
                Integer cusOrderCount = orderService.getTotalUNSHIPPED(user.getId(), 1);
                Map<Integer, Integer> cusOrderMap = CountUtil.getCusOrderMap();
                cusOrderMap.put(user.getId(), cusOrderCount);
                application.setAttribute("cusOrderCount", cusOrderMap);

                return "shop/order/ordersubmit";
            } catch (Exception e) {
                request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
                return "shop/order/ordersubmit";
            }
        } else {
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
        }
    }
//
//
//
//


//
//


//

}
