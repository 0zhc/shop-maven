package com.shop.service.impl;


import com.shop.dao.ShopEvaluationDao;
import com.shop.entity.ShopEvaluation;
import com.shop.service.ShopEvaluationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ShopEvaluationServiceImpl implements ShopEvaluationService {
    //
    @Resource
    private ShopEvaluationDao shopEvaluationDao;

    //
    public void addShopEvaluation(ShopEvaluation shopEvaluation) {
        shopEvaluationDao.saveShopEvaluation(shopEvaluation);
    }

    //
    public List<ShopEvaluation> getShopEvaluationsByHql(int shopId,
                                                        Integer start, Integer max) {
        return shopEvaluationDao.findAllShopEvaluationByHql(shopId, start, max);
    }

    //
    public int getTotal(int shopId) {
        // TODO Auto-generated method stub
        return shopEvaluationDao.getTotal(shopId);
    }
//
//	public ShopEvaluationDao getShopEvaluationDao() {
//		return shopEvaluationDao;
//	}
//
//	public void setShopEvaluationDao(ShopEvaluationDao shopEvaluationDao) {
//		this.shopEvaluationDao = shopEvaluationDao;
//	}

}
