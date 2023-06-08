package com.shop.controller;

import com.shop.entity.Complaint;
import com.shop.entity.ComplaintReply;
import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.service.*;
import com.shop.utils.CountUtil;
import com.shop.utils.DateTime;
import com.shop.utils.Regex;
import com.shop.utils.TextFilterUtil;
import com.shop.utils.pageUtil.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class ComplaintAlert {

    private int currentpage = 1;
    @Resource
    private ComplaintAlertService complaintAlertService;
    @Resource
    private ComplaintReplyService complaintReplyService;
    @Resource
    private ComplaintService complaintService;
    @Resource
    private UserService userService;
    @Resource
    private ShopService shopService;


    // 分页
    public void page(HttpServletRequest request, int totalComplaintAlert, int userId) {
        int max = 10;
        List<com.shop.entity.ComplaintAlert> list;
        String num = request.getParameter("page");
        if (num != null) {
            currentpage = Integer.parseInt(num);
        }
        Page page = (Page) request.getAttribute("page");
        if (page == null) {
            page = new Page(totalComplaintAlert, max, currentpage);
            request.setAttribute("page", page);
        } else {
            page.setCurrentPage(currentpage);
            request.setAttribute("page", page);
        }
        System.out.println(page.getBeginIndex());
        if (userId == 0) {
            list = complaintAlertService.findComplaintAlert(page.getBeginIndex(), max);
        } else {
            list = complaintAlertService.findComplaintAlertByUserId(userId, page.getBeginIndex(), max);
        }
        for (int i = 0; i < list.size(); i++) {
            com.shop.entity.ComplaintAlert complaintAlert = list.get(i);
            Integer userId1 = complaintAlert.getUserId();
            User userById = userService.getUserById(userId1);
            Shop shopByUserId = shopService.getShopByUserId(userId1);
            userById.setShop(shopByUserId);
            complaintAlert.setUser(userById);

        }
//	 list = complaintAlertService.findComplaintAlertByUserId(userId, page.getBeginIndex(), max);
        request.setAttribute("complaintAlerts", list);
    }

    @RequestMapping("/searchComplaintAlertData.do")
    @ResponseBody
    public List<com.shop.entity.ComplaintAlert> searchComplaintAlertData(HttpServletRequest request, HttpServletResponse response) throws Exception {

        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        int userId = user.getId();
        List<com.shop.entity.ComplaintAlert> list = complaintAlertService.findComplaintAlertById(userId);
//			for (int i=0;i<list.size();i++){
//				com.shop.entity.ComplaintAlert complaintAlert = list.get(i);
//				Integer userId1 = complaintAlert.getUserId();
//				User userById = userService.getUserById(userId1);
//				Shop shopByUserId = shopService.getShopByUserId(userId1);
//				userById.setShop(shopByUserId);
//				complaintAlert.setUser(userById);
//
//			}
        return list;
    }


    //查询商家警告
    @RequestMapping("/complaint/searchComplaintAlert.do")
    public String searchComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int userId = user.getId();
            int totalComplaintAlert = complaintAlertService.getTotalSize(userId);
//			String hql = "from ComplaintAlert as c where c.user.id="+userId+" and c.tag=1 order by c.alertTime desc";
            this.page(request, totalComplaintAlert, userId);
            return "system/weiquan/querycomothercomplainresult/otherComplaint";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查询失败！");
            return "system/error";
        }
    }

    //查看警告
    @RequestMapping("/complaint/selectComplaintAlert.do")
    public String selectComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer id = Integer.parseInt(request.getParameter("id"));
            com.shop.entity.ComplaintAlert complaintAlert = complaintAlertService.getComplaintAlertById(id);
            Integer userId = complaintAlert.getUserId();
            User userById = userService.getUserById(userId);
            Shop shopByUserId = shopService.getShopByUserId(userId);
            userById.setShop(shopByUserId);
            complaintAlert.setUser(userById);
            Integer preRightId = complaintAlert.getPreRightId();
            Complaint complaintById = complaintService.findComplaintById(preRightId);
            complaintAlert.setComplaint(complaintById);
            request.setAttribute("complaintAlert", complaintAlert);
            List<com.shop.entity.ComplaintReply> complaintReplies = complaintReplyService.findComplaintReplyByPreRightId(preRightId, 2);
            for (ComplaintReply complaintReply : complaintReplies) {
                Integer writerId = complaintReply.getWriterId();
                com.shop.entity.User writerUser = userService.getUserById(writerId);
                complaintReply.setWriter(writerUser);
            }
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            request.setAttribute("complaintReply", complaintReplies);
            return "system/weiquan/querycomothercomplainresult/selectResult";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查看失败！");
            return "system/error";
        }
    }

    //管理员查看警告
    @RequestMapping("/complaint/selectAdminComplaintAlert.do")
    public String selectAdminComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer id = Integer.parseInt(request.getParameter("id"));
            com.shop.entity.ComplaintAlert complaintAlert = complaintAlertService.getComplaintAlertById(id);
            Integer userId = complaintAlert.getUserId();
            User userById = userService.getUserById(userId);
            Shop shopByUserId = shopService.getShopByUserId(userId);
            userById.setShop(shopByUserId);
            complaintAlert.setUser(userById);
            Integer preRightId = complaintAlert.getPreRightId();
            Complaint complaintById = complaintService.findComplaintById(preRightId);
            complaintAlert.setComplaint(complaintById);
            request.setAttribute("complaintAlert", complaintAlert);
            List<com.shop.entity.ComplaintReply> complaintReplies = complaintReplyService.findComplaintReplyByPreRightId(preRightId, 2);
            for (ComplaintReply complaintReply : complaintReplies) {
                Integer writerId = complaintReply.getWriterId();
                com.shop.entity.User writerUser = userService.getUserById(writerId);
                complaintReply.setWriter(writerUser);
            }
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            request.setAttribute("complaintReply", complaintReplies);
            return "system/weiquan/querycomallplains/selectAlertResult";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查看失败！");
            return "system/error";
        }
    }

    //删除警告
    @RequestMapping("/complaint/deleteComplaintAlert.do")
    public String deleteComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User complaintUser = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (complaintUser == null || complaintUser.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer id = Integer.parseInt(request.getParameter("id"));
            complaintAlertService.deleteComplaintAlertById(id);

            //警告数
            ServletContext application = request.getSession().getServletContext();
//			ComplaintAlert complaintAlert = complaintAlertService.getComplaintAlert(id);
//			String complaintAlertHql = "from ComplaintAlert as c where c.user.id="+complaintAlert.getUser().getId()+" and c.tag=1";
            Integer complaintAlertCount = complaintAlertService.getTotalSize(complaintUser.getId());
            Map<Integer, Integer> complaintAlertMap = CountUtil.getComplaintAlertMap();
            complaintAlertMap.put(complaintUser.getId(), complaintAlertCount);
            application.setAttribute("complaintAlertCount", complaintAlertMap);
            int totalComplaintAlert = complaintAlertService.getTotalSize(complaintUser.getId());
//			String hql = "from ComplaintAlert as c where c.user.id="+userId+" and c.tag=1 order by c.alertTime desc";
            this.page(request, totalComplaintAlert, complaintUser.getId());
            return "system/weiquan/querycomothercomplainresult/otherComplaint";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "删除失败！");
            return "system/error";
        }
    }

    //管理员删除警告
    @RequestMapping("/complaint/deleteAdminComplaintAlert.do")
    public String deleteAdminComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User complaintUser = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (complaintUser == null || complaintUser.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer id = Integer.parseInt(request.getParameter("id"));
            complaintAlertService.deleteComplaintAlertById(id);

            //警告数
            ServletContext application = request.getSession().getServletContext();
//			ComplaintAlert complaintAlert = complaintAlertService.getComplaintAlert(id);
//			String complaintAlertHql = "from ComplaintAlert as c where c.user.id="+complaintAlert.getUser().getId()+" and c.tag=1";
            Integer complaintAlertCount = complaintAlertService.getTotalSize(complaintUser.getId());
            Map<Integer, Integer> complaintAlertMap = CountUtil.getComplaintAlertMap();
            complaintAlertMap.put(complaintUser.getId(), complaintAlertCount);
            application.setAttribute("complaintAlertCount", complaintAlertMap);

            int totalComplaintAlert = complaintAlertService.totalComplaintAlert();
//			String hql = "from ComplaintAlert as c where c.user.id="+userId+" and c.tag=1 order by c.alertTime desc";
            this.page(request, totalComplaintAlert, 0);
            return "system/weiquan/querycomallplains/queryAllComplaintAlert";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "删除失败！");
            return "system/error";
        }
    }


    //获取维权
    @RequestMapping("/complaint/getComplaintAlert.do")
    public String getComplaintAlert(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            com.shop.entity.User User = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (User == null || User.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer complaintId = Integer.parseInt(request.getParameter("complaintId"));
            com.shop.entity.Complaint complaint = complaintService.findComplaintById(complaintId);
            Integer userId = complaint.getUserId();
            com.shop.entity.User userById = userService.getUserById(userId);
            Shop shopByUserId = shopService.getShopByUserId(userId);
            userById.setShop(shopByUserId);
            complaint.setUser(userById);
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            request.setAttribute("complaint", complaint);
            return "system/weiquan/querycomallplains/alertsysytemComplain";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "服务器繁忙！");
            return "system/error";
        }
    }

    //增加警告
    @RequestMapping("/complaint/addComplaintAlert.do")
    public String addComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        /*防止重复提交*/
        Object sessionTokenObj = request.getParameter("token");
        request.getSession().removeAttribute("TOKEN");
//		 String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//		 request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
        if (sessionTokenObj != null) {
            try {
                com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
                if (user == null || user.equals("")) {
                    request.getSession().invalidate();
                    return "cjmqylogin/login";
                }
                //输入文本文字数目
                String wordNum = request.getParameter("word");
                String complaintId = request.getParameter("complaintId");
                String userId = request.getParameter("userId");
                String title = request.getParameter("title");
                String alertContent = request.getParameter("alertContent");
//			ComplaintAlertForm complaintAlertForm = (ComplaintAlertForm) form;
//			Integer complaintId = complaintAlertForm.getComplaintId();
//			Integer userId = complaintAlertForm.getUserId();
//			String title = complaintAlertForm.getTitle();
//			String alertContent = complaintAlertForm.getAlertContent();

                if (userId == null || complaintId == null || title == null || alertContent == null) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";
                } else {
                    //禁掉js的情况
                    if ("".equals(wordNum)) {
                        if (alertContent.length() <= 1200) {
                            alertContent = TextFilterUtil.replaceCode(alertContent);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    } else {
                        if (Integer.parseInt(wordNum) <= 1200) {
                            alertContent = TextFilterUtil.replaceIllegalCode(alertContent);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    }
                    boolean flag = Regex.validateText(title, 30);
                    if (!flag) {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                }

                com.shop.entity.Complaint complaint = complaintService.findComplaintById(Integer.valueOf(complaintId));
//			User alertMan = userService.findUserByUserId(userId);
                String alertTime = DateTime.getNow();
                com.shop.entity.ComplaintAlert complaintAlert = new com.shop.entity.ComplaintAlert();
                complaintAlert.setUserId(Integer.parseInt(userId));
                complaintAlert.setPreRightId(Integer.valueOf(complaintId));
//			complaintAlert.setComplaint(complaint);
//			complaintAlert.setUser(alertMan);
                complaintAlert.setTitle(title);
                complaintAlert.setAlertContent(alertContent);
                complaintAlert.setAlertTime(alertTime);
                complaintAlert.setTag(1);
                complaintAlertService.addComplaintAlert(complaintAlert);
                complaint.setAlertType(2);
                complaintService.updateComplaintById(Integer.parseInt(complaintId));

                //警告数
//			ServletContext application = request.getSession().getServletContext();
//			String complaintAlertHql = "from ComplaintAlert as c where c.user.id="+alertMan.getId()+" and c.tag=1";
//			Integer complaintAlertCount = complaintAlertService.getTotalSize(complaintAlertHql);
//			Map<Integer,Integer> complaintAlertMap = CountUtil.getComplaintAlertMap();
//			complaintAlertMap.put(alertMan.getId(), complaintAlertCount);
//			application.setAttribute("complaintAlertCount", complaintAlertMap);
                ServletContext application = request.getSession().getServletContext();
//			ComplaintAlert complaintAlert = complaintAlertService.getComplaintAlert(id);
//			String complaintAlertHql = "from ComplaintAlert as c where c.user.id="+complaintAlert.getUser().getId()+" and c.tag=1";
                Integer complaintAlertCount = complaintAlertService.getTotalSize(Integer.valueOf(userId));
                Map<Integer, Integer> complaintAlertMap = CountUtil.getComplaintAlertMap();
                complaintAlertMap.put(Integer.valueOf(userId), complaintAlertCount);
                application.setAttribute("complaintAlertCount", complaintAlertMap);

                return "system/weiquan/querycomallplains/compainAlertEnd";
            } catch (Exception e) {
                System.out.println(e);
                request.setAttribute("errorInfo", "增加警告失败！");
                return "system/error";
            }
        } else {
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
        }
    }


    //查询所有警告（管理员）
    @RequestMapping("/complaint/searchAllComplaintAlert.do")
    public String searchAllComplaintAlert(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//				String hql = "from ComplaintAlert as c where c.tag=1 order by c.alertTime desc";
            int totalComplaintAlert = complaintAlertService.totalComplaintAlert();
            this.page(request, totalComplaintAlert, 0);
            return "system/weiquan/querycomallplains/queryAllComplaintAlert";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查询失败！");
            return "system/error";
        }
    }


//


    //获取公告数，投诉数，警告数,顾客订单数，已下订单数
    @RequestMapping("/count.do")
    public String count(HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.equals("")) {
            request.getSession().invalidate();
            return "cjmqylogin/login";
        }
        ServletContext application = request.getSession().getServletContext();

        Map<Integer, Integer> complaintMap = (Map<Integer, Integer>) application.getAttribute("complaintCount");
        Integer complaintCount = complaintMap.get(user.getId());
        Map<Integer, Integer> complaintAlertMap = (Map<Integer, Integer>) application.getAttribute("complaintAlertCount");
        Integer complaintAlertCount = complaintAlertMap.get(user.getId());

        Integer stationAnnouceCount = (Integer) application.getAttribute("stationAnnouceCount");

        Map<Integer, Integer> cusOrderMap = (Map<Integer, Integer>) application.getAttribute("cusOrderCount");
        Integer cusOrderCount = cusOrderMap.get(user.getId());

        Map<Integer, Integer> ownOrderMap = (Map<Integer, Integer>) application.getAttribute("ownOrderCount");
        Integer ownOrderCount = ownOrderMap.get(user.getId());

        if (complaintCount == null) {
            complaintCount = 0;
        }
        if (complaintAlertCount == null) {
            complaintAlertCount = 0;
        }
        if (stationAnnouceCount == null) {
            stationAnnouceCount = 0;
        }
        if (cusOrderCount == null) {
            cusOrderCount = 0;
        }
        if (ownOrderCount == null) {
            ownOrderCount = 0;
        }
        Integer menberCount = complaintMap.size();
        String count = "<complaint>" + complaintCount + "</complaint>" + "<complaintAlert>" + complaintAlertCount + "</complaintAlert>" + "<stationAnnouce>" + stationAnnouceCount + "</stationAnnouce>" + "<cusOrder>" + cusOrderCount + "</cusOrder>" + "<ownOrder>" + ownOrderCount + "</ownOrder>" + "<menber>" + menberCount + "</menber>";
        PrintWriter out = response.getWriter();
        response.setContentType("text/xml; charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        out.println("<response>");
        out.println(count);
        out.println("</response>");
        out.flush();
        out.close();
        return null;

    }

}
