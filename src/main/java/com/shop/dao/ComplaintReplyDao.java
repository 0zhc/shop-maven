package com.shop.dao;


import com.shop.entity.ComplaintReply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ComplaintReplyDao {
    public void addComplaintReply(@Param("complaintReply") ComplaintReply complaintReply);

    public List<ComplaintReply> findComplaintReplyByPreRightId(@Param("PreRightId") Integer PreRightId, @Param("replyTye") Integer replyType);

}
