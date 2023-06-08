package com.shop.controller;

import com.shop.service.ComplaintReplyService;
import com.shop.service.ComplaintService;
import com.shop.utils.DateTime;
import com.shop.utils.TextFilterUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class ComplaintReply {
    @Resource
    private ComplaintReplyService complaintReplyService;
    @Resource
    private ComplaintService complaintService;

    //增加顾客投诉回复
    @RequestMapping("/complaint/addComplaintReply.do")
    public String addComplaintReply(HttpServletRequest request, HttpServletResponse response) {
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
//		/*防止重复提交*/
//		String token = request.getParameter("TOKEN");
//		String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//		request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//		if(token.equals(token2)&& token2!=null){
        try {
            com.shop.entity.User writerUser = (com.shop.entity.User) request.getSession().getAttribute("user");
            if (writerUser == null || writerUser.equals("")) {
                request.getSession().invalidate();
                return "cjmqylogin/login";

            }
//			ComplaintReplyForm complaintReplyFrom = (ComplaintReplyForm) form;
            Integer complaintId = Integer.parseInt(request.getParameter("complaintId"));
            String replyContent = request.getParameter("replyContent");
//			Integer complaintId = complaintReplyFrom.getComplaintId();
//			String replyContent = complaintReplyFrom.getReplyContent();
            //输入文本文字数目
            String wordNum = request.getParameter("word");
            //服务器验证
            if (complaintId == null || replyContent == null) {
                request.setAttribute("errorInfo", "非法操作！");
                return "system/error";
            } else {
                //禁掉js的情况
                if ("".equals(wordNum)) {
                    if (replyContent.length() <= 200) {
                        replyContent = TextFilterUtil.replaceCode(replyContent);
                    } else {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                } else {
                    if (Integer.parseInt(wordNum) <= 200) {
                        replyContent = TextFilterUtil.replaceIllegalCode(replyContent);
                    } else {
                        request.setAttribute("errorInfo", "非法操作！");
                        return "system/error";
                    }
                }

            }

            String replyTime = DateTime.getNow();
            com.shop.entity.ComplaintReply complaintReply = new com.shop.entity.ComplaintReply();
//			complaintReply.setComplaint(complaintService.findComplaintById(complaintId));
            complaintReply.setPreRightId(complaintId);
            complaintReply.setWriterId(writerUser.getId());
            complaintReply.setReplyContent(replyContent);
            complaintReply.setReplyTime(replyTime);
            complaintReply.setReplyType(1);
            complaintReply.setTag(1);
//			complaintReply.setWriter(writerUser);
            complaintReplyService.addComplaintReply(complaintReply);
            return "system/weiquan/querycomplainresult/compainReplyEnd";
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorInfo", "回复失败！");
            return "system/error";
        }
    }


    //管理员回复
    @RequestMapping("/complaint/addComplaintAdminReply.do")
    public String addComplaintAdminReply(HttpServletRequest request, HttpServletResponse response) {
        /*防止重复提交*/
        Object sessionTokenObj = request.getSession().getAttribute("TOKEN");
//		String paramToken = request.getParameter("TOKEN");
        request.getSession().removeAttribute("TOKEN");
        if (sessionTokenObj != null) {
            try {
                com.shop.entity.User writerUser = (com.shop.entity.User) request.getSession().getAttribute("user");
                if (writerUser == null || writerUser.equals("")) {
                    request.getSession().invalidate();
                    return "cjmqylogin/login";

                }
//			ComplaintReplyForm complaintReplyFrom = (ComplaintReplyForm) form;
                String complaintId = request.getParameter("complaintId");
                String replyContent = request.getParameter("replyContent");
//			Integer complaintId = complaintReplyFrom.getComplaintId();
//			String replyContent = complaintReplyFrom.getReplyContent();
                //输入文本文字数目
                String wordNum = request.getParameter("word");
                //服务器验证
                if (complaintId == null || replyContent == null) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";
                } else {
                    //禁掉js的情况
                    if ("".equals(wordNum)) {
                        if (replyContent.length() <= 200) {
                            replyContent = TextFilterUtil.replaceCode(replyContent);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    } else {
                        if (Integer.parseInt(wordNum) <= 200) {
                            replyContent = TextFilterUtil.replaceIllegalCode(replyContent);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    }

                }
                String replyTime = DateTime.getNow();
                com.shop.entity.ComplaintReply complaintReply = new com.shop.entity.ComplaintReply();
//			complaintReply.setComplaint(complaintService.findComplaintById(complaintId));
                complaintReply.setReplyContent(replyContent);
                complaintReply.setPreRightId(Integer.valueOf(complaintId));
                complaintReply.setReplyTime(replyTime);
                complaintReply.setReplyType(1);
                complaintReply.setTag(1);
//			complaintReply.setWriter(writerUser);
                complaintReply.setWriterId(writerUser.getId());
                complaintReplyService.addComplaintReply(complaintReply);
//			Complaint complaint = complaintService.findComplaintById(complaintId);
//			complaint.setAdminReply(2);
                complaintService.updateComplaintAdminReply(Integer.parseInt(complaintId));
                return "system/weiquan/querycomallplains/compainReplyEnd";
            } catch (Exception e) {
                System.out.println(e);
                request.setAttribute("errorInfo", "回复失败！");
                return "system/error";
            }
        } else {
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
        }

    }

    //	商家警告回复
    @RequestMapping("/complaint/addComplaintAlertReply.do")
    public String addComplaintAlertReply(HttpServletRequest request, HttpServletResponse response) {
        /*防止重复提交*/
//		String token = request.getParameter("TOKEN");
//		 String token2 = (String) request.getSession().getAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
//		 request.getSession().removeAttribute(org.apache.struts.Globals.TRANSACTION_TOKEN_KEY);
        /*防止重复提交*/
        Object sessionTokenObj = request.getSession().getAttribute("TOKEN");
//		String paramToken = request.getParameter("TOKEN");
        request.getSession().removeAttribute("TOKEN");

        if (sessionTokenObj != null) {
            try {
                com.shop.entity.User writerUser = (com.shop.entity.User) request.getSession().getAttribute("user");
                if (writerUser == null || writerUser.equals("")) {
                    request.getSession().invalidate();
                    return "cjmqylogin/login";
                }
//				ComplaintReplyForm complaintReplyFrom = (ComplaintReplyForm) form;
//				Integer complaintId = complaintReplyFrom.getComplaintId();
//				String replyContent = complaintReplyFrom.getReplyContent();
                String complaintId = request.getParameter("complaintId");
                System.out.println(complaintId);
                String replyContent = request.getParameter("replyContent");
                System.out.println(replyContent);
                //输入文本文字数目
                String wordNum = request.getParameter("word");
                //服务器验证
                if (complaintId == null || replyContent == null) {
                    request.setAttribute("errorInfo", "非法操作！");
                    return "system/error";
                } else {
                    //禁掉js的情况
                    if ("".equals(wordNum)) {
                        if (replyContent.length() <= 200) {
                            replyContent = TextFilterUtil.replaceCode(replyContent);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    } else {
                        if (Integer.parseInt(wordNum) <= 200) {
                            replyContent = TextFilterUtil.replaceIllegalCode(replyContent);
                        } else {
                            request.setAttribute("errorInfo", "非法操作！");
                            return "system/error";
                        }
                    }

                }

                String replyTime = DateTime.getNow();
                com.shop.entity.ComplaintReply complaintReply = new com.shop.entity.ComplaintReply();
//			complaintReply.setComplaint(complaintService.findComplaintById(complaintId));
                complaintReply.setReplyContent(replyContent);
                complaintReply.setPreRightId(Integer.parseInt(complaintId));
                complaintReply.setReplyTime(replyTime);
                complaintReply.setReplyType(2);
                complaintReply.setTag(1);
//				complaintReply.setWriter(writerUser);
                complaintReply.setWriterId(writerUser.getId());
                complaintReplyService.addComplaintReply(complaintReply);
                return "system/weiquan/querycomallplains/compainReplyEnd";
            } catch (Exception e) {
                System.out.println(e);
                request.setAttribute("errorInfo", "回复失败！");
                return "system/error";
            }
        } else {
            request.setAttribute("errorInfo", "不允许重复提交！");
            return "system/error";
        }

    }


}
