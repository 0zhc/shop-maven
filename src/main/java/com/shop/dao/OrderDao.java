package com.shop.dao;

import com.shop.entity.GoodsOrder;
import com.shop.entity.ReceiveAddress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderDao {
    public int getTotal(@Param("userId") Integer userId, @Param("state") Integer state);

    public List<GoodsOrder> findIsSoleGoodsOrdersByUserId(@Param("userId") Integer userId, @Param("start") int start, @Param("max") int max);

    public int getIsSoleTotalByUserId(@Param("userId") Integer userId);

    public List<GoodsOrder> findIsBuyGoodsOrdersByUserId(@Param("userId") Integer userId, @Param("start") int start, @Param("max") int max);

    public int getIsBuyTotalByUserId(@Param("userId") Integer userId);

    public void saveOrder(@Param("goodsOrder") GoodsOrder goodsOrder);


    //	public GoodsOrder findGoodsOrder(GoodsOrder goodsOrder);
    public void saveReceiveAddress(@Param("receiveAddress") ReceiveAddress receiveAddress);


    public void updateGoodsOrderById(@Param("goodsOrderId") Integer goodsOrderId, @Param("state") Integer state);

    public GoodsOrder getGoodsOrderById(@Param("id") Integer id);

    public ReceiveAddress getReceiveAddressByGoodsOrderId(@Param("orderId") Integer orderId);

    public int findIsSoleGoodsOrdersCountByCondition(@Param("userId") int userId, @Param("orderNum") String orderNum, @Param("state") int state, @Param("startTime") String startTime, @Param("endTime") String endTime);

    public List<GoodsOrder> findIsSoleGoodsOrdersByCondition(@Param("userId") int userId, @Param("orderNum") String orderNum, @Param("state") int state, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("beginIndex") int beginIndex, @Param("max") int max);

    public int findIsBuyGoodsOrdersCountByCondition(@Param("userId") int userId, @Param("orderNum") String orderNum, @Param("state") int state, @Param("startTime") String startTime, @Param("endTime") String endTime);

    public List<GoodsOrder> findIsBuyGoodsOrdersByCondition(@Param("userId") int userId, @Param("orderNum") String orderNum, @Param("state") int state, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("beginIndex") int beginIndex, @Param("max") int max);

    public int getTotalUNSHIPPED(@Param("userId") Integer userId, @Param("state") int state);

    public void deleteGoodsOrder(@Param("id") Integer id);
}
