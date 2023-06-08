package com.shop.service.impl;

import com.shop.dao.CollectionShopDao;
import com.shop.entity.CollectionShop;
import com.shop.service.CollectionShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class CollectionShopServiceImpl implements CollectionShopService {

    @Resource
    private CollectionShopDao collectionShopDao;


    //台收藏管理查看店铺模块，根据条件查询共有多少条符合条件的记录
    public int collectionShopCountByUserId(int userId) {

        return collectionShopDao.collectionShopCountByUserId(userId);
    }    //后台收藏管理点击“店铺”查看收藏的所有店铺

    public List<CollectionShop> collectionShopFindByUserId(int userId, int begin, int RecordCount) {

        return collectionShopDao.collectionShopFindByUserId(userId, begin, RecordCount);
    }

    //台收藏管理查看店铺模块，根据条件查询共有多少条符合条件的记录
    public int collectionShopCount(int userId, String shopName, String datetime1, String datetime2) {

        return collectionShopDao.collectionShopCount(userId, shopName, datetime1, datetime2);
    }

    //后台收藏管理查看店铺模块，按条件查询符合条件的店铺
    public List<CollectionShop> collectionShopSelectAllShop(int userId, String shopName, String datetime1, String datetime2, int begin, int RecordCount) {

        return collectionShopDao.collectionShopSelectAllShop(userId, shopName, datetime1, datetime2, begin, RecordCount);
    }


    //后台收藏管理查看店铺模块，删除一个收藏的店铺（改状态）
    public void collectionShopDeleteByShopId(int shopId, int userId) {

        collectionShopDao.collectionShopDeleteByShopId(shopId, userId);

    }

//	//后台收藏管理查看店铺模块，全选删除收藏的店铺（改状态）
//	public void collectionShopDeleteAllShop(String[] shopAllId, int userId) {
//		 collectionShopDao.collectionShopDeleteAllShop(shopAllId, userId);
//	}
//


    //
//
//	/**
//	 * 用户在店铺页面点击“收藏店铺”，添加一个收藏店铺表
//	 * shopId:店铺的Id号
//	 * userId:访问店铺的用户id号
//	 */
    public String userCollectionShop(int shopId, int userId) {
//        String hql = "from CollectionShop c join fetch c.shops where c.user.id =? and c.shops.id = ? and c.tag = ?";

        CollectionShop userCollectionShop = collectionShopDao.sleectCollectionShop(shopId, userId);
        //判读店铺是否已经被收藏
        if (userCollectionShop == null) {
            CollectionShop collectionShop = new CollectionShop();
            collectionShop.setShopsId(shopId);
            collectionShop.setUserId(userId);
//            collectionShop.setUser(user);
//            collectionShop.setShops(shop);
            collectionShop.setStoreDate(new Date());
            collectionShop.setTag(1);
            collectionShopDao.save(collectionShop);
            return "noCollection";
        } else {
            return "hasCollection";
        }
    }
}
