package com.shop.dao;


import com.shop.entity.TradeRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TradeRecordDao {
    public int getTotal(@Param("userId") Integer userId);


    public List<TradeRecord> findTradeRecordByBuy(@Param("userId") int userId, @Param("start") int start, @Param("max") int max);

    public List<TradeRecord> findTradeRecordBySell(@Param("userId") int userId, @Param("start") int start, @Param("max") int max);

    public TradeRecord getTradRecordById(@Param("id") Integer id);

    public int deleteTradeRecordById(@Param("id") Integer id);

    public void modifyTradeRecordById(@Param("tradeId") int tradeId);

    public int collectionTradeRecordCountIsBuy(@Param("userId") int userId, @Param("goodsName") String goodsName, @Param("startTradeTime") String startTradeTime, @Param("endTradeTime") String endTradeTime);

    public List<TradeRecord> collectionTradeRecordsIsBuy(@Param("userId") int userId, @Param("goodsName") String goodsName, @Param("startTradeTime") String startTradeTime, @Param("endTradeTime") String endTradeTime, @Param("beginIndex") int beginIndex, @Param("everyPage") int everyPage);

    public int collectionTradeRecordCountIsSole(@Param("userId") int userId, @Param("goodsName") String goodsName, @Param("startTradeTime") String startTradeTime, @Param("endTradeTime") String endTradeTime);

    public List<TradeRecord> collectionTradeRecordsIsSole(@Param("userId") int userId, @Param("goodsName") String goodsName, @Param("startTradeTime") String startTradeTime, @Param("endTradeTime") String endTradeTime, @Param("beginIndex") int beginIndex, @Param("everyPage") int everyPage);

    public int getTotalSizeIsSole(@Param("userId") int userId);

    public void saveBuyTradeRecord(@Param("buyTradeRecord") TradeRecord buyTradeRecord);

    public void saveSoleTradeRecord(@Param("soleTradeRecord") TradeRecord soleTradeRecord);


//	public void saveTradeRecord(TradeRecord tradeRecord);
//	public void updateTradeRecord(TradeRecord tradeRecord);
//	public void updateTradeRecordByHql(String hql);
//	public void deleteTradeRecord(Integer id);

//	public List<TradeRecord> findTradeRecordByHql(String hql,int start,int max);

}
