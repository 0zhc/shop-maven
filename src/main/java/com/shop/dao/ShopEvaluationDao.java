package com.shop.dao;

import com.shop.entity.ShopEvaluation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopEvaluationDao {
    public void saveShopEvaluation(@Param("shopEvaluation") ShopEvaluation shopEvaluation);

    public Integer getTotal(@Param("shopId") int shopId);

    public List<ShopEvaluation> findAllShopEvaluationByHql(@Param("shopId") int shopId, @Param("start") Integer start, @Param("max") Integer max);
}
