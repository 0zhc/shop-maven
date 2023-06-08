package com.shop.service.impl;


import com.shop.dao.ShopManageDao;
import com.shop.entity.Shop;
import com.shop.service.ShopManageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class ShopManageServiceImpl implements ShopManageService {
    @Resource
    private ShopManageDao shopManageDao;

    public List<Shop> findAllshopManage(int begin, int RecordCount) {

        return shopManageDao.findAllshopManage(begin, RecordCount);
    }

    public int shopManagetCount(String shopName, String shopUser,
                                String datetime1, String datetime2) {

        return shopManageDao.shopManagetCount(shopName, shopUser, datetime1, datetime2);
    }

    @Override
    public void shopManageDeleteById(int id) {
        shopManageDao.shopManageDeleteById(id);
    }

    //
    public List<Shop> shopManagerSelectAllShop(String shopName,
                                               String shopUser, String datetime1, String datetime2, int begin,
                                               int RecordCount) {

        return shopManageDao.shopManagerSelectAllShop(shopName, shopUser, datetime1, datetime2, begin, RecordCount);
    }

    public void shopManageDeleteByShopId(int shopId) {

        shopManageDao.shopManageDeleteByShopId(shopId);
    }

//	public void shopManagerDeleteAllShop(String[] shopAllId) {
//
//		shopManageDao.shopManagerDeleteAllShop(shopAllId);
//	}

}
