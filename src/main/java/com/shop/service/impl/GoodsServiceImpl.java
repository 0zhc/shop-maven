package com.shop.service.impl;


import com.shop.dao.GoodsDao;
import com.shop.entity.Goods;
import com.shop.service.GoodsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Resource
    GoodsDao goodsDao;


    //通过商店的id查找用户所有的商品
    public List<Goods> getUserGoods(int shopId) {

        return goodsDao.getUserGoods(shopId);
    }

    public Goods findGoodsById(Integer id) {
        return goodsDao.findGoodsById(id);

    }

    //分页查询所有商品搜索的关键字为商品名
    public int getAllGoodsCount(int isNew, String name, int isSore, float beginPrice, float endPrice) {

        return goodsDao.getAllGoodsCount(isNew, name, isSore, beginPrice, endPrice);
    }

    public List<Goods> getAllGoodses(int begin, int RecordCount, int isNew,
                                     String name, int isSore, float beginPrice, float endPrice) {

        return goodsDao.getAllGoodses(begin, RecordCount, isNew, name, isSore, beginPrice, endPrice);
    }

    public int updateGoods(Goods goods) {
        int updateNum = 0;
        try {
            updateNum = goodsDao.updateGoods(goods);

        } catch (Exception e) {
            System.out.println(e);

        }
        return updateNum;
    }


    //
    public int count(int goodType, String name, int userId) {

        return goodsDao.count(goodType, name, userId);
    }


    public List<Goods> goodses(int begin, int RecordCount, int goodType,
                               String name, int userId) {
        List goodses = goodsDao.goodses(begin, RecordCount, goodType, name, userId);
        return goodses;
    }

    public boolean ModifyGoodsById(int goodsId, Goods good) {
        boolean isModify = false;
        try {
            goodsDao.ModifyGoodsById(goodsId, good);
            isModify = true;
        } catch (Exception e) {

            e.printStackTrace();
        }

        return isModify;
    }

    public boolean deleteGoodsById(int goodsId) {
        boolean isDelete = false;
        try {
            goodsDao.deleteGoodsById(goodsId);
            isDelete = true;
        } catch (Exception e) {

            e.printStackTrace();
        }

        return isDelete;
    }
//
//	public Goods getGoodsById(int goodsId) {
//
//		return goodsDao.getGoodsById(goodsId);
//	}


//
//
//	//liuming
//
//	public Goods findGoodsById(Integer id) {
//		Goods goods = goodsDao.findGoodsById(id);
//		return goods;
//	}
//
//	public List<Goods> findGoodsByName(String goodsName) {
//		List<Goods> goods = goodsDao.findGoodsByName(goodsName);
//		return goods;
//	}
//


}
