package com.shop.service;


import com.shop.entity.TradeRecord;

import java.util.List;

public interface TradeRecordService {

    public int getTotalSize(Integer userId);

    public List<TradeRecord> findTradeRecordsByBuy(int userId, int start, int max);

    public List<TradeRecord> findTradeRecordsBySell(int userId, int start, int max);

    public TradeRecord findTradeRecordById(Integer id);

    public void modifyTradeRecordById(int tradeId);

    public List<TradeRecord> collectionTradeRecordsIsBuy(int userId, String goodsName, String startTradeTime, String endTradeTime, int beginIndex, int everyPage);

    public int collectionTradeRecordCountIsBuy(int userId, String goodsName, String startTradeTime, String endTradeTime);

    public List<TradeRecord> collectionTradeRecordsIsSole(int userId, String goodsName, String startTradeTime, String endTradeTime, int beginIndex, int everyPage);

    public int collectionTradeRecordCountIsSole(int userId, String goodsName, String startTradeTime, String endTradeTime);

    public int deleteTradeRecordById(Integer id);

    public void saveBuyTradeRecord(TradeRecord tradeRecord);

    public void saveSoleTradeRecord(TradeRecord tradeRecord);

    public int getTotalSizeIsSole(int userId);


//    public void modifyTradeRecord(TradeRecord tradeRecord);


//	public List<TradeRecord> findTradeRecords(String hql,int start,int max);
//	public void deleteTradeRecord(Integer id);

//	public void updateTradeRecordByHql(String hql);
}
