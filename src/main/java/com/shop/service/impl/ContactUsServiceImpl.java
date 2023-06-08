package com.shop.service.impl;


import com.shop.dao.ContactUsDao;
import com.shop.entity.Shop;
import com.shop.service.ContactUsService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ContactUsServiceImpl implements ContactUsService {
    @Resource
    private ContactUsDao contactUsDao;
    @Resource
    private ShopService shopService;

//	public void setContactUsDao(ContactUsDao contactUsDao) {
//		this.contactUsDao = contactUsDao;
//	}
//
//	public Shop findContactUsByUserId(int userId) {
//		return contactUsDao.findContactUsByUserId(userId);
//	}

    public Shop modifySContactUs(int userId, String contactUs) {

        contactUsDao.modifySContactUs(userId, contactUs);
        return shopService.getShopByUserId(userId);
    }

}
