package com.shop.service;

import com.shop.entity.ComplaintReply;

import java.util.List;

public interface ComplaintReplyService {

    public void addComplaintReply(ComplaintReply complaintReply);

    public List<ComplaintReply> findComplaintReplyByPreRightId(Integer PreRightId, Integer replyType);
}
