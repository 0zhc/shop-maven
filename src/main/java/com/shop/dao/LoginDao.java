package com.shop.dao;


import com.shop.entity.User;
import org.apache.ibatis.annotations.Param;

public interface LoginDao {
    //用户注册
    public int add(User user);

    //注册时，检查用户账号是否已经存在
    public int findUserByUserName(@Param("userName") String userName);

    //登录
    public long isExist(@Param("userName") String userName, @Param("userPassword") String userPassword, @Param("userType") String userType);

    //根据用户名返回一个用户对象
    public User getUserByUserName(@Param("userName") String userName);
}
