package com.shop.service.impl;


import com.shop.dao.LoginDao;
import com.shop.entity.User;
import com.shop.service.LoginService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class LoginServiceImpl implements LoginService {
//	private LoginDao getLoginDao(){
//		SqlSession sqlSession = SqlSessionUtil.getSqlSession();
//		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
//		return loginDao;
//	}

    @Resource
    private LoginDao loginDao;

//	public LoginDao getLoginDao() {
//		return loginDao;
//	}

    public void setLoginDao(LoginDao loginDao) {
        this.loginDao = loginDao;
    }

    //    //用户注册增加
    public int add(User user) {
        int userAdd = 0;
        if (loginDao.findUserByUserName(user.getUserName()) == 0 && loginDao.add(user) == 1) {
            try {
                System.out.println("----------" + user.getVersion());
                userAdd = 1;
            } catch (Exception e) {
                e.printStackTrace();

            }
        }
        return userAdd;
    }

    //注册-检查用户是否存在
    public int findUserByUserName(String userName) {
        int result = 1;
        try {
            if (loginDao.findUserByUserName(userName) == 0) {
                result = 0;
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }


    //登录
    public boolean isExist(String userName, String userPassword, String userType) {
        if ("1".equals(userType) || "2".equals((userType))) {
            Long count = loginDao.isExist(userName, userPassword, userType);
            return Integer.parseInt(count.toString()) > 0;//用户存在
        }

        return false;
    }


    //根据用户取得单个用户对象
    public User getUserByUserName(String userName) {
        User user = null;
        try {
            user = loginDao.getUserByUserName(userName);
        } catch (Exception e) {
            e.printStackTrace();

        }
        return user;
    }


}
