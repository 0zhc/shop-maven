package com.shop.service.impl;

import com.shop.dao.StationAnnouceDao;
import com.shop.entity.StationAnnouce;
import com.shop.service.StationAnnouceService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class StationAnnouceServiceImpl implements StationAnnouceService {
    @Resource
    private StationAnnouceDao stationAnnouceDao;


    public void saveStationAnnounce(StationAnnouce stationAnnouce) {
        stationAnnouceDao.saveStationAnnounce(stationAnnouce);

    }

    @Override
    public int getTotalSize() {
        return stationAnnouceDao.getTotal();
    }

    @Override
    public int getTotalStationAnnouce() {
        return stationAnnouceDao.getTotalStationAnnouce();
    }

    @Override
    public List<StationAnnouce> findStationAnnouces(int beginIndex, int max) {
        return stationAnnouceDao.findStationAnnouces(beginIndex, max);
    }

    //
//	public List<StationAnnouce> findStationAnnouces(String hql, int start, int max) {
//		List<StationAnnouce> stationAnnouces=null;
//		Session session=HibernateUtil.getThreadLocalSession();
//		Transaction transaction=session.beginTransaction();
//		stationAnnouces=stationAnnouceDao.findStationAnnouceByHql(hql, start, max);
//		transaction.commit();
//		HibernateUtil.closeSession();
//		return stationAnnouces;
//	}
//
//
//	public int getTotalSize(String hql) {
//		int count=0;
//		Session session=HibernateUtil.getThreadLocalSession();
//		Transaction transaction=session.beginTransaction();
//		String hqlCount="select count(*) ".concat(hql);
//		count=stationAnnouceDao.getTotal( hqlCount );
//		transaction.commit();
//		HibernateUtil.closeSession();
//		return count;
//	}
//
//
    public void updateStationAnnouce(StationAnnouce stationAnnouce, Integer id) {
        stationAnnouceDao.updateStationAnnouce(stationAnnouce, id);

    }


    public StationAnnouce getStationAnnouceById(Integer id) {
        return stationAnnouceDao.getStationAnnouceById(id);
    }


    public void deleteStationAnnouce(Integer id) {

        stationAnnouceDao.deleteStationAnnouce(id);

    }

    @Override
    public int getTotalStationAnnouceByTime(String startTime, String endTime) {
        return stationAnnouceDao.getTotalStationAnnouceByTime(startTime, endTime);
    }

    @Override
    public List<StationAnnouce> findStationAnnoucesByTime(String startTime, String endTime, int beginIndex, int max) {
        return stationAnnouceDao.findStationAnnoucesByTime(startTime, endTime, beginIndex, max);
    }

    @Override
    public List<StationAnnouce> findStationAnnoucesByState(String startTime, String endTime, int beginIndex, int max) {
        return stationAnnouceDao.findStationAnnoucesByState(startTime, endTime, beginIndex, max);
    }

    @Override
    public int getTotalStationAnnouceByTimeAndState(String startTime, String endTime) {
        return stationAnnouceDao.getTotalStationAnnouceByTimeAndState(startTime, endTime);
    }

}
