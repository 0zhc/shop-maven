package com.shop.dao;


import com.shop.entity.CollectionGoods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CollectionProductDao {

    //根据userId查询共有多少条符合条件的记录
    public int collectionGoodsCountByUserId(@Param("userId") int userId);

    //后台收藏管理点击“商品”查看收藏的所有商品
    public List<CollectionGoods> collectionProductFindByUserId(@Param("userId") int userId, @Param("begin") int begin, @Param("recordCount") int recordCount);

    //
    //后台收藏管理查看商品模块，删除一个收藏的商品（改状态）
    public void collectionGoodDeleteByGoodsId(@Param("goodsId") int goodsId, @Param("userId") int userId);

    //
//	//后台收藏管理查看商品模块，全选删除收藏的商品（改状态）
//	public void collectionGoodDeleteAllGood(String[] goodAllId,int userId);
//
    //后台收藏管理查看商品模块，按条件查询符合条件的商品
    public List<CollectionGoods> collectionGoodSelectAllShop(@Param("userId") int userId, @Param("goodName") String goodName, @Param("datetime1") String datetime1, @Param("datetime2") String datetime2, @Param("begin") int begin,
                                                             @Param("RecordCount") int RecordCount);

    //台收藏管理查看商品模块，根据条件查询共有多少条符合条件的记录
    public int collectionGoodstCount(@Param("userId") int userId, @Param("goodName") String goodName, @Param("datetime1") String datetime1, @Param("datetime2") String datetime2);

    public CollectionGoods selectCollectionGoods(@Param("goodsId") int goodsId, @Param("userId") int userId);


    public void save(@Param("collectionGoods") CollectionGoods collectionGoods);
//
//	/**
//	 * 用户点击“收藏商品”，添加一个收藏商品表(collection_good)
//	 * goodId:商品的Id号
//	 * userId:访问店铺的用户id号
//	 */
//
//	public String userCollectionGood(int goodId,int userId);
}
