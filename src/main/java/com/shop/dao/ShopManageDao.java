package com.shop.dao;

import com.shop.entity.Shop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopManageDao {

    public List<Shop> findAllshopManage(@Param("begin") int begin, @Param("RecordCount") int RecordCount);

    public void shopManageDeleteByShopId(@Param("shopId") int shopId);

    //
//	public void shopManagerDeleteAllShop(String[] shopAllId);
//
    public List<Shop> shopManagerSelectAllShop(@Param("shopName") String shopName, @Param("shopUser") String shopUser, @Param("datetime1") String datetime1, @Param("datetime2") String datetime2, @Param("begin") int begin, @Param("RecordCount") int RecordCount);

    //
    public int shopManagetCount(@Param("shopName") String shopName, @Param("shopUser") String shopUser, @Param("datetime1") String datetime1, @Param("datetime2") String datetime2);

    public void shopManageDeleteById(@Param("id") int id);
}
