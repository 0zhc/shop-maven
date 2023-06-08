package com.shop.service;


import com.shop.entity.ComplaintAlert;

import java.util.List;

public interface ComplaintAlertService {

    //	public void addComplaintAlert(ComplaintAlert complaintAlert);
    public int getTotalSize(Integer userId);

    public List<ComplaintAlert> findComplaintAlertByUserId(int userId, int start, int max);

    public List<ComplaintAlert> findComplaintAlertById(int userId);

    public void deleteComplaintAlertById(Integer id);

    public ComplaintAlert getComplaintAlertById(Integer id);

    void addComplaintAlert(ComplaintAlert complaintAlert);

    int totalComplaintAlert();

    List<ComplaintAlert> findComplaintAlert(int beginIndex, int max);
}
