package com.shop.service;


import com.shop.entity.CollectionGoods;

import java.util.List;

public interface CollectionProductService {


    //台收藏管理查看商品模块，根据条件查询共有多少条符合条件的记录
    public int collectionGoodsCountByUserId(int userId);

    //后台收藏管理点击“商品”查看收藏的所有商品
    public List<CollectionGoods> collectionProductFindByUserId(int userId, int begin, int RecordCount);

    //后台收藏管理查看商品模块，删除一个收藏的商品（改状态）
    public void collectionGoodDeleteByGoodsId(int goodsId, int userId);

    //
//	//后台收藏管理查看商品模块，全选删除收藏的商品（改状态）
//	public void collectionGoodDeleteAllGood(String[] goodAllId,int userId);
//
    //后台收藏管理查看商品模块，按条件查询符合条件的商品
    public List<CollectionGoods> collectionGoodSelectAllShop(int userId, String goodName, String datetime1, String datetime2, int begin, int RecordCount);

    //台收藏管理查看商品模块，根据条件查询共有多少条符合条件的记录
    public int collectionGoodstCount(int userId, String goodName, String datetime1, String datetime2);

//	/**
//	 * 用户点击“收藏商品”，添加一个收藏商品表(collection_good)
//	 * goodId:商品的Id号
//	 * userId:访问店铺的用户id号
//	 */

    public String userCollectionGood(int goodId, int userId);
}
