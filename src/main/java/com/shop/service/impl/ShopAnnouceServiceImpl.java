package com.shop.service.impl;

import com.shop.dao.ShopAnnouceDao;
import com.shop.entity.ShopAnnouce;
import com.shop.service.ShopAnnouceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ShopAnnouceServiceImpl implements ShopAnnouceService {
    @Resource
    private ShopAnnouceDao shopAnnouceDao;

    //
//	public void setShopAnnouceDao(ShopAnnouceDao shopAnnouceDao) {
//		this.shopAnnouceDao = shopAnnouceDao;
//	}
//
    public List<ShopAnnouce> addShopAnnouce(int shopId, String newOne, String newTwo,
                                            String newThree, String newFour) {
        List list = new ArrayList();
        if (newOne == null) {
            list.add(null);
        } else {
            list.add(newOne);
        }
        if (newTwo == null) {
            list.add(null);
        } else {
            list.add(newTwo);
        }
        if (newThree == null) {
            list.add(null);
        } else {
            list.add(newThree);
        }
        list.add(newFour);

//		list.add(newTwo);
//		list.add(newThree);
//		list.add(newFour);
//		ShopAnnouce[] shopAnnouce = new ShopAnnouce[4];

        Date date = new Date();

        for (int i = 0; i < 4; i++) {
//			ShopAnnouce shopAnnouce1 = shopAnnouce.g;
            ShopAnnouce shopAnnouce = new ShopAnnouce();
            System.out.println("+++" + list.get(i));
            System.out.println("+++" + list.get(i));
            shopAnnouce.setContent(String.valueOf(list.get(i)));
            System.out.println("++++" + list.get(i));
            shopAnnouce.setTag(1);
            shopAnnouce.setInTime(date);
            shopAnnouceDao.addShopAnnouce(shopId, shopAnnouce);

        }
//		ShopAnnouce shopAnnouce = new ShopAnnouce();
//		ShopAnnouce shopAnnouce = new ShopAnnouce();
//		ShopAnnouce shopAnnouce = new ShopAnnouce();


        return shopAnnouceDao.getShopAnnouce(shopId);
    }

    //	public List<ShopAnnouce> findNewByUserId(int userId) {
//
//		return shopAnnouceDao.findNewByUserId(userId);
//	}
    public List<ShopAnnouce> findNewByShopId(int shopId) {

        return shopAnnouceDao.findNewByShopId(shopId);
    }

    //
    public List<ShopAnnouce> modifyShopAnnouce(int shopId, String newOne, String newTwo,
                                               String newThree, String newFour) {
        List<ShopAnnouce> shopAnnouceList = shopAnnouceDao.getShopAnnouce(shopId);
        List list = new ArrayList();
        list.add(newOne);
        list.add(newTwo);
        list.add(newThree);
        list.add(newFour);
        for (int i = 0; i < shopAnnouceList.size(); i++) {
            ShopAnnouce shopAnnouce = shopAnnouceList.get(i);
            Integer id = shopAnnouce.getId();
            shopAnnouce.setContent((String) list.get(i));
            shopAnnouceDao.modifyShopAnnouce(id, (String) list.get(i));
        }


        return shopAnnouceDao.getShopAnnouce(shopId);
    }

}
