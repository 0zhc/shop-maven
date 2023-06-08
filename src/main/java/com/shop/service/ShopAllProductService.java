package com.shop.service;

/*
 * author:wuyixin
 * */

import com.shop.entity.Goods;

import java.util.List;

public interface ShopAllProductService {


    //用户在店铺页点击搜索按钮，按条件搜索符合条件的商品
    public List<Goods> findAllProInShop(int shopId, String proKeyWord,
                                        String oneProPrice, String twoProPrice, int startIndex, int limit);

    //用户在店铺页点击搜索按钮，按条件搜索总共有多少个商品符合条件
    public int findAllProInShopCount(int shopId, String proKeyWord,
                                     String oneProPrice, String twoProPrice);

    //用户通过店铺左边的商品分类搜索"最热"，"最新"，"二手商品"
    public List<Goods> findHotNewOldProInShop(int shopId, int goodsType);

    //用户通过店铺左边的商品分类搜索"其他商品"（类型为4）
    public List<Goods> findOtherProInShop(int shopId, String proKeyWord,
                                          String oneProPrice, String twoProPrice, int goodsType, int startIndex, int limit);

    //用户通过店铺左边的商品分类（或者搜索出来的页面上面的搜索条）搜索"其他商品"（类型为4）,搜索总共有多少个类型为4，并符合搜索条件的商品
    public int findOtherProInShopCount(int shopId, String proKeyWord,
                                       String oneProPrice, String twoProPrice, int goodsType);

}
