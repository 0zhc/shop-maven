package com.shop.service;

import com.shop.entity.ShopAnnouce;

import java.util.List;

public interface ShopAnnouceService {

    public List<ShopAnnouce> addShopAnnouce(int shopId, String newOne, String newTwo,
                                            String newThree, String newFour);

    //
//	public List<ShopAnnouce> findNewByUserId(int userId);
    public List<ShopAnnouce> findNewByShopId(int shopId);

    //
    public List<ShopAnnouce> modifyShopAnnouce(int shopId, String newOne, String newTwo, String newThree, String newFour);
}
