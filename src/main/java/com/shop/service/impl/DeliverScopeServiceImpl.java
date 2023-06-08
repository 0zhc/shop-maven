package com.shop.service.impl;


import com.shop.dao.DeliverScopeDao;
import com.shop.entity.Shop;
import com.shop.service.DeliverScopeService;
import com.shop.service.ShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class DeliverScopeServiceImpl implements DeliverScopeService {

    @Resource
    private DeliverScopeDao deliverScopeDao;
    @Resource
    private ShopService shopService;

    //
//	public void setDeliverScopeDao(DeliverScopeDao deliverScopeDao) {
//		this.deliverScopeDao = deliverScopeDao;
//	}
//
//	public Shop findScopeByUserId(int userId) {
//
//		return deliverScopeDao.findScopeByUserId(userId);
//	}
//
    public Shop modifyShopScope(int userId, String deliverScope) {
        deliverScopeDao.modifyShopScope(userId, deliverScope);
        return shopService.getShopByUserId(userId);

    }

}
