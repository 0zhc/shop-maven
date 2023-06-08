package com.shop.controller;

import com.shop.entity.ComplaintReply;
import com.shop.entity.Shop;
import com.shop.entity.TradeRecord;
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
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class Complaint {
    //
    @Resource
    private TradeRecordService tradeRecordService;
    @Resource
    private UserService userService;
    @Resource
    private ComplaintService complaintService;
    @Resource
    private ShopService shopService;
    @Resource
    private GoodsService goodsService;
    @Resource
    private ComplaintReplyService complaintReplyService;
    private int currentpage = 1;


//	private ComplaintReplyService complaintReplyService;

    // 分页
    public void page(HttpServletRequest request, int total, int complaintId) {
        int max = 10;
        List<com.shop.entity.Complaint> list = null;
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
        if (complaintId == 0) {
            list = complaintService.findAllComplaint();
        } else {
            list = complaintService.findComplaintByComplaintId(complaintId, page.getBeginIndex(), max);
        }

        for (com.shop.entity.Complaint complaint : list) {
            Integer complaintId1 = complaint.getComplaintId();
            User userById1 = userService.getUserById(complaintId1);
            complaint.setComplaint(userById1);
            Integer tradeId = complaint.getTradeId();
            TradeRecord tradeRecordById = tradeRecordService.findTradeRecordById(tradeId);
            complaint.setTradeRecord(tradeRecordById);
            Integer userId = complaint.getUserId();
            User userById = userService.getUserById(userId);
            Shop shopByUserId = shopService.getShopByUserId(userId);
            userById.setShop(shopByUserId);
            complaint.setUser(userById);
        }
        request.setAttribute("complaints", list);
    }

    //增加维权
    @RequestMapping("/complaint/addComplaint.do")
    public String addComplaint(HttpServletRequest request, HttpServletResponse response) {
        Object sessionTokenObj = request.getSession().getAttribute("TOKEN");
//		String paramToken = request.getParameter("TOKEN");
        request.getSession().removeAttribute("TOKEN");
        if (sessionTokenObj == null) {
            // 表单重复提交
//			System.out.println("Session token is NULL!");
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
//			return true;
        }
//		if(paramToken == null||!paramToken.equals(sessionTokenObj.toString())) {
//			// 非法请求
//			request.getSession().invalidate();
//			return "cjmqylogin/login";
//
//		}
        try {
            com.shop.entity.User complaintUser = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (complaintUser == null || complaintUser.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer complaintId = complaintUser.getId();
//			Integer tradeId = (Integer) request.getAttribute("tradeId");
            Integer tradeId = Integer.parseInt(request.getParameter("tradeId"));
//			Integer userId = (Integer) request.getAttribute("userId");
            System.out.println(request.getParameter("userId"));
            Integer userId = Integer.parseInt(request.getParameter("userId"));

            String complaintTime = DateTime.getNow();
            String complain = request.getParameter("complain");
            String detailreason = request.getParameter("detailreason");
            String wordNum = request.getParameter("word");
//			ComplaintForm complaintForm = (ComplaintForm) form;
//			String complaintTime = DateTime.getNow();
//			Integer userId = complaintForm.getUserId();
//			Integer tradeId = complaintForm.getTradeId();
//			String complain = complaintForm.getComplain();
//			String detailreason = complaintForm.getDetailreason();
            //输入文本文字数目

            //服务器验证
            if (userId == null || tradeId == null || complain == null || detailreason == null) {
                System.out.println(userId);
                System.out.println(tradeId);
                System.out.println(complain);
                System.out.println(detailreason);
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            } else {
                //禁掉js的情况
                if ("".equals(wordNum)) {
                    if (detailreason.length() <= 300) {
                        detailreason = TextFilterUtil.replaceCode(detailreason);
                    } else {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                } else {
                    if (Integer.parseInt(wordNum) <= 300) {
                        detailreason = TextFilterUtil.replaceIllegalCode(detailreason);
                    } else {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                }
                boolean flag = Regex.validateText(complain, 20);
                if (!flag) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";
                }
            }

            com.shop.entity.Complaint complaint = new com.shop.entity.Complaint();
//			complaint.setTradeRecord(tradeRecordService.findTradeRecordById(tradeId));
//			complaint.setUser(userService.findUserByUserId(userId));
            complaint.setTradeId(tradeId);
            complaint.setUserId(userId);
            complaint.setComplaintId(complaintId);
//			complaint.setComplaint(complaintUser);
            complaint.setComplain(complain);
            complaint.setDetailreason(detailreason);
            complaint.setComplaintTime(complaintTime);
            complaint.setAdminReply(1);
            complaint.setAlertType(1);
            complaint.setTag(1);
            complaintService.saveComplaint(complaint);
//			com.shop.entity.TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(tradeId);
//			tradeRecord.setPreRightsId(0);
            tradeRecordService.modifyTradeRecordById(tradeId);

            //更新投诉数
            ServletContext application = request.getSession().getServletContext();
//			String complaintHql = "from Complaint as c where c.complaint.id="+complaintUser.getId()+" and c.tag=1";
            Integer complaintCount = complaintService.getTotal(complaintUser.getId());
            Map<Integer, Integer> complaintMap = CountUtil.getComplaintMap();
            complaintMap.put(complaintUser.getId(), complaintCount);
            application.setAttribute("complaintCount", complaintMap);
            return "system/weiquan/trandcomplain/compainEnd";
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            request.setAttribute("errorInfo", "投诉操作失败！");
            return "system/error";
        }



        /*防止重复提交*/

//
//		String token = request.getParameter("TOKEN");
//		String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//
//		request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);


//		if(token.equals(token2)&& token2!=null){
//
//			try {
//				User complaintUser = (User) request.getSession().getAttribute("user");
//				if(complaintUser == null || complaintUser.equals("")){
//					request.getSession().invalidate();
//					return mapping.findForward("login");
//				}
//				ComplaintForm complaintForm = (ComplaintForm) form;
//				String complaintTime = DateTime.getNow();
//				Integer userId = complaintForm.getUserId();
//				Integer tradeId = complaintForm.getTradeId();
//				String complain = complaintForm.getComplain();
//				String detailreason = complaintForm.getDetailreason();
//				//输入文本文字数目
//				String wordNum =request.getParameter("word");
//				//服务器验证
//				if(userId==null || tradeId == null || complain == null || detailreason == null){
//					request.setAttribute("errorInfo", "非法操作！");
//					return mapping.findForward("error");
//				}else{
//					//禁掉js的情况
//					if("".equals(wordNum)){
//						if(detailreason.length()<=300){
//							detailreason = TextFilterUtil.replaceCode(detailreason);
//						}else{
//							request.setAttribute("errorInfo", "非法操作！");
//							return mapping.findForward("error");
//						}
//					}else{
//						if(Integer.parseInt(wordNum)<=300){
//							detailreason = TextFilterUtil.replaceIllegalCode(detailreason);
//						}else{
//							request.setAttribute("errorInfo", "非法操作！");
//							return mapping.findForward("error");
//						}
//					}
//					boolean flag = Regex.validateText(complain, 20);
//					if (!flag) {
//						request.setAttribute("errorInfo", "非法操作！");
//						return mapping.findForward("error");
//					}
//				}
//
//				Complaint complaint = new Complaint();
//				complaint.setTradeRecord(tradeRecordService.findTradeRecordById(tradeId));
//				complaint.setUser(userService.findUserByUserId(userId));
//				complaint.setComplaint(complaintUser);
//				complaint.setComplain(complain);
//				complaint.setDetailreason(detailreason);
//				complaint.setComplaintTime(complaintTime);
//				complaint.setAdminReply(1);
//				complaint.setAlertType(1);
//				complaint.setTag(1);
//				complaintService.saveComplaint(complaint);
//
//				TradeRecord tradeRecord = tradeRecordService.findTradeRecordById(tradeId);
//				tradeRecord.setPreRightsId(0);
//				tradeRecordService.modifyTradeRecord(tradeRecord);
//
//				//更新投诉数
//				ServletContext application = request.getSession().getServletContext();
//				String complaintHql = "from Complaint as c where c.complaint.id="+complaintUser.getId()+" and c.tag=1";
//				Integer complaintCount = complaintService.getTotalSize(complaintHql);
//				Map<Integer,Integer> complaintMap =  CountUtil.getComplaintMap();
//				complaintMap.put(complaintUser.getId(), complaintCount);
//				application.setAttribute("complaintCount", complaintMap);
//
//				return mapping.findForward("addComplaint");
//			} catch (Exception e) {
//				e.printStackTrace();
//				request.setAttribute("errorInfo", "投诉操作失败！");
//				return mapping.findForward("error");
//			}
//		}
//		else{
//			request.setAttribute("errorInfo", "不允许重复提交！");
//			return mapping.findForward("error");
//		}
    }

    //查看维权信息
    @RequestMapping("/complaint/selectComplaint.do")
    public String selectComplaint(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User complaintUser = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (complaintUser == null || complaintUser.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//			String tradeIdStr = request.getParameter("tradeId");

            int tradeId = Integer.parseInt(request.getParameter("tradeId"));
            System.out.println(tradeId);
            TradeRecord tradeRecordById = tradeRecordService.findTradeRecordById(tradeId);
            Integer goodsId = tradeRecordById.getGoodsId();
            com.shop.entity.Goods goodsById = goodsService.findGoodsById(goodsId);
            Integer shopId = goodsById.getShopId();
            Shop shopById = shopService.getShopById(shopId);
            Integer userId = shopById.getUserId();
            User userById = userService.getUserById(userId);
            userById.setShop(shopById);


//			Integer userId = complaintUser.getId();
//			com.shop.entity.User user = userService.getUserById(userId);
//			com.shop.entity.Shop shop = shopService.getShopByUserId(userId);
//			user.setShop(shop);
//			String hql = "from Complaint as c where c.tradeRecord.id="+tradeId;
            com.shop.entity.Complaint complaint = complaintService.findComplaint(tradeId);
            Integer id = complaint.getId();
            Integer adminReply = complaint.getAdminReply();
            if (adminReply != 1) {
                complaintService.updateAdminReplyById(id);
            }
            complaint.setUser(userById);
            request.setAttribute("complaint", complaint);

//			String hql_reply = "from ComplaintReply as c where c.complaint.id="+complaint.getId()+" and c.replyType=1 order by c.replyTime desc";
            List<com.shop.entity.ComplaintReply> complaintReplies = complaintReplyService.findComplaintReplyByPreRightId(complaint.getId(), 1);
            for (ComplaintReply complaintReply : complaintReplies) {
                Integer writerId = complaintReply.getWriterId();
                com.shop.entity.User writerUser = userService.getUserById(writerId);
                complaintReply.setWriter(writerUser);
            }

            request.setAttribute("complaintReply", complaintReplies);
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            return "system/weiquan/querycomplainresult/selectResult";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查看失败！");
            return "system/error";
        }
    }

    @RequestMapping("/complaint/selectSystemComplaint.do")
    public String selectComplaint1(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User complaintUser = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (complaintUser == null || complaintUser.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//			String tradeIdStr = request.getParameter("tradeId");

            int tradeId = Integer.parseInt(request.getParameter("tradeId"));
            System.out.println(tradeId);
            TradeRecord tradeRecordById = tradeRecordService.findTradeRecordById(tradeId);
            Integer goodsId = tradeRecordById.getGoodsId();
            com.shop.entity.Goods goodsById = goodsService.findGoodsById(goodsId);
            Integer shopId = goodsById.getShopId();
            Shop shopById = shopService.getShopById(shopId);
            Integer userId = shopById.getUserId();
            User userById = userService.getUserById(userId);
            userById.setShop(shopById);

            com.shop.entity.Complaint complaint = complaintService.findComplaint(tradeId);
            Integer id = complaint.getId();
            Integer adminReply = complaint.getAdminReply();
//			if (adminReply!=1){
//				complaintService.updateAdminReplyById(id);
//			}
            complaint.setUser(userById);
            request.setAttribute("complaint", complaint);

//			String hql_reply = "from ComplaintReply as c where c.complaint.id="+complaint.getId()+" and c.replyType=1 order by c.replyTime desc";
            List<com.shop.entity.ComplaintReply> complaintReplies = complaintReplyService.findComplaintReplyByPreRightId(complaint.getId(), 1);
            for (ComplaintReply complaintReply : complaintReplies) {
                Integer writerId = complaintReply.getWriterId();
                com.shop.entity.User writerUser = userService.getUserById(writerId);
                complaintReply.setWriter(writerUser);
            }

            request.setAttribute("complaintReply", complaintReplies);
            UUID uuid = UUID.randomUUID();
            String token = uuid.toString().replaceAll("-", "");
            // 访问页面时随机生成一个token保存在服务端session中
            request.getSession().setAttribute("TOKEN", token);
            System.out.println("+++");
            return "system/weiquan/querycomallplains/selectResult";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查看失败！");
            return "system/error";
        }
    }

    //根据顾客查询维权
    @RequestMapping("/complaint/searchAllComplaints.do")
    public String searchAllComplaints(HttpServletRequest request, HttpServletResponse response) {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            int complaintId = user.getId();
            int totalComplaint = complaintService.getTotal(complaintId);
//			String hql = "from Complaint as c where c.complaint.id="+complaintId+" and c.tag=1 order by c.complaintTime desc";
            this.page(request, totalComplaint, complaintId);
            return "system/weiquan/querycomplainresult/complaintResult";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "查询失败！");
            return "system/error";
        }

    }

    @RequestMapping("searchComplaintData.do")
    @ResponseBody
    public List<com.shop.entity.Complaint> searchComplaintAlertData(HttpServletRequest request, HttpServletResponse response) throws Exception {

        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
//			if(user == null || user.equals("")){
//				request.getSession().invalidate();
//				return "cjmqylogin/login";
//			}
            int userId = user.getId();
            System.out.println("+++" + userId + "xwdwdw");
            List<com.shop.entity.Complaint> list = complaintService.ComplaintByComplaintId(userId);


            return list;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }


    //删除维权
    @RequestMapping("/complaint/deleteComplaint.do")
    public String deleteComplaint(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (user == null || user.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
            Integer id = Integer.parseInt(request.getParameter("id"));

            complaintService.deleteComplaint(id);

            //更新投诉数
            ServletContext application = request.getSession().getServletContext();
//			String complaintHql = "from Complaint as c where c.complaint.id="+complaintUser.getId()+" and c.tag=1";
            Integer complaintCount = complaintService.getTotal(user.getId());
            Map<Integer, Integer> complaintMap = CountUtil.getComplaintMap();
            complaintMap.put(user.getId(), complaintCount);
            application.setAttribute("complaintCount", complaintMap);
            int totalComplaint = complaintService.getTotal(user.getId());
//			String hql = "from Complaint as c where c.complaint.id="+complaintId+" and c.tag=1 order by c.complaintTime desc";
            this.page(request, totalComplaint, user.getId());

            return "system/weiquan/querycomplainresult/complaintResult";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "删除失败！");
            return "system/error";
        }
    }

    //
    //查询所有维权（管理员）
    @RequestMapping("/complaint/searchSystemComplaints.do")
    public String searchSystemComplaints(HttpServletRequest request, HttpServletResponse response) {
        try {
            User admin = (User) request.getSession().getAttribute("user");
            if (admin == null || admin.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";
            }
//				String hql = "from Complaint as c where c.tag=1 order by c.complaintTime desc";
            int totalComplaint = complaintService.getTotalComplaint();
            this.page(request, totalComplaint, 0);
            return "system/weiquan/querycomallplains/systemQueryallComplains";
        } catch (Exception e) {
            request.setAttribute("errorInfo", "查询失败！");
            return "system/error";
        }

    }

//
//
}
