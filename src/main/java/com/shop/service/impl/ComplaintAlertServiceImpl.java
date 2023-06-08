package com.shop.service.impl;


import com.shop.dao.ComplaintAlertDao;
import com.shop.entity.ComplaintAlert;
import com.shop.service.ComplaintAlertService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional

public class ComplaintAlertServiceImpl implements ComplaintAlertService {
    @Resource
    private ComplaintAlertDao complaintAlertDao;

    public ComplaintAlert getComplaintAlertById(Integer id) {
        return complaintAlertDao.getComplaintAlertById(id);
    }

    @Override
    public void addComplaintAlert(ComplaintAlert complaintAlert) {
        complaintAlertDao.addComplaintAlert(complaintAlert);
    }

    @Override
    public int totalComplaintAlert() {
        return complaintAlertDao.totalComplaintAlert();
    }

    @Override
    public List<ComplaintAlert> findComplaintAlert(int beginIndex, int max) {
        return complaintAlertDao.findComplaintAlert(beginIndex, max);
    }
//
//	public void addComplaintAlert(ComplaintAlert complaintAlert) {
//		complaintAlertDao.addComplaintAler(complaintAlert);
//
//	}

    @Override
    public int getTotalSize(Integer userId) {
        return complaintAlertDao.getTotal(userId);
    }

    //
    public List<ComplaintAlert> findComplaintAlertByUserId(int userId, int start, int max) {
        return complaintAlertDao.findComplaintAlertByUserId(userId, start, max);
    }

    public List<ComplaintAlert> findComplaintAlertById(int userId) {
        return complaintAlertDao.findComplaintAlertById(userId);
    }

    //
//
//	public int getTotalSize(String hql) {
//		int count=0;
//		Session session=HibernateUtil.getThreadLocalSession();
//		Transaction transaction=session.beginTransaction();
//		String hqlCount="select count(*) ".concat(hql);
//		count=complaintAlertDao.getTotal( hqlCount );
//		transaction.commit();
//		HibernateUtil.closeSession();
//		return count;
//	}
//
//
    public void deleteComplaintAlertById(Integer id) {
        complaintAlertDao.deleteComplaintAlertById(id);
    }
//
//

//
//

}
