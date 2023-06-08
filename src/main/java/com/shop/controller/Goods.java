package com.shop.controller;


import com.shop.service.GoodsService;
import com.shop.utils.Page;
import com.shop.utils.PageEvaluation;
import com.shop.utils.Regex;
import com.shop.utils.TextFilterUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class Goods {

    @Resource
    private GoodsService goodsService;


    //搜索用户过滤掉乱码
    @RequestMapping("/searchgoodsMiddle.do")
    public String searchGoodsMiddle(HttpServletRequest request, HttpServletResponse response) {
        try {
            int isNewType = 0;
            String shopBuyType = request.getParameter("shopBuyType");
            if (shopBuyType != null) {
                shopBuyType = java.net.URLDecoder.decode(shopBuyType, "UTF-8");//进行解码
                request.setAttribute("shopBuyType", shopBuyType);

            }
            String isNew = request.getParameter("isNew").trim().replaceAll(" ", "");
            isNew = java.net.URLDecoder.decode(isNew, "UTF-8");//进行解码
            if ("商品".equals(isNew)) {
                isNewType = 1;//为商品
            } else {
                if ("二手商品".equals(isNew)) {
                    isNewType = 2;//为商品
                } else {
                    if ("店铺".equals(isNew)) {
                        isNewType = 3;//为店铺
                    }
                }
            }

            String name = request.getParameter("name").trim().replaceAll(" ", "");
            request.setAttribute("isNew", isNewType);
            request.setAttribute("name", name);
            if (isNewType == 1 || isNewType == 2) {
                return "search_shops_goods/searchgoods";
            }
            if (isNewType == 3) {
                return "search_shops_goods/searchshops";
            }
            return "system/error";
        } catch (Exception e) {
            System.out.println(e);
            return "system/error";

        }
    }

    //用户分页查询所有的商品
    @RequestMapping("/search_shops_goods/searchAllGoodsByName.do")
    public String findAllGoodsByName(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            System.out.println("_______");
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            PrintWriter out = response.getWriter();
            int isNew = Integer.parseInt(request.getParameter("isNew"));
            int isSore = Integer.parseInt(request.getParameter("isSore"));
            System.out.println("000000000");
            String name = request.getParameter("name");
            float beginPrice = Float.parseFloat((request.getParameter("beginPrice")));
            float endPrice = Float.parseFloat((request.getParameter("endPrice")));
            int currentPage = 1;
            if (request.getParameter("currentPage") != null) {
                currentPage = Integer.parseInt(request.getParameter("currentPage"));
            }
            System.out.println("++++++++++++++++++++++++");
            JsonConfig config = new JsonConfig();
//		JsonConfig config = new JsonConfig();
            System.out.println("++++++++++++++++++++++++");
            //  config.registerJsonValueProcessor(Date.class, new DateJsonProcessor());
            config.setJsonPropertyFilter((source, name1, value) -> {
                if (name1.equals("shop") || name1.equals("messages") || name1.equals("collectionGoodses") || name1.equals("tradeRecords") || name1.equals("collectionShops")) {
                    return true;
                } else {
                    return false;
                }
            });

            int totalRecords = goodsService.getAllGoodsCount(isNew, name, isSore, beginPrice, endPrice);
            int everyPageRecords = 5;//设置每页显示5条记录
            PageEvaluation page = new PageEvaluation(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
            List<com.shop.entity.Goods> goodses = goodsService.getAllGoodses((currentPage - 1) * everyPageRecords, page.getEveryPageRecord(), isNew, name, isSore, beginPrice, endPrice);
            JSONObject pageJson = JSONObject.fromObject(page);
            if (goodses == null) {
                goodses = new ArrayList<com.shop.entity.Goods>();
            }
            JSONArray goodsesJson = JSONArray.fromObject(goodses, config);
            JSONObject o = new JSONObject();
            o.accumulate("p", pageJson);
            o.accumulate("goodsesJson", goodsesJson);
//			for (int i=0;i<o.size();i++){
//
//			}
            System.out.println(o);
            out.println(o);
            out.flush();
            out.close();
            return null;
        } catch (Exception e) {
            System.out.println(e);


        }
        return null;
    }


    //商品的详细信息通过商品的 id
    @RequestMapping("/shop/pro_detail.do")
    public String goodsDetail(HttpServletRequest request, HttpServletResponse response) {
        int goodsId = Integer.parseInt(request.getParameter("goodsId"));

        com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);
        request.setAttribute("goods", goods);
        return "shop/pro_detail";
    }
//
//
//		//liuming
//		public ActionForward getGood(ActionMapping mapping, ActionForm form,
//				HttpServletRequest request, HttpServletResponse response)
//				throws Exception {
//
//			Integer goodsId = Integer.parseInt(request.getParameter("goodsId"));
//			Goods goods = goodsService.findGoodsById(goodsId);
//			request.setAttribute("good",goods);
//			return mapping.findForward("getGood");
//		}
//	}

    //用户分页查询自己的商品
    @RequestMapping("/system/selectUserGoodsByPage.do")
    public String userQueyGoodsByPage(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("jspType");//查询不同的页面
        int goodsType = 0;
        if (request.getParameter("goodsType") == null) {
            goodsType = 1;
        } else {
            goodsType = Integer.parseInt(request.getParameter("goodsType"));
        }
        String name = request.getParameter("name");
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        int userId = user.getId();
        int currentPage = 1;
        if (request.getParameter("currentpage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentpage"));
        }
        int totalRecords = goodsService.count(goodsType, name, userId);//得到总的记录数
        int everyPageRecords = 5;//设置每页显示5条记录
        Page page = new Page(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
        System.out.println("当前页数" + page.getCurrentPage());
        List<com.shop.entity.Goods> goodses = goodsService.goodses(page.getBeginIndexRecord(), page.getEveryPageRecords(), goodsType, name, userId);
        request.setAttribute("goodses", goodses);
        request.setAttribute("goodsType", goodsType);
        request.setAttribute("page", page);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("name", name);
        if ("otherGoods".equals(type)) {

            return "/shop/shopModify/otherProduct/selectOtherGoods";

        }
        if ("shopSelectGoods".equals(type)) {
            return "/system/shop/selectGoods";
        }
        return "/system/shop/selectGoods";

    }

    //
    //同过商品Id查找用户商品
    @RequestMapping("/system/shop/myshop/goodsDetail.do")
    public String findUserGoodsById(HttpServletRequest request, HttpServletResponse response) {
        int goodsId = Integer.parseInt(request.getParameter("goodsId"));
        com.shop.entity.Goods goods = goodsService.findGoodsById(goodsId);
        request.setAttribute("goods", goods);
        String type = request.getParameter("JspType");
        request.setAttribute("goodsId", goodsId);
        if ("datail".equals(type)) {
            return "/system/shop/myshop/goodsDetail";
        } else if ("modifydatail".equals(type)) {
            return "/system/shop/myshop/modify_myproduct";
        } else {
            if ("otherModifyDatail".equals(type)) {
                return "shop/shopModify/otherProduct/modify_otherProduct";
            }

        }
        if ("otherDatail".equals(type)) {
            return "/shop/shopModify/otherProduct/otherProductInfo";
        }
        if ("secondDatail".equals(type)) {
            return "shop/shopModify/productModify/secondProductDetail";
        }
        if ("secondModifyDatail".equals(type)) {
            return "shop/shopModify/productModify/modify_secondProduct";
        }
        if ("newDatail".equals(type)) {
            return "shop/shopModify/productModify/newProductDetail";
        }
        if ("newModifyDatail".equals(type)) {
            return "shop/shopModify/productModify/modify_newProduct";
        }
        if ("hotDatail".equals(type)) {
            return "shop/shopModify/productModify/hotProductDetail";
        }
        if ("hotModifyDatail".equals(type)) {

            return "shop/shopModify/productModify/modify_hotProduct";//修改成功
        }
        if ("modify_bannerListDatail".equals(type)) {

            return "shop/shopModify/productModify/modify_bannerList";//修改成功
        }


        return "/system/shop/myshop/goodsDetail";
    }


    //
//	//同过用户Id删除商品
//	public ActionForward deleteUserGoodsById(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response)
//			throws Exception {
//		int goodsId=Integer.parseInt(request.getParameter("goodsId"));
//		if(goodsService.deleteGoodsById(goodsId)){
//			return mapping.findForward("ok");
//		}
//		return mapping.findForward("no");
//	}
    //修改用户商品信息
    @RequestMapping("/system/modifyUserGoods.do")
    public String modifyUserGoodsById(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String jspType = request.getParameter("jspType");
        int goodsId = Integer.parseInt(request.getParameter("goodsId"));
        //输入文本文字数目
        String wordNum = request.getParameter("word");

//		GoodsForm goodsForm=(GoodsForm)form;
        com.shop.entity.Goods goods = new com.shop.entity.Goods();
        String goodsIsNewStr = request.getParameter("goodsIsNew");
        Integer goodsIsNew = Integer.parseInt(goodsIsNewStr);
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        float price = Float.parseFloat(priceStr);
        String brand = request.getParameter("brand");
        String size = request.getParameter("size");
        String amountStr = request.getParameter("amount");
        int amount = Integer.parseInt(amountStr);
        String color = request.getParameter("color");
        String origin = request.getParameter("origin");
        String weight = request.getParameter("weight");
        String productAdd = request.getParameter("productAdd");
        String description = request.getParameter("description");
        String sizeUnit = request.getParameter("sizeUnit");
        String amountUnit = request.getParameter("amountUnit");
        String grossUnit = request.getParameter("grossUnit");


//		String name = goodsForm.getName();
//		float price = goodsForm.getPrice();
//		String brand = goodsForm.getBrand();
//		String size = goodsForm.getSize();
//		Integer amount = goodsForm.getAmount();
//		String color = goodsForm.getColor();
//		String origin = goodsForm.getOrigin();
//		String weight = goodsForm.getWeight();
//		String productAdd = goodsForm.getProductAdd();
//		String descripttion = goodsForm.getDescription();
//		String sizeUnit = goodsForm.getSizeUnit();
//		String amountUnit = goodsForm.getAmountUnit();
//		String grossUnit = goodsForm.getGrossUnit();


        System.out.println("00000000000" + description);
        System.out.println("wordNum" + wordNum);

        //服务器验证
        if (goodsIsNewStr.equals("") || name == null || brand == null || size == null || amountStr.equals("") || color == null || origin == null || weight == null || productAdd == null ||
                description == null || sizeUnit == null || amountUnit == null || grossUnit == null) {
            request.setAttribute("errorInfo", "非法操作！");

            System.out.println("1111111111" + description);

            return "system/error";

        } else {

            //禁掉js的情况
            if ("".equals(wordNum)) {
                if (description.length() <= 500) {
                    description = TextFilterUtil.replaceCode(description);
                    System.out.println("2222222222");
                } else {
                    request.setAttribute("errorInfo", "非法操作！");
                    System.out.println("3333333333");
                    return "system/error";

                }
            } else {
                if (Integer.parseInt(wordNum) <= 500) {
                    System.out.println("4444444444");
                    description = TextFilterUtil.replaceIllegalCode(description);
                } else {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";

                }
            }
            boolean flag = (Regex.validateGoodName(name) && Regex.validateBrand(brand) && Regex.validateGoodSize(size) && Regex.validateGoodAmount(amount + "") && Regex.validateGoodColor(color) && Regex.validateGoodOrigin(origin) && Regex.validateGoodWeight(weight) &&
                    Regex.validateGoodAddress(productAdd) && Regex.validateGoodColor(sizeUnit) && Regex.validateGoodAmountUnit(amountUnit) && Regex.validateGoodColor(grossUnit) && Regex.validateGoodPrice(price + ""));

            System.out.println("flag=" + flag);

            if (!flag) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";

            }
        }
        goods.setGoodsIsNew(goodsIsNew);//1为全新  2 为二手
        System.out.println(goodsIsNew + "999999999");
        Date date = new Date();
        goods.setCreateDate(date);
        goods.setName(name);
        goods.setPrice(price);
        goods.setBrand(brand);
        goods.setSize(size);
        goods.setAmount(amount);
        goods.setColor(color);
        goods.setOrigin(origin);
        goods.setWeight(weight);
        goods.setProductAdd(productAdd);
        goods.setDescription(description);
        goods.setSizeUnit(sizeUnit);
        goods.setAmountUnit(amountUnit);

        goods.setGrossUnit(grossUnit);

        if (goodsService.ModifyGoodsById(goodsId, goods)) {
            if ("otherModify".equals(jspType)) {
                return "/shop/shopModify/otherProduct/modifyok";//修改成功
            }
            if ("otherAdd".equals(jspType)) {
                return "/shop/shopModify/otherProduct/addok";//修改成功
            }
            if ("secondAdd".equals(jspType)) {
                return "/shop/shopModify/productModify/Tips/secondaddok";//修改成功
            }
            if ("secondModify".equals(jspType)) {
                return "/shop/shopModify/productModify/Tips/secondmodifyok";//修改成功
            }
            if ("newAdd".equals(jspType)) {
                return "/shop/shopModify/productModify/Tips/newAddok";//修改成功
            }
            if ("newModify".equals(jspType)) {
                return "/shop/shopModify/productModify/Tips/newModifyok";//修改成功
            }
            if ("hotAdd".equals(jspType)) {
                return "/shop/shopModify/productModify/Tips/hotAddok";//修改成功
            }
            if ("hotModify".equals(jspType)) {

                return "/shop/shopModify/productModify/Tips/hotModifyok";//修改成功
            }


        }


        return "system/error";//修改失败
    }


}
