package com.shop.service.impl;


import com.shop.dao.ShopBasicInfoDao;
import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.service.ShopBasicInfoService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ShopBasicInfoServiceImpl implements ShopBasicInfoService {

    @Resource
    private ShopBasicInfoDao shopBasicInfoDao;
    @Resource
    private ShopService shopService;


    //在店铺页点击修改店主个人信息时，根据用户Id号带数值去修改页面
    public User findUserById(int userId) {

        return shopBasicInfoDao.findUserById(userId);
    }

    //在店铺页点击修改店主个人信息
    public void modifyUserInfo(User user) {

        shopBasicInfoDao.modifyUserInfo(user);
    }

    //
//	//在店铺页点击修改店铺名称时，根据用户Id号带数值去修改页面
//	public Shop shopNameByuserId(int userId){
//
//		return  shopBasicInfoDao.shopNameByuserId(userId);
//	}
//
    //在店铺页点击修改店铺名称
    public Shop modifyShopName(int userId, String shopName) {
        shopBasicInfoDao.modifyShopName(userId, shopName);
        return shopService.getShopByUserId(userId);
    }

}
