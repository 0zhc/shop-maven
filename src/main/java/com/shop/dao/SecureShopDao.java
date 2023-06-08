package com.shop.dao;

import org.apache.ibatis.annotations.Param;

public interface SecureShopDao {

    //	public Shop findSecureByUserId(int userId);
//
    public void modifySecure(@Param("userId") int userId, @Param("secureShop") String secureShop);
}
