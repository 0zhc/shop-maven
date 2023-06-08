package com.shop.service.impl;

import com.shop.dao.SecureShopDao;
import com.shop.entity.Shop;
import com.shop.service.SecureShopService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class SecureShopServiceImpl implements SecureShopService {

    @Resource
    private SecureShopDao secureShopDao;
    @Resource
    private ShopService shopService;

    //
//	public void setSecureShopDao(SecureShopDao secureShopDao) {
//		this.secureShopDao = secureShopDao;
//	}
//
//
//	public Shop findSecureByUserId(int userId) {
//		return secureShopDao.findSecureByUserId(userId);
//	}
//
//
    public Shop modifySecure(int userId, String secureShop) {

        secureShopDao.modifySecure(userId, secureShop);
        return shopService.getShopByUserId(userId);
    }

}
