package com.shop.service;


import com.shop.entity.Shop;
import com.shop.entity.User;

public interface ShopBasicInfoService {

    //在店铺页点击修改店主个人信息时，根据用户Id号带数值去修改页面
    public User findUserById(int userId);

    //
//	//在店铺页点击修改店主个人信息
    public void modifyUserInfo(User user);

    //
//	//在店铺页点击修改店铺名称时，根据用户Id号带数值去修改页面
//	public Shop shopNameByuserId(int userId);
//
//	//在店铺页点击修改店铺名称
    public Shop modifyShopName(int userId, String shopName);
}
