package com.shop.service;

import com.shop.entity.Shop;

public interface ShopInfoService {
    //
//	public Shop findBussIntroByUserId(int userId);
//
    public Shop modifyShopIntro(int userId, String shopInfoText);
}
