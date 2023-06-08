package com.shop.service.impl;

import com.shop.dao.UserDao;
import com.shop.entity.Shop;
import com.shop.entity.User;
import com.shop.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    public User getUserById(int userId) {
        User user = new User();
        try {
            user = userDao.getUserById(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    //给用户添加商店
    public int addShop(int userId, Shop shop) {
        int addNum = 0;
        try {
            if (userDao.addShop(userId, shop) == 1) {
                addNum = 1;

            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return addNum;
    }

    public int updateShopUrl(String shopUrl, int shopId) {
        int updateNum = 0;
        try {
            if (userDao.updateShopUrl(shopUrl, shopId) == 1)
                updateNum = 1;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;
    }

    public int updateShopTemplate(int shopId, int template) {
        int updateNum = 0;
        try {
            userDao.updateShopTemplate(shopId, template);
            updateNum = 1;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;
    }

    public int updateShop(int shopId, Shop shop) {
        int updateNum = 0;
        try {
            if (userDao.updateShop(shopId, shop) == 1) {
                updateNum = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        return updateNum;
    }

    public User findUserByUserId(int userId) {

        return userDao.findUserByUserId(userId);
    }


//	 //修改用户的类型 1 为学生  2 为商家
//	public boolean updateUserType(int userId,int userType) {
//		boolean isModify=false;
//		try{
//		userDao.updateUserType(userId, userType);
//		isModify=true;
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return isModify;
//	}

//
//	public boolean activeCode(int userId, String activeCode) {
//		boolean isActive=false;
//		try{
//			if(userDao.activeCode(userId, activeCode)){
//				isActive=true;
//			}
//			else
//				isActive=false;
//
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//
//		return isActive;
//	}
//
//
//

    //分页查询所有的会员
    public int counts(String userName, String beginDate, String endDate) {
        // TODO Auto-generated method stub
        return userDao.counts(userName, beginDate, endDate);
    }

    //分页   分页查询所有的会员记录数
    public List<User> users(int begin, int RecordCount, String userName,
                            String beginDate, String endDate) {

        return userDao.users(begin, RecordCount, userName, beginDate, endDate);
    }

    //删除会员
    public int deleteUserById(int userId) {
        int deleteNum = 0;
        try {
            userDao.deleteUserById(userId);
            deleteNum = 1;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println(e);
            e.printStackTrace();
        }
        return deleteNum;


    }
//
//	public boolean updateShopUrl(String shopUrl, int shopId) {
//		boolean isUpdate=false;
//		try {
//			userDao.updateShopUrl(shopUrl, shopId);
//			isUpdate=true;
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return isUpdate;
//	}
//
//	public User getUserByGoodsId(int goodsId) {
//
//		return userDao.getUserByGoodsId(goodsId);
//	}
//
//	/**
//	 * wuyixin
//	 *
//	 */
//
//
//

    //	public User updateByUserId(int userId) {
//
//		return userDao.updateByUserId(userId);
//	}
//
    public int modifyUser(User user) {
        return userDao.modifyUser(user);

    }

    //
    public User oldPasswordExit(User user) {
        List<User> users = userDao.oldPasswordExit(user);

        if (users.size() > 0) {
            User user1 = users.get(0);

            return user1;
        }
        return null;
    }

    @Override
    public User findUserByUserName(String userName) {
        return userDao.findUserByUserName(userName);
    }

    @Override
    public int activeCode(Integer id, String activeCode) {
        return userDao.activeCode(id, activeCode);
    }

    @Override
    public void modifyUserType(Integer id) {
        userDao.modifyUserType(id);
    }

}
