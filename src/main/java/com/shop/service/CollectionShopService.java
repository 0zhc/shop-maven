package com.shop.service;

import com.shop.entity.CollectionShop;

import java.util.List;

public interface CollectionShopService {
    //根据userId条件查询共有多少条符合条件的记录
    public int collectionShopCountByUserId(int userId);

    //后台收藏管理点击“店铺”查看收藏的所有店铺
    public List<CollectionShop> collectionShopFindByUserId(int userId, int begin, int RecordCount);

    //台收藏管理查看店铺模块，根据条件查询共有多少条符合条件的记录
    public int collectionShopCount(int userId, String shopName, String datetime1, String datetime2);


    //后台收藏管理查看店铺模块，按条件查询符合条件的店铺
    public List<CollectionShop> collectionShopSelectAllShop(int userId, String shopName, String datetime1, String datetime2, int begin, int RecordCount);


    //后台收藏管理查看店铺模块，删除一个收藏的店铺（改状态）
    public void collectionShopDeleteByShopId(int shopId, int userId);

//	//后台收藏管理查看店铺模块，全选删除收藏的店铺（改状态）
//	public void collectionShopDeleteAllShop(String[] shopAllId,int userId);
//


    //用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
    public String userCollectionShop(int shopId, int userId);
}
