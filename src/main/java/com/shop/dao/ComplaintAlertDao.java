package com.shop.dao;

import com.shop.entity.ComplaintAlert;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ComplaintAlertDao {
    //	public void addComplaintAler(ComplaintAlert complaintAlert);
//	public List<ComplaintAlert> findComplaintAlerByHql(String hql,int start,int max);
    public int getTotal(@Param("userId") Integer userId);

    public List<ComplaintAlert> findComplaintAlertByUserId(@Param("userId") int userId, @Param("start") int start, @Param("max") int max);

    public List<ComplaintAlert> findComplaintAlertById(@Param("userId") int userId);

    //	public void updateComplaintAler(ComplaintAlert complaintAlert);
    public ComplaintAlert getComplaintAlertById(@Param("id") Integer id);

    public void deleteComplaintAlertById(@Param("id") Integer id);

    void addComplaintAlert(@Param("complaintAlert") ComplaintAlert complaintAlert);

    int totalComplaintAlert();

    List<ComplaintAlert> findComplaintAlert(@Param("beginIndex") int beginIndex, @Param("max") int max);
}
