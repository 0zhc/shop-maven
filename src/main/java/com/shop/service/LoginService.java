package com.shop.service;


import com.shop.entity.User;

public interface LoginService {
    //增加用户
    public int add(User user);

    //验证用户是否存在
    public int findUserByUserName(String userName);

    public boolean isExist(String userName, String userPassword, String userType);

    public User getUserByUserName(String userName);
}
