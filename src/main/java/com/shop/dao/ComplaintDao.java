package com.shop.dao;


import com.shop.entity.Complaint;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface ComplaintDao {

    public int getTotalSize(@Param("userId") Integer userId);

    public void saveComplaint(@Param("complaint") Complaint complaint);

    public Complaint findComplaint(@Param("tradeId") Integer tradeId);

    public Complaint getComplaintById(@Param("id") Integer id);

    public int getTotal(@Param("complaintId") Integer complaintId);

    public List<Complaint> findComplaintByComplaintId(@Param("complaintId") int complaintId, @Param("start") int start, @Param("max") int max);

    public List<Complaint> ComplaintByComplaintId(@Param("complaintId") int complaintId);

    public void deleteComplaint(@Param("id") Integer id);

    public void deleteComplaintByTradeId(@Param("tradeId") Integer tradeId);

    List<Complaint> findAllComplaint();

    int getTotalComplaint();

    void updateComplaintById(@Param("id") int id);

    void updateAdminReplyById(@Param("id") Integer id);

    void updateComplaintAdminReply(@Param("id") int id);
//	public List<Complaint> findComplaintByHql(String hql,int start,int max);
////	public int getTotal(String hql);

//	public void updateComplaint(Complaint complaint);

}
