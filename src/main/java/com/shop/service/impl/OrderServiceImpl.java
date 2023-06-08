package com.shop.service.impl;

import com.shop.dao.OrderDao;
import com.shop.entity.GoodsOrder;
import com.shop.entity.ReceiveAddress;
import com.shop.service.OrderService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {
    @Resource
    private OrderDao orderDao;

    @Override
    public int getIsSoleTotalByUserId(Integer userId) {
        return orderDao.getIsSoleTotalByUserId(userId);
    }

    public List<GoodsOrder> findIsSoleGoodsOrdersByUserId(int userId, int start, int max) {
        return orderDao.findIsSoleGoodsOrdersByUserId(userId, start, max);
    }

    public int getIsBuyTotalByUserId(Integer userId) {
        return orderDao.getIsBuyTotalByUserId(userId);
    }

    public List<GoodsOrder> findIsBuyGoodsOrdersByUserId(int userId, int start, int max) {
        return orderDao.findIsBuyGoodsOrdersByUserId(userId, start, max);
    }


    public void saveOrder(GoodsOrder goodsOrder) {
        orderDao.saveOrder(goodsOrder);
    }


    //	public GoodsOrder findGoodsOrder(GoodsOrder goodsOrder) {
//		return orderDao.findGoodsOrder(goodsOrder);
//	}
//
//
    public void saveReceiveAddress(ReceiveAddress receiveAddress) {
        orderDao.saveReceiveAddress(receiveAddress);
    }

    @Override
    public int getTotalSize(Integer userId, Integer state) {
        return orderDao.getTotal(userId, state);
    }
//
//	state

    //
//
//	public int getTotalSize(String hql) {
//		int count=0;
//		Session session=HibernateUtil.getThreadLocalSession();
//		Transaction transaction=session.beginTransaction();
//		String hqlCount="select count(*) ".concat(hql);
//		count=orderDao.getTotal( hqlCount );
//		transaction.commit();
//		HibernateUtil.closeSession();
//		return count;
//	}
//
//
    public void deleteGoodsOrder(Integer id) {
        orderDao.deleteGoodsOrder(id);
    }

    //
    public void updateGoodsOrderById(Integer goodsOrderId, int state) {
        orderDao.updateGoodsOrderById(goodsOrderId, state);
    }

    public GoodsOrder getGoodsOrderById(Integer id) {
        return orderDao.getGoodsOrderById(id);
    }

    //
    public ReceiveAddress getReceiveAddressByGoodsOrderId(int orderId) {
        return orderDao.getReceiveAddressByGoodsOrderId(orderId);
    }

    @Override
    public int findIsSoleGoodsOrdersCountByCondition(int userId, String orderNum, int state, String startTime, String endTime) {
        return orderDao.findIsSoleGoodsOrdersCountByCondition(userId, orderNum, state, startTime, endTime);
    }

    @Override
    public List<GoodsOrder> findIsSoleGoodsOrdersByCondition(int userId, String orderNum, int state, String startTime, String endTime, int beginIndex, int max) {
        return orderDao.findIsSoleGoodsOrdersByCondition(userId, orderNum, state, startTime, endTime, beginIndex, max);
    }

    @Override
    public int findIsBuyGoodsOrdersCountByCondition(int userId, String orderNum, int state, String startTime, String endTime) {
        return orderDao.findIsBuyGoodsOrdersCountByCondition(userId, orderNum, state, startTime, endTime);
    }

    @Override
    public List<GoodsOrder> findIsBuyGoodsOrdersByCondition(int userId, String orderNum, int state, String startTime, String endTime, int beginIndex, int max) {
        return orderDao.findIsBuyGoodsOrdersByCondition(userId, orderNum, state, startTime, endTime, beginIndex, max);
    }

    @Override
    public int getTotalUNSHIPPED(Integer userId, int state) {
        return orderDao.getTotalUNSHIPPED(userId, state);
    }

}
