package com.shop.dao;

import org.apache.ibatis.annotations.Param;

public interface ShopInfoDao {

    //	public Shop findBussIntroByUserId(int userId);
//
    public void modifyShopIntro(@Param("userId") int userId, @Param("shopInfoText") String shopInfoText);

}
