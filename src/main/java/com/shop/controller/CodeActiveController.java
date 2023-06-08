package com.shop.controller;

import com.shop.entity.CodeActive;
import com.shop.entity.User;
import com.shop.service.CodeActiveService;
import com.shop.service.UserService;
import com.shop.utils.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class CodeActiveController {
    @Resource
    private UserService userService;
    @Resource
    private CodeActiveService codeActiveService;
//     private CodeActiveService  codeActiveService;
//      private UserService userService;
////
//
// 	//修改用户类型 1 为学生   2 为商家


    //增加激活码
    @RequestMapping("/system/addCodeActive.do")
    public String addCodeActive(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String codeActive = request.getParameter("codeActive");
        com.shop.entity.User user = userService.findUserByUserName(userName);
        System.out.println(user);
        if (user != null) {
            Integer businessId = user.getId();
            CodeActive codeActive1 = codeActiveService.findCodeActiveByBusinessId(businessId);
            if (codeActive1 == null) {
                codeActiveService.add(businessId, codeActive);
                request.setAttribute("isAdd", "yes");
            }

//			return "system/shop/myshop/ispromotOpenShop/addCode";
        }
        return "system/shop/myshop/ispromotOpenShop/addCode";
    }


    //分页查询所有激活码
    @RequestMapping("/system/selectCodeActiveByPage.do")
    public String queryActivesByPage(HttpServletRequest request, HttpServletResponse response) {
        String userName = request.getParameter("userName");
        String activeCode = request.getParameter("activeCode");
        int currentPage = 1;

        if (request.getParameter("currentpage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentpage"));
        }
        int totalRecords = codeActiveService.counts(userName, activeCode);//得到总的记录数
        int everyPageRecords = 5;//设置每页显示5条记录
        Page page = new Page(totalRecords, everyPageRecords, currentPage);//调用有三个参数的构造方法
        List<CodeActive> codeActives = codeActiveService.activeCodes(page.getBeginIndexRecord(), page.getEveryPageRecords(), userName, activeCode);
        for (int i = 0; i < codeActives.size(); i++) {
            CodeActive codeActive = codeActives.get(i);
            Integer businessId = codeActive.getBusinessId();
            User userById = userService.getUserById(businessId);
            codeActive.setUser(userById);

        }
        request.setAttribute("codeActives", codeActives);
        request.setAttribute("page", page);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("userName", userName);
        request.setAttribute("activeCode", activeCode);
        return "system/shop/myshop/ispromotOpenShop/selectCode";
    }


}
