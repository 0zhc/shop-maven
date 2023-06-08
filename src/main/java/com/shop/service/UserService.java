package com.shop.service;


import com.shop.entity.Shop;
import com.shop.entity.User;

import java.util.List;

public interface UserService {
    //     //给用户添加一个商店
    public int addShop(int userId, Shop shop);

    public User getUserById(int userId);

    //修改商店的url
    public int updateShopUrl(String shopUrl, int shopId);

    //修改用户商店模板 1 为蓝色  2 为红色
    public int updateShopTemplate(int shopId, int template);

    //修改用户的店铺信息
    public int updateShop(int shopId, Shop shop);

    public User findUserByUserId(int userId);


//	public boolean updateUserType(int userId,int userType);
//	public boolean activeCode(int userId, String activeCode);
//

    //分页查询所有的会员
    public List<User> users(int begin, int RecordCount, String userName, String beginDate, String endDate);

    //分页   分页查询所有的会员记录数
    public int counts(String userName, String beginDate, String endDate);

    //	//删除会员
    public int deleteUserById(int userId);

//	//根据产品的Id查找用户
//	public User getUserByGoodsId(int goodsId);

//	/**
//	 * wuyixin
//	 *
//	 */
//

    //
//	public User updateByUserId(int userId);
//
    public int modifyUser(User user);

    public User oldPasswordExit(User user);

    User findUserByUserName(String userName);

    int activeCode(Integer id, String activeCode);

    void modifyUserType(Integer id);
}
