package com.shop.service.impl;

/*
 * author:wuyixin
 * */

import com.shop.dao.ShopAllProductDao;
import com.shop.entity.Goods;
import com.shop.service.ShopAllProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ShopAllProductServiceImpl implements ShopAllProductService {

    @Resource
    private ShopAllProductDao shopAllProductDao;

    //
//	public void setShopAllProductDao(ShopAllProductDao shopAllProductDao) {
//		this.shopAllProductDao = shopAllProductDao;
//	}
//
    //用户在店铺页点击搜索按钮，按条件搜索符合条件的商品
    public List<Goods> findAllProInShop(int shopId, String proKeyWord,
                                        String oneProPrice, String twoProPrice, int startIndex, int limit) {

        return shopAllProductDao.findAllProInShop(shopId, proKeyWord,
                oneProPrice, twoProPrice, startIndex, limit);
    }

    //用户在店铺页点击搜索按钮，按条件搜索总共有多少个商品符合条件
    public int findAllProInShopCount(int shopId, String proKeyWord,
                                     String oneProPrice, String twoProPrice) {

        return shopAllProductDao.findAllProInShopCount(shopId, proKeyWord, oneProPrice, twoProPrice);
    }

    //
//	//用户通过店铺左边的商品分类搜索最热，最新，二手商品
    public List<Goods> findHotNewOldProInShop(int shopId, int goodsType) {

        return shopAllProductDao.findHotNewOldProInShop(shopId, goodsType);
    }

    @Override
    public List<Goods> findOtherProInShop(int shopId, String proKeyWord, String oneProPrice, String twoProPrice, int goodsType, int startIndex, int limit) {
        return shopAllProductDao.findOtherProInShop(shopId, proKeyWord, oneProPrice, twoProPrice, goodsType, startIndex, limit);
    }

    @Override
    public int findOtherProInShopCount(int shopId, String proKeyWord, String oneProPrice, String twoProPrice, int goodsType) {
        return shopAllProductDao.findOtherProInShopCount(shopId, proKeyWord, oneProPrice, twoProPrice, goodsType);
    }


}
