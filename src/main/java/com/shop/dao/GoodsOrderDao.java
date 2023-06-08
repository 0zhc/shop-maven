package com.shop.dao;

import com.shop.entity.GoodsOrder;
import org.apache.ibatis.annotations.Param;

public interface GoodsOrderDao {

    GoodsOrder getGoodsOrder(@Param("goodsOrderId") int goodsOrderId);
}
