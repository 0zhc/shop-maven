package com.shop.dao;

import com.shop.entity.ShopAnnouce;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopAnnouceDao {

    //	public List<ShopAnnouce> addShopAnnouce(int userId, String newOne, String newTwo,
//			String newThree, String newFour);
//
//	public List<ShopAnnouce> findNewByUserId(int userId);
    public List<ShopAnnouce> findNewByShopId(@Param("shopId") int shopId);

    void addShopAnnouce(@Param("shopId") int shopId, @Param("shopAnnouce") ShopAnnouce shopAnnouce1);

    List<ShopAnnouce> getShopAnnouce(@Param("shopId") int shopId);

    //
    public void modifyShopAnnouce(@Param("id") int id, @Param("content") String content);
//
}
