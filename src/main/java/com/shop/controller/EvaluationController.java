package com.shop.controller;


import com.shop.entity.Evaluation;
import com.shop.service.EvaluationService;
import com.shop.service.GoodsService;
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
public class EvaluationController {
    @Resource
    EvaluationService evaluationService;
    @Resource
    GoodsService goodsService;


    //添加评价
    @RequestMapping("/evaluation/addEvaluation.do")
    public String addEvaluation(HttpServletRequest request, HttpServletResponse response) throws Exception {

//        EvaluationForm evaluationForm = (EvaluationForm) form;
        //获得商品的id
//        Integer goodId = evaluationForm.getGoodId();
        response.setContentType("application/x-json;charset=utf-8");
        PrintWriter out = response.getWriter();
        int goodId = Integer.parseInt(request.getParameter("goodId"));

//        String hql = "from Evaluation e where e.goods="+goodId+" and e.tag=1 order by e.createDate desc";
        int totalRecords = evaluationService.getTotalEvaluationByGoodId(goodId);
        PageEvaluation page = new PageEvaluation(totalRecords, 6, 1);
        List<Evaluation> list = evaluationService.getEvaluationsByGoodId(goodId, 0, 6);  //从找到的第0条记录开始
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("goods")) { //要过滤的areas ，Map对象中的
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
        o.accumulate("evaluations", es);
        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        //如果用户未登录，则跳转到登录页面
        if (user == null) {
            o.accumulate("login", "noLogin");
            o.accumulate("content", "");
            out.println(o);
            return null;
        }
        o.accumulate("login", "login");
        String content = request.getParameter("content");
//        String content = evaluationForm.getContent();

        //输入文本文字数目
        String wordNum = request.getParameter("wordId");
//        String wordNum =evaluationForm.getWordId();
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

        //判断是否匿名
        if (content.equals("") || content == null) {
            o.accumulate("content", "noContent");
            out.println(o);
            return null;
        } else if (wordCount > 200) {
            o.accumulate("content", "tooLong");
            out.println(o);
            return null;
        }
        o.accumulate("content", "content");
        String[] anonymity = request.getParameterValues("anonymity");
//        String[] anonymity = evaluationForm.getAnonymity();
        Evaluation evaluation = new Evaluation();
        String name = user.getUserName();
        if (anonymity[0].equals("1")) {
            evaluation.setAuthorName("匿名");
        } else {
            evaluation.setAuthorName(name);
        }
        //每连续95个数字字母或-，就插入一个<br/>
        content = InsertStringRegex.insertStringRegex(content, "[a-zA-Z0-9-]{80}", "<br/>");

        //设置评价内容
        evaluation.setContent(content);
        //获得当前时间
        Timestamp ts = new Timestamp(new Date().getTime());
        //截取时间
        String now = ts.toString().substring(0, 19);
        evaluation.setCreateDate(now);
        evaluation.setGoodsId(goodId);
        evaluation.setGoods(goodsService.findGoodsById(goodId));
        //设置评价的状态标志
        evaluation.setTag(1);
        evaluationService.addEvaluation(evaluation);
        if (list.size() == 6) {
            list.remove(list.size() - 1);

        }
        list.add(0, evaluation);
        page = new PageEvaluation(totalRecords + 1, 6, 1);
        p = JSONObject.fromObject(page);
        es = JSONArray.fromObject(list, config);

        JSONObject all = new JSONObject();
        all.accumulate("evaluations", es);
        all.accumulate("p", p);
        all.accumulate("content", "content");
        all.accumulate("login", "login");
        out.println(all);
        return null;
    }


    //
    //分页
    @RequestMapping("/evaluation/pageEvaluation.do")
    public String pageEvaluation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //配置json过滤的相关参数
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object source, String name, Object value) {
                if (name.equals("goods")) { //要过滤的areas ，Map对象中的
                    return true;
                } else {
                    return false;
                }
            }
        });
        //currentPage是需要显示的第几页
        Integer currentPage = 1;
        try {

            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        } catch (Exception e) {
            currentPage = 1;
        }

        if (currentPage == null) {
            currentPage = 1;
        }
        //每页显示6条记录
        int limit = 6;

        //设置响应的内容格式为json数据类型
        response.setContentType("application/x-json;charset=utf-8");
        //获得响应的输出工具
        PrintWriter out = response.getWriter();

        List<Evaluation> evaluations = new ArrayList<Evaluation>();
        Integer id = Integer.parseInt(request.getParameter("goodsId"));
        String hql = "from Evaluation e where e.goods=" + id + " and e.tag=1 order by e.createDate desc";
        Integer totalRecords = evaluationService.getTotalEvaluationByGoodId(id);
        Page page1 = new Page(totalRecords, limit, currentPage);
        Integer allPages = totalRecords / 6;
        if (totalRecords % 6 != 0) {
            allPages += 1;
        }
        //如果查询的页码比所有的页大，则查询最大的页
        if (currentPage > allPages) {
            currentPage = allPages;
        }
        //当前页的第一条记录的索引
        int startIndex = (currentPage - 1) * limit;
        //获得指定条件的评价集合
        evaluations = evaluationService.getEvaluationsByGoodId(id, page1.getBeginIndex(), page1.getEveryPage());
        //分页对象
        PageEvaluation page = new PageEvaluation(totalRecords, 6, currentPage);

        //获得分页对象的json类型数据
        JSONObject p = JSONObject.fromObject(page);
        //获得评价集合的json数组数据
        JSONArray s = JSONArray.fromObject(evaluations, config);
        //获得一个json对象，用于叠加两个json数据
        JSONObject o = new JSONObject();
        o.accumulate("p", p);
        o.accumulate("evaluations", s);
        out.println(o);
        out.flush();
        out.close();
        return null;
    }


}
