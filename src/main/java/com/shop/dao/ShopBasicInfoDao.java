package com.shop.dao;


import com.shop.entity.User;
import org.apache.ibatis.annotations.Param;

public interface ShopBasicInfoDao {

    //在店铺页点击修改店主个人信息时，根据用户Id号带数值去修改页面
    public User findUserById(@Param("userId") int userId);

    //	//在店铺页点击修改店主个人信息
    public void modifyUserInfo(@Param("user") User user);

    //
//	//在店铺页点击修改店铺名称时，根据用户Id号带数值去修改页面
//	public Shop shopNameByuserId(int userId);
//
//	//在店铺页点击修改店铺名称
    public void modifyShopName(@Param("userId") int userId, @Param("shopName") String shopName);
}
