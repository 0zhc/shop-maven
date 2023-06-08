package com.shop.controller;


import com.shop.entity.ShopEvaluation;
import com.shop.service.ShopEvaluationService;
import com.shop.utils.InsertStringRegex;
import com.shop.utils.PageEvaluation;
import com.shop.utils.pageUtil.Page;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ShopEvaluationController {
    @Resource
    public ShopEvaluationService shopEvaluationService;
//	public ShopService shopService;

    @RequestMapping("/shopEvaluation/addShopEvaluation.do")
    public String addShopEvaluation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//		ShopEvaluationForm shopEvaluationForm = (ShopEvaluationForm) form;
//		Integer shopId = shopEvaluationForm.getShopId();
        response.setContentType("application/x-json;charset=utf-8");
        String shopIdStr = request.getParameter("shopId");
        int shopId = Integer.parseInt(shopIdStr);
        PrintWriter out = response.getWriter();
//		String hql = "from ShopEvaluation se where se.shop="+shopId+" and se.tag=1 order by se.createDate desc";
        int totalRecords = shopEvaluationService.getTotal(shopId);
        PageEvaluation page = new PageEvaluation(totalRecords, 6, 1);
        List<ShopEvaluation> list = shopEvaluationService.getShopEvaluationsByHql(shopId, 0, 6);  //从找到的第0条记录开始
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("shop")) { //要过滤的areas ，Map对象中的
                    return true;
                } else {
                    return false;
                }
            }
        });
        JSONObject p = JSONObject.fromObject(page);
        JSONArray es = JSONArray.fromObject(list, config);

        JSONObject o = new JSONObject();
        o.accumulate("p", p);
        o.accumulate("shopEvaluations", es);

        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        if (user == null) {
            o.accumulate("login", "noLogin");
            out.println(o);
            return null;
        }
        o.accumulate("login", "login");


        String content = request.getParameter("content");
//		String content = shopEvaluationForm.getContent();
        //输入文本文字数目
        String wordNum = request.getParameter("wordNum");
//		String wordNum =shopEvaluationForm.getWordId();
        Integer wordCount = 0;
        try {
            wordCount = Integer.parseInt(wordNum);
        } catch (Exception e) {
            wordCount = 0;
        }

        //禁掉js的情况
        if ("".equals(wordNum)) {
            if (content.length() <= 200) {
                //如果用户故意禁掉js，就不能使用html代码的样式了
                content = content.replaceAll("<", "&lt");
                content = content.replaceAll(">", "&gt");
            }
        }

        //没有禁掉js的情况则ke自动进行了转换处理
        if (content.equals("") || content == null) {
            o.accumulate("content", "noContent");
            out.print(o);
            return null;
        } else if (wordCount > 200) {
            o.accumulate("content", "tooLong");
            out.print(o);
            return null;
        }
        o.accumulate("content", "content");

        ShopEvaluation shopEvaluation = new ShopEvaluation();
        String[] anonymity = request.getParameterValues("anonymity");
//		String[] anonymity = shopEvaluationForm.getAnonymity();
        String name = ((com.shop.entity.User) request.getSession().getAttribute("user")).getUserName();
        shopEvaluation.setAuthorName(name);
        if (anonymity[0].equals("1")) {
            shopEvaluation.setAuthorName("匿名");
        }
        //每连续95个数字字母或-，就插入一个<br/>
        content = InsertStringRegex.insertStringRegex(content, "[a-zA-Z0-9-]{80}", "<br/>");

        shopEvaluation.setContent(content);
        Timestamp ts = new Timestamp(new Date().getTime());
        String now = ts.toString().substring(0, 19);
        shopEvaluation.setCreateDate(now);
        shopEvaluation.setShopId(shopId);
        shopEvaluation.setTag(1);
        shopEvaluationService.addShopEvaluation(shopEvaluation);
        if (list.size() == 6) {
            list.remove(list.size() - 1);

        }
        list.add(0, shopEvaluation);
        page = new PageEvaluation(totalRecords + 1, 6, 1);
        p = JSONObject.fromObject(page);
        es = JSONArray.fromObject(list, config);

        JSONObject all = new JSONObject();
        all.accumulate("shopEvaluations", es);
        all.accumulate("p", p);
        all.accumulate("content", "content");
        all.accumulate("login", "login");
        out.println(all);
        return null;
    }


    @RequestMapping("/shopEvaluation/pageShopEvaluation.do")
    public String pageShopEvaluation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("shop")) { //要过滤的areas ，Map对象中的
                    return true;
                } else {
                    return false;
                }
            }
        });
        Integer currentPage = 1;
        String sCurrentPage = request.getParameter("currentPage");
        try {
            currentPage = Integer.parseInt(sCurrentPage);
        } catch (Exception e) {
            currentPage = 1;
        }

        if (currentPage == null) {
            currentPage = 1;
        }

        System.out.println("当前页数" + currentPage);
        int limit = 6;
        response.setContentType("application/x-json;charset=utf-8");
        PrintWriter out = response.getWriter();

        List<ShopEvaluation> shopEvaluations = new ArrayList<ShopEvaluation>();
        Integer id = Integer.parseInt(request.getParameter("shopId"));
//		String hql = "from ShopEvaluation e where e.shop="+id+" and e.tag=1 order by e.createDate desc";

        Integer totalRecords = shopEvaluationService.getTotal(id);
        Page page1 = new Page(totalRecords, limit, currentPage);

        Integer allPages = totalRecords / 6;
        if (totalRecords % 6 != 0) {
            allPages += 1;
        }
        System.out.println("全部页数" + allPages);
        //如果查询的页码比所有的页大，则查询最大的页
        if (currentPage > allPages) {
            currentPage = allPages;
        }
        //当前页的第一条记录的索引
        int startIndex = (currentPage - 1) * limit;
        shopEvaluations = shopEvaluationService.getShopEvaluationsByHql(id, page1.getBeginIndex(), page1.getEveryPage());

        PageEvaluation page = new PageEvaluation(totalRecords, 6, currentPage);
        JSONObject p = JSONObject.fromObject(page);
        JSONArray s = JSONArray.fromObject(shopEvaluations, config);
        JSONObject o = new JSONObject();
        o.accumulate("p", p);
        o.accumulate("shopEvaluations", s);
        out.println(o);
        out.flush();
        out.close();
        return null;
    }
//
}
