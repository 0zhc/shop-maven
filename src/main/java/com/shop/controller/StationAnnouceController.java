package com.shop.controller;


import com.shop.entity.StationAnnouce;
import com.shop.entity.User;
import com.shop.service.StationAnnouceService;
import com.shop.service.UserService;
import com.shop.utils.DateTime;
import com.shop.utils.Regex;
import com.shop.utils.TextFilterUtil;
import com.shop.utils.pageUtil.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;

@Controller
public class StationAnnouceController {

    private int currentpage = 1;
    @Resource
    private StationAnnouceService stationAnnouceService;
    @Resource
    private UserService userService;


    // 分页
    public void page(HttpServletRequest request, int total, String startTime, String endTime, int isCondition) {
        int max = 10;
        List<StationAnnouce> list;
        String num = request.getParameter("page");
        if (num != null) {
            currentpage = Integer.parseInt(num);
        }
        Page page = (Page) request.getAttribute("page");
        if (page == null) {
            page = new Page(total, max, currentpage);
            request.setAttribute("page", page);
        } else {
            page.setCurrentPage(currentpage);
            request.setAttribute("page", page);
        }
        if (isCondition == 1) {
            list = stationAnnouceService.findStationAnnoucesByTime(startTime, endTime, page.getBeginIndex(), max);
        } else {
            if (isCondition == 0) {
                list = stationAnnouceService.findStationAnnouces(page.getBeginIndex(), max);
            } else {
                list = stationAnnouceService.findStationAnnoucesByState(startTime, endTime, page.getBeginIndex(), max);
            }

        }
        for (StationAnnouce stationAnnouce : list) {
            Integer userId = stationAnnouce.getUserId();
            User userById = userService.getUserById(userId);
            stationAnnouce.setUser(userById);
        }

        request.setAttribute("stationAnnouce", list);
    }


    // 查询所有的公告信息
    @RequestMapping("/stationAnnouce/searchAllStationAnnouces.do")
    public String searchAllStationAnnouces(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int totalStationAnnouce = stationAnnouceService.getTotalStationAnnouce();
//			String hql = "from StationAnnouce as s where s.tag=1 order by s.inTime desc";
            this.page(request, totalStationAnnouce, "", "", 0);
            return "system/checkInfo/searchsiteAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    // 查看公告信息
    @RequestMapping("/stationAnnouce/selectStationAnnouce.do")
    public String selectStationAnnouce(HttpServletRequest request,
                                       HttpServletResponse response) throws Exception {
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
            StationAnnouce stationAnnouce = stationAnnouceService.getStationAnnouceById(id);
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            request.setAttribute("stationAnnouce", stationAnnouce);
            return "system/checkInfo/selectSiteAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    // 查看公告信息
    @RequestMapping("/stationAnnouce/selectSendStationAnnouce.do")
    public String selectSendStationAnnouce(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
            StationAnnouce stationAnnouce = stationAnnouceService.getStationAnnouceById(id);
//			UUID uuid = UUID.randomUUID();
//			String token = uuid.toString().replaceAll("-", "");
//			// 访问页面时随机生成一个token保存在服务端session中
//			request.getSession().setAttribute("TOKEN", token);
            request.setAttribute("stationAnnouce", stationAnnouce);
            return "system/checkInfo/selectStationAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }


    @RequestMapping("/stationAnnouce/modifyStationAnnouces.do")
    public String modifyStationAnnouces(HttpServletRequest request, HttpServletResponse response) {
        /*防止重复提交*/
//		String token = request.getParameter("TOKEN");
//		String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//		request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
        Object sessionTokenObj = request.getParameter("token");
        request.getSession().removeAttribute("TOKEN");
        if (sessionTokenObj != null) {
            try {
                User user = (User) request.getSession().getAttribute("user");
                if (user == null || user.equals("")) {
                    request.getSession().invalidate();
                    return "cjmqylogin/login";
                }
//				StationAnnouceForm stationAnnouceForm = (StationAnnouceForm) form;
                //输入文本文字数目
                String wordNum = request.getParameter("word");

                // 服务器验证
                String id = request.getParameter("id");
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String stateStr = request.getParameter("state");

//				Integer id = stationAnnouceForm.getId();
//				String title = stationAnnouceForm.getTitle();
//				String content = stationAnnouceForm.getContent();
//				Integer state = stationAnnouceForm.getState();
                if (id == null || title == null || content == null || stateStr == null) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";
                } else {
//					int state = Integer.parseInt(stateStr);
                    //禁掉js的情况
                    if ("".equals(wordNum)) {
                        if (content.length() <= 1200) {
                            content = TextFilterUtil.replaceCode(content);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    } else {
                        if (Integer.parseInt(wordNum) <= 1200) {
                            content = TextFilterUtil.replaceIllegalCode(content);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    }
                    boolean flag = (Regex.validateText(title, 30) && Regex.validateRadio(Integer.parseInt(stateStr)));
                    if (!flag) {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                }
//				int state = Integer.parseInt(stateStr);

                String inTime = DateTime.getNow();
                StationAnnouce stationAnnouce = stationAnnouceService.getStationAnnouceById(Integer.parseInt(id));
                stationAnnouce.setUser(user);
                stationAnnouce.setUserId(user.getId());
                stationAnnouce.setTitle(title);
                stationAnnouce.setContent(content);
                stationAnnouce.setInTime(inTime);
                stationAnnouce.setState(Integer.parseInt(stateStr));
                stationAnnouce.setTag(1);
                stationAnnouceService.updateStationAnnouce(stationAnnouce, Integer.parseInt(id));

                // 更新公告数
                if (Integer.parseInt(stateStr) == 2) {
                    ServletContext application = request.getSession().getServletContext();
                    Integer stationAnnouceCount = stationAnnouceService.getTotalSize();
                    application.setAttribute("stationAnnouceCount", stationAnnouceCount);
                }

                return "system/checkInfo/annouceEnd";
            } catch (Exception e) {
                request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
                return "system/error";
            }
        } else {
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
        }

    }

    // 删除公告信息
    @RequestMapping("/stationAnnouce/deleteStationAnnouces.do")
    public String deleteStationAnnouces(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }

            //服务器验证
            String getId = request.getParameter("id");
            if (getId == null || getId.equals("")) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            }

            Integer id = Integer.parseInt(getId);
            stationAnnouceService.deleteStationAnnouce(id);

            // 更新公告数
            ServletContext application = request.getSession().getServletContext();
            Integer stationAnnouceCount = stationAnnouceService.getTotalSize();
            application.setAttribute("stationAnnouceCount", stationAnnouceCount);

            int totalStationAnnouce = stationAnnouceService.getTotalStationAnnouce();
//			String hql = "from StationAnnouce as s where s.tag=1 order by s.inTime desc";
            this.page(request, totalStationAnnouce, "", "", 0);
            return "system/checkInfo/searchsiteAnouce";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    // 发送公告信息
    @RequestMapping("/stationAnnouce/sendStationAnnouces.do")
    public String sendStationAnnouces(HttpServletRequest request,
                                      HttpServletResponse response) throws Exception {
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
            StationAnnouce stationAnnouce = stationAnnouceService.getStationAnnouceById(id);
            stationAnnouce.setInTime(DateTime.getNow());
            stationAnnouce.setState(2);
            stationAnnouceService.updateStationAnnouce(stationAnnouce, id);

            // 更新公告数
            ServletContext application = request.getSession().getServletContext();
            Integer stationAnnouceCount = stationAnnouceService.getTotalSize();
            application.setAttribute("stationAnnouceCount", stationAnnouceCount);

            int totalStationAnnouce = stationAnnouceService.getTotalStationAnnouce();
//			String hql = "from StationAnnouce as s where s.tag=1 order by s.inTime desc";
            this.page(request, totalStationAnnouce, "", "", 0);
            return "system/checkInfo/searchsiteAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }

    }

    // 根据条件查询公告信息
    @RequestMapping("/stationAnnouce/searchStationAnnouces.do")
    public String searchStationAnnouces(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//			StationAnnouceForm stationAnnouceForm = (StationAnnouceForm) form;
//			String startTime = stationAnnouceForm.getStartTime();
//			String endTime = stationAnnouceForm.getEndTime();
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
//			String timeSpan = "";
//			if (startTime != null && !startTime.equals("") && endTime != null && !endTime.equals("")) {
//				timeSpan = "and s.inTime between '"
//						+ CutDateTime.cut(startTime) + " 00' and '"
//						+ CutDateTime.cut(endTime) + " 24'";
//			}
//			String hql = "from StationAnnouce as s where s.tag=1 " + timeSpan
//					+ "order by s.inTime desc";
            int countStationAnnouces = stationAnnouceService.getTotalStationAnnouceByTime(startTime, endTime);
            this.page(request, countStationAnnouces, startTime, endTime, 1);
            return "system/checkInfo/searchsiteAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    @RequestMapping("/stationAnnouce/searchTimeSendStationAnnouces.do")
    public String searchTimeSendStationAnnouces(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//			StationAnnouceForm stationAnnouceForm = (StationAnnouceForm) form;
//			String startTime = stationAnnouceForm.getStartTime();
//			String endTime = stationAnnouceForm.getEndTime();
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
//			String timeSpan = "";
//			if (startTime != null && !startTime.equals("") && endTime != null && !endTime.equals("")) {
//				timeSpan = "and s.inTime between '"
//						+ CutDateTime.cut(startTime) + " 00' and '"
//						+ CutDateTime.cut(endTime) + " 24'";
//			}
//			String hql = "from StationAnnouce as s where s.tag=1 " + timeSpan
//					+ "order by s.inTime desc";
            int countStationAnnouces = stationAnnouceService.getTotalStationAnnouceByTimeAndState(startTime, endTime);
            this.page(request, countStationAnnouces, startTime, endTime, 2);
            return "system/checkInfo/searchStationAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    // 查询已发送的公告信息
    @RequestMapping("/stationAnnouce/searchSendStationAnnouces.do")
    public String searchSendStationAnnouces(HttpServletRequest request, HttpServletResponse response) {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int totalStationAnnouces = stationAnnouceService.getTotalSize();
//			String hql = "from StationAnnouce as s where s.tag=1 and s.state=2 order by s.inTime desc";
            this.page(request, totalStationAnnouces, "", "", 2);
            return "system/checkInfo/searchStationAnouce";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
            return "system/error";
        }
    }

    @RequestMapping("/stationAnnouce/beforeAddStationAnnouce.do")
    public String beforeAddStationAnnouce(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.equals("")) {
            request.getSession().invalidate();
            return "cjmqylogin/login";
        }
        UUID uuid = UUID.randomUUID();
        String token = uuid.toString().replaceAll("-", "");
        // 访问页面时随机生成一个token保存在服务端session中
        request.getSession().setAttribute("TOKEN", token);
        return "system/checkInfo/addsiteAnouce";
    }

    // 增加公告信息
    @RequestMapping("/stationAnnouce/addStationAnnouce.do")
    public String addStationAnnouce(HttpServletRequest request, HttpServletResponse response) throws Exception {
        /*防止重复提交*/
        Object sessionTokenObj = request.getParameter("token");
        request.getSession().removeAttribute("TOKEN");
        if (sessionTokenObj != null) {
            try {
                User user = (User) request.getSession().getAttribute("user");
                if (user == null || user.equals("")) {
                    request.getSession().invalidate();
                    return "cjmqylogin/login";
                }

//				StationAnnouceForm stationAnnouceForm = (StationAnnouceForm) form;
                //输入文本文字数目
                String wordNum = request.getParameter("word");
                // 服务器验证
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String stateStr = request.getParameter("state");
                if (title == null || content == null || stateStr == null) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";
                } else {
                    //禁掉js的情况
                    if ("".equals(wordNum)) {
                        if (content.length() <= 1200) {
                            content = TextFilterUtil.replaceCode(content);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    } else {
                        if (Integer.parseInt(wordNum) <= 1200) {
                            content = TextFilterUtil.replaceIllegalCode(content);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    }
                    boolean flag = (Regex.validateText(title, 30)
                            && Regex.validateRadio(Integer.parseInt(stateStr)));
                    if (!flag) {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                }

                String inTime = DateTime.getNow();
                StationAnnouce stationAnnouce = new StationAnnouce();
                stationAnnouce.setUser(user);
                stationAnnouce.setUserId(user.getId());
                stationAnnouce.setTitle(title);
                stationAnnouce.setContent(content);
                stationAnnouce.setInTime(inTime);
                stationAnnouce.setState(Integer.parseInt(stateStr));
                stationAnnouce.setTag(1);
                stationAnnouceService.saveStationAnnounce(stationAnnouce);

                // 更新公告数
                if (Integer.parseInt(stateStr) == 2) {
                    ServletContext application = request.getSession().getServletContext();
                    Integer stationAnnouceCount = stationAnnouceService.getTotalSize();
                    application.setAttribute("stationAnnouceCount", stationAnnouceCount);
                }

                return "system/checkInfo/annouceEnd";
            } catch (Exception e) {
                request.setAttribute("errorInfo", "很抱歉，服务器繁忙！");
                return "system/error";
            }
        } else {
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
        }

    }

}
