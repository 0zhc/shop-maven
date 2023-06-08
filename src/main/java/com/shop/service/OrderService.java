package com.shop.service;

import com.shop.entity.GoodsOrder;
import com.shop.entity.ReceiveAddress;

import java.util.List;

public interface OrderService {
    public void saveOrder(GoodsOrder goodsOrder);

    //	public GoodsOrder findGoodsOrder(GoodsOrder goodsOrder);
    public void saveReceiveAddress(ReceiveAddress receiveAddress);

    public int getTotalSize(Integer userId, Integer state);

    public int getIsBuyTotalByUserId(Integer userId);

    public int getIsSoleTotalByUserId(Integer userId);

    public List<GoodsOrder> findIsBuyGoodsOrdersByUserId(int userId, int start, int max);

    public List<GoodsOrder> findIsSoleGoodsOrdersByUserId(int userId, int start, int max);

    public GoodsOrder getGoodsOrderById(Integer id);

    public void updateGoodsOrderById(Integer goodsOrderId, int state);

    public void deleteGoodsOrder(Integer id);

    public ReceiveAddress getReceiveAddressByGoodsOrderId(int orderId);


    public int findIsSoleGoodsOrdersCountByCondition(int userId, String orderNum, int state, String startTime, String endTime);

    public List<GoodsOrder> findIsSoleGoodsOrdersByCondition(int userId, String orderNum, int state, String startTime, String endTime, int beginIndex, int max);

    public int findIsBuyGoodsOrdersCountByCondition(int userId, String orderNum, int state, String startTime, String endTime);

    public List<GoodsOrder> findIsBuyGoodsOrdersByCondition(int userId, String orderNum, int state, String startTime, String endTime, int beginIndex, int max);

    public int getTotalUNSHIPPED(Integer userId, int state);
}
