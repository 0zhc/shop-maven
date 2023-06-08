package com.shop.dao;


import com.shop.entity.Shop;
import com.shop.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    public User getUserById(@Param("userId") int userId);

    //	//给用户添加一个商店
    public int addShop(@Param("userId") int userId, @Param("shop") Shop shop);

    public int updateShopUrl(@Param("shopUrl") String shopUrl, @Param("shopId") int shopId);

    //修改用户商店模板 1 为蓝色  2 为红色
    public int updateShopTemplate(@Param("shopId") int shopId, @Param("template") int template);

    public int updateShop(@Param("shopId") int shopId, @Param("shop") Shop shop);

    public User findUserByUserId(@Param("userId") int userId);


//	public void updateUserType(int userId,int userType);
//	public User getUserById(int userId);
//	public void updateShopUrl(String shopUrl,int shopId);
//	//激活码激活
//	public boolean activeCode(int userId,String activeCode);
//

    //	//修改用户的店铺信息
//	public void updateShop(int shopId,Shop shop);
//
    //分页查询所有的会员
    public List<User> users(@Param("begin") int begin, @Param("RecordCount") int RecordCount, @Param("userName") String userName, @Param("beginDate") String beginDate, @Param("endDate") String endDate);

    //分页   分页查询所有的会员记录数
    public int counts(@Param("userName") String userName, @Param("beginDate") String beginDate, @Param("endDate") String endDate);

    //	//删除会员
    public void deleteUserById(@Param("userId") int userId);
//	//根据产品的Id查找用户
//	public User getUserByGoodsId(int goodsId);
//	public User getUserByUserName(@Param("userName") String userName);
//
//	/**
//	 * wuyixin
//	 *
//	 */
//

//
//	public User updateByUserId(int userId);

    public int modifyUser(@Param("user") User user);

    public List<User> oldPasswordExit(@Param("user") User user);

    User findUserByUserName(@Param("userName") String userName);

    int activeCode(@Param("id") Integer id, @Param("activeCode") String activeCode);

    void modifyUserType(@Param("id") Integer id);
}
