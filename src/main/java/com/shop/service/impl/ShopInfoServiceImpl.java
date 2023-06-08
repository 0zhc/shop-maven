package com.shop.service.impl;


import com.shop.dao.ShopInfoDao;
import com.shop.entity.Shop;
import com.shop.service.ShopInfoService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ShopInfoServiceImpl implements ShopInfoService {
    @Resource
    private ShopInfoDao shopInfoDao;
    @Resource
    private ShopService shopService;

    //
//	public void setShopInfoDao(ShopInfoDao shopInfoDao) {
//		this.shopInfoDao = shopInfoDao;
//	}
//
//	public Shop findBussIntroByUserId(int userId) {
//
//		return shopInfoDao.findBussIntroByUserId(userId);
//	}
//
    public Shop modifyShopIntro(int userId, String shopInfoText) {

        shopInfoDao.modifyShopIntro(userId, shopInfoText);
        return shopService.getShopByUserId(userId);
    }

}
