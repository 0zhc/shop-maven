package com.shop.service.impl;

import com.shop.dao.ComplaintReplyDao;
import com.shop.entity.ComplaintReply;
import com.shop.service.ComplaintReplyService;
import com.shop.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ComplaintReplyServiceImpl implements ComplaintReplyService {
    @Resource
    private ComplaintReplyDao complaintReplyDao;
    @Resource
    private UserService userService;


    public List<ComplaintReply> findComplaintReplyByPreRightId(Integer PreRightId, Integer replyType) {
        return complaintReplyDao.findComplaintReplyByPreRightId(PreRightId, replyType);
    }

    public void addComplaintReply(ComplaintReply complaintReply) {
        complaintReplyDao.addComplaintReply(complaintReply);

    }

//
//
//	public void setComplaintReplyDao(ComplaintReplyDao complaintReplyDao) {
//		this.complaintReplyDao = complaintReplyDao;
//	}
//
//

//
//


}
