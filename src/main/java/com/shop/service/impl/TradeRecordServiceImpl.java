package com.shop.service.impl;


import com.shop.dao.TradeRecordDao;
import com.shop.entity.TradeRecord;
import com.shop.service.TradeRecordService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Transactional
@Service
public class TradeRecordServiceImpl implements TradeRecordService {
    @Resource
    private TradeRecordDao tradeRecordDao;

    //获取总记录数
    public int getTotalSize(Integer userId) {
        int count = 0;
//        Session session=HibernateUtil.getThreadLocalSession();
//        Transaction transaction=session.beginTransaction();
//        String hqlCount="select count(*) ".concat(hql);
        count = tradeRecordDao.getTotal(userId);
//        transaction.commit();
//        HibernateUtil.closeSession();
        return count;
    }

    //根据hql分页查询交易记录
    public List<TradeRecord> findTradeRecordsByBuy(int userId, int start, int max) {
        List<TradeRecord> tradeRecords;
//        Session session=HibernateUtil.getThreadLocalSession();
//        Transaction transaction=session.beginTransaction();
        tradeRecords = tradeRecordDao.findTradeRecordByBuy(userId, start, max);
//        transaction.commit();
//        HibernateUtil.closeSession();
        return tradeRecords;
    }

    public List<TradeRecord> findTradeRecordsBySell(int userId, int start, int max) {
        List<TradeRecord> tradeRecords = null;
//        Session session=HibernateUtil.getThreadLocalSession();
//        Transaction transaction=session.beginTransaction();
        tradeRecords = tradeRecordDao.findTradeRecordBySell(userId, start, max);
//        transaction.commit();
//        HibernateUtil.closeSession();
        return tradeRecords;
    }

    //根据ID获取交易记录
    public TradeRecord findTradeRecordById(Integer id) {
        return tradeRecordDao.getTradRecordById(id);
    }

    public int deleteTradeRecordById(Integer id) {
        return tradeRecordDao.deleteTradeRecordById(id);
    }

    @Override
    public int getTotalSizeIsSole(int userId) {
        return tradeRecordDao.getTotalSizeIsSole(userId);
    }


    @Override
    public void modifyTradeRecordById(int tradeId) {
        tradeRecordDao.modifyTradeRecordById(tradeId);
    }

    @Override
    public List<TradeRecord> collectionTradeRecordsIsBuy(int userId, String goodsName, String startTradeTime, String endTradeTime, int beginIndex, int everyPage) {
        return tradeRecordDao.collectionTradeRecordsIsBuy(userId, goodsName, startTradeTime, endTradeTime, beginIndex, everyPage);
    }

    @Override
    public int collectionTradeRecordCountIsBuy(int userId, String goodsName, String startTradeTime, String endTradeTime) {
        return tradeRecordDao.collectionTradeRecordCountIsBuy(userId, goodsName, startTradeTime, endTradeTime);
    }

    @Override
    public List<TradeRecord> collectionTradeRecordsIsSole(int userId, String goodsName, String startTradeTime, String endTradeTime, int beginIndex, int everyPage) {
        return tradeRecordDao.collectionTradeRecordsIsSole(userId, goodsName, startTradeTime, endTradeTime, beginIndex, everyPage);
    }

    @Override
    public int collectionTradeRecordCountIsSole(int userId, String goodsName, String startTradeTime, String endTradeTime) {
        return tradeRecordDao.collectionTradeRecordCountIsSole(userId, goodsName, startTradeTime, endTradeTime);
    }

    @Override
    public void saveBuyTradeRecord(TradeRecord buyTradeRecord) {
        tradeRecordDao.saveBuyTradeRecord(buyTradeRecord);

    }

    @Override
    public void saveSoleTradeRecord(TradeRecord soleTradeRecord) {
        tradeRecordDao.saveSoleTradeRecord(soleTradeRecord);

    }

//

//
//	public void setTradeRecordDao(TradeRecordDao tradeRecordDao) {
//		this.tradeRecordDao = tradeRecordDao;
//	}
//

//

//
//	//删除交易记录
//	public void deleteTradeRecord(Integer id) {
//		TradeRecord tradeRecord = tradeRecordDao.getTradRecordById(id);
//		tradeRecord.setTag(2);
//		tradeRecordDao.updateTradeRecord(tradeRecord);
//
//	}
//

//
//	//修改交易记录
//	public void modifyTradeRecord(TradeRecord tradeRecord) {
//		tradeRecordDao.updateTradeRecord(tradeRecord);
//
//	}
//
//	public void updateTradeRecordByHql(String hql) {
//		tradeRecordDao.updateTradeRecordByHql(hql);
//
//	}
//


}
