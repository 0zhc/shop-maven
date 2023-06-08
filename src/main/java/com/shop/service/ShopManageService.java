package com.shop.service;

import com.shop.entity.Shop;

import java.util.List;

public interface ShopManageService {

    public List<Shop> findAllshopManage(int begin, int RecordCount);

    //
    public void shopManageDeleteByShopId(int shopId);

    //
//	public void shopManagerDeleteAllShop(String[] shopAllId);
//
    public List<Shop> shopManagerSelectAllShop(String shopName, String shopUser, String datetime1, String datetime2, int begin, int RecordCount);

    //
    public int shopManagetCount(String shopName, String shopUser, String datetime1, String datetime2);

    public void shopManageDeleteById(int id);
}
