package com.shop.service;

import com.shop.entity.ShopEvaluation;

import java.util.List;

public interface ShopEvaluationService {
    public void addShopEvaluation(ShopEvaluation shopEvaluation);

    public int getTotal(int shopId);

    public List<ShopEvaluation> getShopEvaluationsByHql(int shopId, Integer start, Integer max);
}
