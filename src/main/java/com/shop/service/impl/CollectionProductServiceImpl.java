package com.shop.service.impl;


import com.shop.dao.CollectionProductDao;
import com.shop.entity.CollectionGoods;
import com.shop.service.CollectionProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/*
 *author:wuyixin
 *
 */
@Service("collectionProductService")
public class CollectionProductServiceImpl implements CollectionProductService {

    @Resource
    private CollectionProductDao collectionProductDao;

    @Override
    public int collectionGoodsCountByUserId(int userId) {
        return collectionProductDao.collectionGoodsCountByUserId(userId);
        //后台收藏管理点击“商品”查看收藏的所有商品
    }

    public List<CollectionGoods> collectionProductFindByUserId(int userId, int begin, int RecordCount) {

        return collectionProductDao.collectionProductFindByUserId(userId, begin, RecordCount);
    }

    //后台收藏管理查看商品模块，删除一个收藏的商品（改状态）
    public void collectionGoodDeleteByGoodsId(int goodsId, int userId) {

        collectionProductDao.collectionGoodDeleteByGoodsId(goodsId, userId);
    }


    //台收藏管理查看商品模块，根据条件查询共有多少条符合条件的记录
    public int collectionGoodstCount(int userId, String goodName,
                                     String datetime1, String datetime2) {

        return collectionProductDao.collectionGoodstCount(userId, goodName, datetime1, datetime2);
    }

    //后台收藏管理查看商品模块，按条件查询符合条件的商品
    public List<CollectionGoods> collectionGoodSelectAllShop(int userId,
                                                             String goodName, String datetime1, String datetime2, int begin,
                                                             int RecordCount) {

        return collectionProductDao.collectionGoodSelectAllShop(userId, goodName, datetime1, datetime2, begin, RecordCount);
    }


//
//	//后台收藏管理查看商品模块，全选删除收藏的商品（改状态）
//	public void collectionGoodDeleteAllGood(String[] goodAllId, int userId) {
//
//		collectionProductDao.collectionGoodDeleteAllGood(goodAllId, userId);
//
//	}
//
//	/**
//	 * 用户点击“收藏商品”，添加一个收藏商品表(collection_good)
//	 * goodId:商品的Id号
//	 * userId:访问店铺的用户id号
//	 */

    public String userCollectionGood(int goodId, int userId) {

//		String hql = "from CollectionGoods c join fetch c.goods where c.user.id =? and c.goods.id = ? and c.tag = ?";

        CollectionGoods usercollectionGoods = collectionProductDao.selectCollectionGoods(goodId, userId);


        //判读店铺是否已经被收藏
        if (usercollectionGoods == null) {
//			collectionProductDao.userCollectionGood(goodId, userId);

//			Goods good = (Goods)this.getSession().load(Goods.class, goodId);
//
//			User user = (User)this.getSession().load(User.class, userId);

            CollectionGoods collectionGoods = new CollectionGoods();
            collectionGoods.setUserId(userId);
            collectionGoods.setGoodsId(goodId);
//			collectionGoods.setUser(user);
//			collectionGoods.setGoods(good);
            collectionGoods.setStoreDate(new Date());
            collectionGoods.setTag(1);
//
//
//
            collectionProductDao.save(collectionGoods);

            return "noCollection";

        } else {

            return "hasCollection";

        }

    }


}
