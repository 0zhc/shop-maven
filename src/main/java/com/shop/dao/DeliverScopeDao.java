package com.shop.dao;

import org.apache.ibatis.annotations.Param;

public interface DeliverScopeDao {

    //	public Shop findScopeByUserId(int userId);
//
    public void modifyShopScope(@Param("userId") int userId, @Param("deliverScope") String deliverScope);

}
