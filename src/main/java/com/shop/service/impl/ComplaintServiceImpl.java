package com.shop.service.impl;

import com.shop.dao.ComplaintDao;
import com.shop.entity.Complaint;
import com.shop.service.ComplaintService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class ComplaintServiceImpl implements ComplaintService {
    @Resource
    private ComplaintDao complaintDao;

    //
    public void saveComplaint(Complaint complaint) {
        complaintDao.saveComplaint(complaint);

    }


    @Override
    public Complaint findComplaint(Integer tradeId) {
        return complaintDao.findComplaint(tradeId);
    }

    @Override
    public int getTotalSize(Integer userId) {
        return complaintDao.getTotalSize(userId);
    }

    @Override
    public int getTotal(Integer complaintId) {
        return complaintDao.getTotal(complaintId);
    }

    @Override
    public Complaint findComplaintById(Integer id) {
        return complaintDao.getComplaintById(id);
    }

    @Override
    public List<Complaint> findComplaintByComplaintId(int complaintId, int start, int max) {
        return complaintDao.findComplaintByComplaintId(complaintId, start, max);
    }

    @Override
    public List<Complaint> ComplaintByComplaintId(int complaintId) {
        return complaintDao.ComplaintByComplaintId(complaintId);
    }

//	public List<Complaint> findComplaintByHql(String hql, int start, int max) {
//		List<Complaint> complaints=null;
//		Session session=HibernateUtil.getThreadLocalSession();
//		Transaction transaction=session.beginTransaction();
//		complaints=complaintDao.findComplaintByHql(hql, start, max);
//		transaction.commit();
//		HibernateUtil.closeSession();
//		return complaints;
//	}
//
//	public int getTotalSize(String hql) {
//		int count=0;
//		Session session=HibernateUtil.getThreadLocalSession();
//		Transaction transaction=session.beginTransaction();
//		String hqlCount="select count(*) ".concat(hql);
//		count=complaintDao.getTotal( hqlCount );
//		transaction.commit();
//		HibernateUtil.closeSession();
//		return count;
//	}

    public void deleteComplaint(Integer id) {
        complaintDao.deleteComplaint(id);
    }

    @Override
    public void deleteComplaintByTradeId(Integer tradeId) {
        complaintDao.deleteComplaintByTradeId(tradeId);
    }

    @Override
    public List<Complaint> findAllComplaint() {
        return complaintDao.findAllComplaint();
    }

    @Override
    public int getTotalComplaint() {
        return complaintDao.getTotalComplaint();
    }

    @Override
    public void updateComplaintById(int id) {
        complaintDao.updateComplaintById(id);
    }

    @Override
    public void updateAdminReplyById(Integer id) {
        complaintDao.updateAdminReplyById(id);
    }

    @Override
    public void updateComplaintAdminReply(int id) {
        complaintDao.updateComplaintAdminReply(id);
    }


//

//
//	public void updateComplaint(Complaint complaint) {
//		complaintDao.updateComplaint(complaint);
//
//	}

}
