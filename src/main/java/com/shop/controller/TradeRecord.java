package com.shop.controller;


import com.shop.entity.Goods;
import com.shop.entity.GoodsOrder;
import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.service.*;
import com.shop.utils.CutDateTime;
import com.shop.utils.pageUtil.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
public class TradeRecord {
    //	private int currentpage = 1;
    @Resource
    private TradeRecordService tradeRecordService;
    @Resource
    private GoodsOrderService goodsOrderService;
    @Resource
    private GoodsService goodsService;
    @Resource
    private ShopService shopService;
    @Resource
    private UserService userService;
    @Resource
    private ComplaintService complaintService;

    private void setAttributrTradeRecord(com.shop.entity.TradeRecord tradeRecord, Integer isBuy) {
        Integer goodsOrderId = tradeRecord.getGoodOrderId();
//		System.out.println("goodsOrderId为"+goodsOrderId);
        Integer goodsId = tradeRecord.getGoodsId();
//		System.out.println("goodsId为"+goodsId);
//		Integer buyId = tradeRecord.getBuyerId();
        GoodsOrder goodOrder = goodsOrderService.getGoodsOrder(goodsOrderId);
        tradeRecord.setGoodsOrder(goodOrder);
        Goods goods = goodsService.findGoodsById(goodsId);
//		System.out.println("shopId为"+goods.getShopId());
        Integer shopId = goods.getShopId();
//		System.out.println("shopId为"+shopId);
        Shop shop = shopService.shop(shopId);
        Integer userId = tradeRecord.getUserId();
        User user = userService.getUserById(userId);
        shop.setUser(user);
        goods.setShop(shop);
        if (isBuy == 2) {
            Integer buyId = tradeRecord.getBuyerId();
            User buyUser = userService.getUserById(buyId);
            tradeRecord.setBuyer(buyUser);
        }
        tradeRecord.setGoods(goods);
        tradeRecord.setUser(user);


    }

    public void page(int userId, HttpServletRequest request, int totalSize, int isBuy) {
        int max = 10;
        int currentpage = 1;
        String num = request.getParameter("page");
        if (num != null) {
            currentpage = Integer.parseInt(num);
        }
        Page page = (Page) request.getAttribute("page");
        if (page == null) {
//			page = new Page(tradeRecordService.getTotalSize(hql), max, currentpage);
            page = new Page(totalSize, max, currentpage);
            request.setAttribute("page", page);
        } else {
            page.setCurrentPage(currentpage);
            request.setAttribute("page", page);
        }
        List<com.shop.entity.TradeRecord> list = null;
        if (isBuy == 1) {
            list = tradeRecordService.findTradeRecordsByBuy(userId, page.getBeginIndex(), max);
            for (com.shop.entity.TradeRecord tradeRecord : list) {
                setAttributrTradeRecord(tradeRecord, isBuy);
            }

        }
        if (isBuy == 2) {
            list = tradeRecordService.findTradeRecordsBySell(userId, page.getBeginIndex(), max);
            for (com.shop.entity.TradeRecord tradeRecord : list) {
                setAttributrTradeRecord(tradeRecord, isBuy);
            }
        }

        request.setAttribute("tradeRecord", list);

    }

    //查询所有已买的交易记录
    @RequestMapping("/tradeRecord/searchAllTradProducts.do")
    public String searchAllTradProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            int totalSize = tradeRecordService.getTotalSize(userId);
            System.out.println("3232323232" + totalSize);
//			String hql = "from TradeRecord as t where t.user.id="+userId+" and t.tag=1 and isBuy=1 order by t.tradeTime desc";
            this.page(userId, request, totalSize, 1);
            return "system/tradeRecord/tradProducts";
//			return mapping.findForward("searchAll");
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    //根据id获取的交易记录
    @RequestMapping("/tradeRecord/getTradProducts.do")
    public String getTradProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer id = Integer.parseInt(request.getParameter("id"));
            com.shop.entity.TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(id);
            //判断该交易记录是否属于该用户，否则无法对该交易发起维权

            if (!tradeRecord.getUserId().equals(user.getId())) {
                request.setAttribute("errorInfo", "非法操作！您无权对该交易记录发起维权！");
                return "system/error";
            }
            //判断该用户是否已对该交易记录发起维权
            if (tradeRecord.getPreRightsId() == null) {
                Integer goodsId = tradeRecord.getGoodsId();
                Goods goodsById = goodsService.findGoodsById(goodsId);
                Integer shopId = goodsById.getShopId();
                Shop shopById = shopService.getShopById(shopId);
                Integer userId = shopById.getUserId();
                User userById = userService.getUserById(userId);
                shopById.setUser(userById);
                goodsById.setShop(shopById);
                tradeRecord.setGoods(goodsById);
//				setAttributrTradeRecord(tradeRecord,1);
                request.setAttribute("tradeRecord", tradeRecord);
                UUID uuid = UUID.randomUUID();
                String token = uuid.toString().replaceAll("-", "");
                // 访问页面时随机生成一个token保存在服务端session中
                request.getSession().setAttribute("TOKEN", token);
//				request.getRequestDispatcher("/system/weiquan/trandcomplain/complaintBusiness.jsp").forward(request, response);
                return "system/weiquan/trandcomplain/complaintBusiness";
            } else {
                request.setAttribute("errorInfo", "很抱歉，您已对该交易发起维权！");
                return "system/error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";

        }

    }

    //查询所有已卖的交易记录
    @RequestMapping("/tradeRecord/searchAllSoleProducts.do")
    public String searchAllSoleProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            int totalSize = tradeRecordService.getTotalSizeIsSole(userId);
//			String hql = "from TradeRecord as t where t.user.id="+userId+" and t.tag=1 and isBuy=2 order by t.tradeTime desc";
            this.page(userId, request, totalSize, 2);
            return "system/tradeRecord/soleProducts";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }


    // 根据条件查询已买的交易记录

    @RequestMapping("/tradeRecord/searchTradProducts.do")
    public String searchTradProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
//			System.out.println(userId);
//			System.out.println("----");
            String goodsName = request.getParameter("goodsName");
            System.out.println(goodsName);
            if (goodsName != null) {
//				String goodsName=java.net.URLDecoder.decode(request.getParameter("goodsName"),"UTF-8");
                goodsName = java.net.URLDecoder.decode(goodsName, "UTF-8");
                goodsName = goodsName.replaceAll(" \\s*", "");
            }
            String startTradeTime = request.getParameter("startTradeTime");
            String endTradeTime = request.getParameter("endTradeTime");
            if (startTradeTime != null && !startTradeTime.equals("") && endTradeTime != null && !endTradeTime.equals("")) {
                startTradeTime = CutDateTime.cut(startTradeTime);
                endTradeTime = CutDateTime.cut(endTradeTime);

            }
//			System.out.println(startTradeTime);
//			System.out.println(endTradeTime);

//			TradeRecordForm tradeRecordForm = (TradeRecordForm) form;
//			String goodsName = tradeRecordForm.getGoodsName();
//			if(goodsName==null || goodsName.equals("")){
//				goodsName="";
//			}else{
//				goodsName = " and t.goods.name like '%"+goodsName.trim() + "%' ";
//			}
            int total = tradeRecordService.collectionTradeRecordCountIsBuy(userId, goodsName, startTradeTime, endTradeTime);
            System.out.println(total);

            int currentPage = Integer.parseInt(request.getParameter("page"));
//			System.out.println("++++dwdw    "+currentPage);

            System.out.println(currentPage);
            Page page = (Page) request.getAttribute("page");
            int everyPage = 10;//设置每页显示6条记录
            if (page == null) {
//				page = new Page(total, everyPage, currentPage);
                page = new Page(total, everyPage, currentPage);
                System.out.println("页数为" + page.getNum());
                System.out.println("page=null的" + page.getBeginIndex());
                System.out.println(page.getNum());
                request.setAttribute("page", page);
            } else {
                page.setCurrentPage(currentPage);
                System.out.println("page！=null的" + page.getBeginIndex());
                request.setAttribute("page", page);
            }
            List<com.shop.entity.TradeRecord> list = tradeRecordService.collectionTradeRecordsIsBuy(userId, goodsName, startTradeTime, endTradeTime, page.getBeginIndex(), everyPage);
            for (com.shop.entity.TradeRecord tradeRecord : list) {
                setAttributrTradeRecord(tradeRecord, 1);
            }
            request.setAttribute("tradeRecord", list);


//			int everyPage=6;//设置每页显示6条记录
//			int total = tradeRecordService.collectionTradeRecordCount(userId,goodsName,startTradeTime,endTradeTime);
//			Page page =new Page(total,everyPage,currentPage);//调用有三个参数的构造方法

//			String startTradeTime = tradeRecordForm.getStartTradeTime();
//			String endTradeTime = tradeRecordForm.getEndTradeTime();
//			String timeSpan = "";


//			if (startTradeTime != null && !startTradeTime.equals("")
//					&& endTradeTime != null && !endTradeTime.equals("")) {
//				timeSpan = "and t.tradeTime between '"
//						+ CutDateTime.cut(startTradeTime) + " 00' and '"
//						+ CutDateTime.cut(endTradeTime) + " 24'";
//			}
//			String hql = "from TradeRecord as t where t.user.id="+userId+" and t.tag=1 and isBuy=1"
//					+ goodsName + timeSpan+" order by t.tradeTime desc";
//			this.page(request, hql);
            return "system/tradeRecord/tradProducts";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }


    // 根据条件查询已卖的交易记录
    @RequestMapping("/tradeRecord/searchSoleProducts.do")
    public String searchSoleProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            String goodsName = request.getParameter("goodsName");
            if (goodsName != null) {
                goodsName = java.net.URLDecoder.decode(request.getParameter("goodsName"), "UTF-8");
                goodsName = goodsName.replaceAll(" \\s*", "");
            }

            String startTradeTime = request.getParameter("startTradeTime");
            String endTradeTime = request.getParameter("endTradeTime");
//			int userId = user.getId();
//			TradeRecordForm tradeRecordForm = (TradeRecordForm) form;
//			String goodsName = tradeRecordForm.getGoodsName();
//			if(goodsName==null || goodsName.equals("")){
//				goodsName="";
//			}else{
//				goodsName = " and t.goods.name like '%"+goodsName.trim() + "%' ";
//			}
//			String startTradeTime = tradeRecordForm.getStartTradeTime();
//			String endTradeTime = tradeRecordForm.getEndTradeTime();
//			String timeSpan = "";
//			if (startTradeTime != null && !startTradeTime.equals("")
//					&& endTradeTime != null && !endTradeTime.equals("")) {
//				timeSpan = "and t.tradeTime between '"
//						+ CutDateTime.cut(startTradeTime) + " 00' and '"
//						+ CutDateTime.cut(endTradeTime) + " 24'";
//			}
//			String hql = "from TradeRecord as t where t.user.id="+userId+" and t.tag=1 and isBuy=2"+ goodsName + timeSpan+" order by t.tradeTime desc";
//			this.page(request, hql);
            int total = tradeRecordService.collectionTradeRecordCountIsSole(userId, goodsName, startTradeTime, endTradeTime);
//			System.out.println("total=="+total);
            int currentPage = Integer.parseInt(request.getParameter("page"));
//			System.out.println("++++dwdw    "+currentPage);
            Page page = (Page) request.getAttribute("page");
            int everyPage = 10;//设置每页显示6条记录
            if (page == null) {
//				page = new Page(total, everyPage, currentPage);
                page = new Page(total, everyPage, currentPage);
//				System.out.println("page=null的"+page.getBeginIndex());
//				System.out.println(page.getNum());
                request.setAttribute("page", page);
            } else {
                page.setCurrentPage(currentPage);
//				System.out.println("page！=null的"+page.getBeginIndex());
                request.setAttribute("page", page);
            }
            List<com.shop.entity.TradeRecord> list = tradeRecordService.collectionTradeRecordsIsSole(userId, goodsName, startTradeTime, endTradeTime, page.getBeginIndex(), everyPage);
            for (com.shop.entity.TradeRecord tradeRecord : list) {
                setAttributrTradeRecord(tradeRecord, 2);
            }
            request.setAttribute("tradeRecord", list);
            return "system/tradeRecord/soleProducts";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    // 删除已买的交易记录
    @RequestMapping("/tradeRecord/deleteTradProducts.do")
    public String deleteTradProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//			TradeRecordForm tradeRecordForm = (TradeRecordForm) form;
            int delType = Integer.parseInt(request.getParameter("delType"));
            if (delType == 1) {
                Integer id = Integer.parseInt(request.getParameter("id"));
                //判断该记录是否属于该用户，否则无法删除
                com.shop.entity.TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(id);
                this.setAttributrTradeRecord(tradeRecord, 1);

                if (!tradeRecord.getUser().getId().equals(user.getId())) {
                    request.setAttribute("errorInfo", "非法操作！您无权删除该信息！");
                    return "system/error";
                }
//			int userId = user.getId();
//			int totalSize = tradeRecordService.getTotalSize(userId);
////			System.out.println("3232323232"+totalSize);
////			String hql = "from TradeRecord as t where t.user.id="+userId+" and t.tag=1 and isBuy=1 order by t.tradeTime desc";
//			this.page(userId,request, totalSize,1);
                int num = tradeRecordService.deleteTradeRecordById(id);
                complaintService.deleteComplaintByTradeId(id);

                if (num != 1) {
                    request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
                    return "system/error";
                }
                return "system/tradeRecord/tradPro";
//			return "system/tradeRecord/tradProducts";
            } else {
                String[] delIdsStr = request.getParameterValues("delId");
                System.out.println(Arrays.toString(delIdsStr));
                int[] delId = new int[delIdsStr.length];
                for (int i = 0; i < delIdsStr.length; i++) {
                    delId[i] = Integer.parseInt(delIdsStr[i]);
                    System.out.println(delId[i]);
                }

                //判断记录组是否属于该用户，否则无法删除
                for (int j : delId) {
                    com.shop.entity.TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(j);
                    setAttributrTradeRecord(tradeRecord, 1);
                    if (!tradeRecord.getUser().getId().equals(user.getId())) {
                        request.setAttribute("errorInfo", "非法操作！您无权删除信息！");
                        return "system/error";
                    }
                }
                for (int j : delId) {
                    tradeRecordService.deleteTradeRecordById(j);
                    complaintService.deleteComplaintByTradeId(j);
                }
                return "system/tradeRecord/tradPro";
            }
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";

        }
    }

    // 删除已卖的交易记录
    @RequestMapping("/tradeRecord/deleteSoleProducts.do")
    public String deleteSoleProducts(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//			TradeRecordForm tradeRecordForm = (TradeRecordForm) form;
            int delType = Integer.parseInt(request.getParameter("delType"));
            if (delType == 1) {
                Integer id = Integer.parseInt(request.getParameter("id"));
                //判断该记录是否属于该用户，否则无法删除
                com.shop.entity.TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(id);
                this.setAttributrTradeRecord(tradeRecord, 2);

                if (!tradeRecord.getUser().getId().equals(user.getId())) {
                    request.setAttribute("errorInfo", "非法操作！您无权删除该信息！");
                    return "system/error";
                }
//				int userId = user.getId();
//				int totalSize = tradeRecordService.getTotalSize(userId);
////			System.out.println("3232323232"+totalSize);
////			String hql = "from TradeRecord as t where t.user.id="+userId+" and t.tag=1 and isBuy=1 order by t.tradeTime desc";
//				this.page(userId,request, totalSize,1);
                int num = tradeRecordService.deleteTradeRecordById(id);
                if (num != 1) {
                    request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
                    return "system/error";
                }
                return "system/tradeRecord/solePro";
//			return "system/tradeRecord/tradProducts";
            } else {
                String[] delIdsStr = request.getParameterValues("delId");
//				System.out.println(Arrays.toString(delIdsStr));
                int[] delId = new int[delIdsStr.length];
                for (int i = 0; i < delIdsStr.length; i++) {
                    delId[i] = Integer.parseInt(delIdsStr[i]);
                    System.out.println(delId[i]);
                }

                //判断记录组是否属于该用户，否则无法删除
                for (int j : delId) {
                    com.shop.entity.TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(j);
                    setAttributrTradeRecord(tradeRecord, 2);
                    if (!tradeRecord.getUser().getId().equals(user.getId())) {
                        request.setAttribute("errorInfo", "非法操作！您无权删除信息！");
                        return "system/error";
                    }
                }
                for (int j : delId) {
                    tradeRecordService.deleteTradeRecordById(j);
                }
                return "system/tradeRecord/solePro";
            }
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";

        }
    }

}
