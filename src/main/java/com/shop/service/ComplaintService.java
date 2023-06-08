package com.shop.service;

import com.shop.entity.Complaint;

import java.util.List;

public interface ComplaintService {

    public int getTotalSize(Integer userId);

    public int getTotal(Integer complaintId);

    public void saveComplaint(Complaint complaint);

    public Complaint findComplaint(Integer tradeId);

    public Complaint findComplaintById(Integer id);

    public List<Complaint> findComplaintByComplaintId(int complaintId, int start, int max);

    public List<Complaint> ComplaintByComplaintId(int complaintId);

    public void deleteComplaint(Integer id);

    public void deleteComplaintByTradeId(Integer id);

    List<Complaint> findAllComplaint();

    int getTotalComplaint();

    void updateComplaintById(int id);

    void updateAdminReplyById(Integer id);

    void updateComplaintAdminReply(int id);

//	public void updateComplaint(Complaint complaint);

}
