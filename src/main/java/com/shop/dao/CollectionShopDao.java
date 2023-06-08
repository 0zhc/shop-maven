package com.shop.dao;

import com.shop.entity.CollectionShop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CollectionShopDao {

    public int collectionShopCountByUserId(@Param("userId") int userId);

    //
    //后台收藏管理点击“店铺”查看收藏的所有店铺
    public List<CollectionShop> collectionShopFindByUserId(@Param("userId") int userId, @Param("begin") int begin, @Param("RecordCount") int recordCount);

    //后台收藏管理查看店铺模块，根据条件查询共有多少条符合条件的记录
    public int collectionShopCount(@Param("userId") int userId, @Param("shopName") String shopName, @Param("datetime1") String datetime1, @Param("datetime2") String datetime2);


    //后台收藏管理查看店铺模块，按条件查询符合条件的店铺
    public List<CollectionShop> collectionShopSelectAllShop(@Param("userId") int userId, @Param("shopName") String shopName, @Param("datetime1") String datetime1, @Param("datetime2") String datetime2, @Param("begin") int begin, @Param("RecordCount") int RecordCount);


    //后台收藏管理查看店铺模块，删除一个收藏的店铺（改状态）
    public void collectionShopDeleteByShopId(@Param("shopId") int shopId, @Param("userId") int userId);

    public CollectionShop sleectCollectionShop(@Param("shopId") int shopId, @Param("userId") int userId);

    public void save(@Param("collectionShop") CollectionShop collectionShop);
//
//	//后台收藏管理查看店铺模块，全选删除收藏的店铺（改状态）
//	public void collectionShopDeleteAllShop(String[] shopAllId,int userId);


//
//	//用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
//	public String userCollectionShop(int shopId,int userId);
}
