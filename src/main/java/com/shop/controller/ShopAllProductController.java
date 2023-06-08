package com.shop.controller;

import com.shop.entity.Shop;
import com.shop.service.ShopAllProductService;
import com.shop.service.ShopService;
import com.shop.utils.PageEvaluation;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

/*
 * author:wuyixin
 *
 */
@Controller
public class ShopAllProductController {
    @Resource
    private ShopAllProductService shopAllProductService;

    @Resource
    private ShopService shopService;
//
//	public void setShopAllProductService(ShopAllProductService shopAllProductService) {
//		this.shopAllProductService = shopAllProductService;
//	}

    //用户在店铺页点击搜索按钮，按条件搜索符合条件的商品
    @RequestMapping("/findAllProInShop.do")
    public String findAllProInShop(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        Shop shopByUserId = shopService.getShopByUserId(userId);
        int shopId = shopByUserId.getId();
        String proKeyWord = request.getParameter("proKeyWord");
        proKeyWord = java.net.URLDecoder.decode(proKeyWord, "UTF-8");//进行解码
        String oneProPrice = request.getParameter("oneProPrice");
        String twoProPrice = request.getParameter("twoProPrice");

        if (!oneProPrice.matches("^\\d+(\\.\\d+)?$")) {
            oneProPrice = "";

        }
        if (!twoProPrice.matches("^\\d+(\\.\\d+)?$")) {
            twoProPrice = "";
        }
//		if (!oneProPrice.equals("") && !twoProPrice.equals("")){
//
//		}

        //\\s表示过滤掉任意空白字符，如空格、制表符、换行符等,\\\\表示过滤掉\,其中—和-分中文和英文
        proKeyWord = proKeyWord.replaceAll("[-!@#$%^`~&/'*()（）—_{}:;><+.,?=\\[\\]\\|\\s\\\\]", "");

        if (proKeyWord.length() > 16) {
            proKeyWord = proKeyWord.substring(0, 16);
        }
        if (currentPage == null) {
            currentPage = 1;
        }
        int limit = 24;    //每页24条记录
        int startIndex = (currentPage - 1) * limit;//当前页从哪条记录开始
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //因为hibernate会进行自身关联，会出现 There is a cycle in the hierarchy 异常，所有要过滤关联的集合属性

        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("com/cjmqy/shop") || name.equals("messages")
                        || name.equals("collectionGoodses")
                        || name.equals("tradeRecords")
                        || name.equals("collectionShops")
                        || name.equals("user")
                        || name.equals("shopAnnouces")
                        || name.equals("lastNewses")
                        || name.equals("goodses")) {
                    return true;
                } else {
                    return false;
                }
            }

        });

        List<com.shop.entity.Goods> goodsList = shopAllProductService.findAllProInShop(shopId, proKeyWord, oneProPrice, twoProPrice, startIndex, limit);


        int totalRecord = shopAllProductService.findAllProInShopCount(shopId, proKeyWord, oneProPrice, twoProPrice);


        PageEvaluation page = new PageEvaluation(totalRecord, limit, currentPage);//总记录数，每页多少条记录，当前页

        JSONObject pjson = JSONObject.fromObject(page);
        JSONArray gjson = JSONArray.fromObject(goodsList, config);

        JSONObject o = new JSONObject();
        o.accumulate("p", pjson);
        o.accumulate("g", gjson);


        out.println(o);
        out.flush();
        out.close();

        return null;

    }

    //
    //用户通过店铺左边的商品分类搜索最热，最新，二手商品
    @RequestMapping("/findHotNewOldProInShop.do")
    public String findHotNewOldProInShop(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        int userId = Integer.parseInt(request.getParameter("userId"));
        int goodsType = Integer.parseInt(request.getParameter("goodsType"));
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        //因为hibernate会进行自身关联，会出现 There is a cycle in the hierarchy 异常，所有要过滤关联的集合属性

        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("com/cjmqy/shop") || name.equals("messages")
                        || name.equals("collectionGoodses")
                        || name.equals("tradeRecords")
                        || name.equals("collectionShops")
                        || name.equals("user")
                        || name.equals("shopAnnouces")
                        || name.equals("lastNewses")
                        || name.equals("goodses")) {
                    return true;
                } else {
                    return false;
                }
            }

        });
        Shop shopByUserId = shopService.getShopByUserId(userId);
        int shopId = shopByUserId.getId();
        List<com.shop.entity.Goods> goodsList = shopAllProductService.findHotNewOldProInShop(shopId, goodsType);
        JSONArray gjson = JSONArray.fromObject(goodsList, config);
        JSONObject o = new JSONObject();
        o.accumulate("g", gjson);
        out.println(o);
        out.flush();
        out.close();

        return null;

    }

    //=======================================================

    //用户在店铺页点击搜索按钮，按条件搜索符合条件的商品
    @RequestMapping("/findOtherProInShop.do")
    public String findOtherProInShop(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));

        int userId = Integer.parseInt(request.getParameter("userId"));
        Shop shopByUserId = shopService.getShopByUserId(userId);
        Integer shopId = shopByUserId.getId();

        int goodsType = Integer.parseInt(request.getParameter("goodsType"));

        String proKeyWord = request.getParameter("proKeyWord");


        proKeyWord = java.net.URLDecoder.decode(proKeyWord, "UTF-8");//进行解码

        String oneProPrice = request.getParameter("oneProPrice");
        String twoProPrice = request.getParameter("twoProPrice");

        if (!oneProPrice.matches("^\\d+(\\.\\d+)?$")) {
            oneProPrice = "";

        }

        if (!twoProPrice.matches("^\\d+(\\.\\d+)?$")) {
            twoProPrice = "";
        }


        //\\s表示过滤掉任意空白字符，如空格、制表符、换行符等,\\\\表示过滤掉\,其中—和-分中文和英文
        proKeyWord = proKeyWord.replaceAll("[-!@#$%^`~&/'*()（）—_{}:;><+.,?=\\[\\]\\|\\s\\\\]", "");


        if (proKeyWord.length() > 16) {

            proKeyWord = proKeyWord.substring(0, 16);
        }


        if (currentPage == null) {
            currentPage = 1;
        }

        int limit = 24;    //每页24条记录
        int startIndex = (currentPage - 1) * limit;//当前页从哪条记录开始

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        //因为hibernate会进行自身关联，会出现 There is a cycle in the hierarchy 异常，所有要过滤关联的集合属性

        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("com/cjmqy/shop") || name.equals("messages")
                        || name.equals("collectionGoodses")
                        || name.equals("tradeRecords")
                        || name.equals("collectionShops")
                        || name.equals("user")
                        || name.equals("shopAnnouces")
                        || name.equals("lastNewses")
                        || name.equals("goodses")) {
                    return true;
                } else {
                    return false;
                }
            }

        });

        List<com.shop.entity.Goods> goodsList = shopAllProductService.findOtherProInShop(shopId, proKeyWord, oneProPrice, twoProPrice, goodsType, startIndex, limit);


        int totalRecord = shopAllProductService.findOtherProInShopCount(shopId, proKeyWord, oneProPrice, twoProPrice, goodsType);


        PageEvaluation page = new PageEvaluation(totalRecord, limit, currentPage);//总记录数，每页多少条记录，当前页

        JSONObject pjson = JSONObject.fromObject(page);
        JSONArray gjson = JSONArray.fromObject(goodsList, config);

        JSONObject o = new JSONObject();
        o.accumulate("p", pjson);
        o.accumulate("g", gjson);


        out.println(o);
        out.flush();
        out.close();

        return null;

    }

}
