package com.shop.controller;


import com.shop.entity.User;
import com.shop.service.*;
import com.shop.utils.CountUtil;
import com.shop.utils.FileUtil;
import com.shop.utils.PasswordEncryption;
import com.shop.utils.Regex;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

@Controller
public class Login {

    @Resource
    private LoginService loginService;
    @Resource
    private StationAnnouceService stationAnnouceService;
    @Resource
    private ComplaintService complaintService;
    @Resource
    private ComplaintAlertService complaintAlertService;
    @Resource
    private OrderService orderService;

    //登录
    @RequestMapping("/login.do")
    public String login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PrintWriter out = response.getWriter();
        String userName = request.getParameter("userName");
        String userPassword = request.getParameter("userPassword");
        String userType = request.getParameter("userType");

        if (loginService.isExist(userName, PasswordEncryption.MD5(userPassword), userType)) {
            out.print("ok");//用户存在，登录成功
            User user = loginService.getUserByUserName(userName);
            request.getSession().setAttribute("user", user);
            request.getSession().setMaxInactiveInterval(2700);//参数900单位是秒，即在没有活动15分钟后，session将失效。

            //liuming
            //初始化公告数、投诉数、警告数、顾客订单数、已下订单数
            ServletContext application = request.getSession().getServletContext();
            //投诉数
            Integer complaintCount = complaintService.getTotal(user.getId());
            Map<Integer, Integer> complaintMap = CountUtil.getComplaintMap();
            complaintMap.put(user.getId(), complaintCount);
            application.setAttribute("complaintCount", complaintMap);
            //警告数
            Integer complaintAlertCount = complaintAlertService.getTotalSize(user.getId());
            System.out.println("-----------" + complaintAlertCount);
            Map<Integer, Integer> complaintAlertMap = CountUtil.getComplaintAlertMap();

            complaintAlertMap.put(user.getId(), complaintAlertCount);
            application.setAttribute("complaintAlertCount", complaintAlertMap);
            //公告数
            String stationAnnouceHql = "from StationAnnouce as s where s.tag=1 and s.state=2";
            Integer stationAnnouceCount = stationAnnouceService.getTotalSize();
            System.out.println("-----------" + stationAnnouceCount);

            application.setAttribute("stationAnnouceCount", stationAnnouceCount);


            //顾客订单数
//			String cusOrderHql = "from GoodsOrder as g where g.good.shop.user.id="+user.getId()+" and g.tag=1 and g.state=1 order by g.tradeTime desc";
            Integer cusOrderCount = orderService.getTotalUNSHIPPED(user.getId(), 1);
            Map<Integer, Integer> cusOrderMap = CountUtil.getCusOrderMap();
            cusOrderMap.put(user.getId(), cusOrderCount);
            application.setAttribute("cusOrderCount", cusOrderMap);


            //已下订单数
//			String ownOrderHql = "from GoodsOrder as g where g.user.id="+user.getId()+" and g.tag=1 and g.state=2 order by g.tradeTime desc";
            Integer ownOrderCount = orderService.getTotalSize(user.getId(), 2);
            Map<Integer, Integer> ownOrderMap = CountUtil.getOwnOrderMap();
            ownOrderMap.put(user.getId(), ownOrderCount);
            application.setAttribute("ownOrderCount", ownOrderMap);
            if ("2".equals(userType)) {
                request.getSession().setAttribute("right", user.getUserName());
                return "index";
//				return mapping.findForward("system_index");//返回到后台
            }
            return null;
        }
        out.print("no");//用户不存在，登录失败
        return null;
    }


    @RequestMapping("/loginOut.do")
    //注销用户
    public String loginOut(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        if (request.getSession().getAttribute("user") != null) {
            request.getSession().invalidate();
        }

        return "redirect:/";
    }

    @RequestMapping("/user/loginOut.do")
    //注销用户
    public String userLoginout(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        if (request.getSession().getAttribute("user") != null) {
            request.getSession().invalidate();
        }

        return "redirect:/";
    }


    @RequestMapping("/registerUserName.do")
    public String checkUserName(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        PrintWriter out = response.getWriter();
        String userName = request.getParameter("userName");
        if (loginService.findUserByUserName(userName) == 0) {
            out.print("ok");//用户不存在
            return null;
        }
        out.print("no");//用户存在
        return null;
    }


    //	//检测注册验证码是否正确
    @RequestMapping("/validateCode.do")
    public String validateCode(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String checkcode = request.getParameter("checkcode");

        String ccode = (String) request.getSession().getAttribute("ccode");
//		System.out.println("---------"+checkcode);
//		System.out.println("---------"+ccode);
        PrintWriter out = response.getWriter();//打印

        if (ccode.equals(checkcode)) {
            out.print("true");
        } else {
            out.print("false");
        }
        return null;

    }


    //注册
    @RequestMapping("/register.do")
    public String register(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        /*防止重复提交*/
        String userName = request.getParameter("userName");
        String callName = request.getParameter("callName");
        String userPassword = request.getParameter("userPassword");
        String email = request.getParameter("email");
        String sex = request.getParameter("sex");


        boolean flag = Regex.validateUsername(userName)
                && Regex.validatCallName(callName)
                && Regex.validateNewPassword(userPassword)
                && Regex.validateConPassword(userPassword, request.getParameter("confirmPassword"))
                && Regex.validateEmail(email);


        if (!flag) {
            //如果非法操作还是返回注册页面res.jsp，返回date值为illegality.jsp页面的html代码
            //return mapping.findForward("illegalityString");

            out.print("no");////注册失败
            return null;

        }
        User user = new User();
        user.setUserName(userName);
        user.setCallName(callName);
        user.setUserPassword(PasswordEncryption.MD5(userPassword));

        user.setEmail(email);
        user.setSex(Integer.parseInt(sex));
        user.setUserType(1);//1 为默认学生  2 为商家
        user.setSysRole(1);//权利为1 为一般用户    2 为系统管理员
        user.setTag(1);
        user.setQq("");
//		user.setEmail("");
        user.setIdentityld("");
        user.setCreateDate(new Date());
        if (loginService.add(user) == 1) {

            request.setAttribute("callName", callName);
            request.setAttribute("userName", userName);
            request.getSession().setAttribute("userName", userName);
            request.getSession().setAttribute("callName", callName);
            FileUtil fileUtil = new FileUtil();
            fileUtil.newFile(request.getRealPath("\\images\\Shoper"), user.getUserName());//以用户名+id创建一个文件
            //File file=new File(request.getRealPath("\\images\\Shoper")+"\\student");//创建文件名
            //System.out.println(fileUtil.getFileSize(file));得到文件的大小 单位为 k

            out.print("ok");//注册成功
            return null;


        }

        out.print("no");////注册失败
        return null;
    }


}
