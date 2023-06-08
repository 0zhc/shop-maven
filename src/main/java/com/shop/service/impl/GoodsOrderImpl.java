package com.shop.service.impl;

import com.shop.dao.GoodsOrderDao;
import com.shop.entity.GoodsOrder;
import com.shop.service.GoodsOrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class GoodsOrderImpl implements GoodsOrderService {
    @Resource
    GoodsOrderDao goodsOrderDao;

    @Override
    public GoodsOrder getGoodsOrder(int goodsOrderId) {
        return goodsOrderDao.getGoodsOrder(goodsOrderId);
    }
}
