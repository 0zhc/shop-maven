package com.shop.dao;

import com.shop.entity.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/*
 * author:wuyixin
 * */
public interface ShopAllProductDao {

    //用户在店铺页点击搜索按钮，按条件搜索符合条件的商品
    public List<Goods> findAllProInShop(@Param("shopId") int shopId, @Param("proKeyWord") String proKeyWord,
                                        @Param("oneProPrice") String oneProPrice, @Param("twoProPrice") String twoProPrice, @Param("startIndex") int startIndex, @Param("limit") int limit);

    //用户在店铺页点击搜索按钮，按条件搜索总共有多少个商品符合条件
    public int findAllProInShopCount(@Param("shopId") int shopId, @Param("proKeyWord") String proKeyWord,
                                     @Param("oneProPrice") String oneProPrice, @Param("twoProPrice") String twoProPrice);

    //用户通过店铺左边的商品分类搜索"最热"，"最新"，"二手商品"
    public List<Goods> findHotNewOldProInShop(@Param("shopId") int shopId, @Param("goodsType") int goodsType);

    public List<Goods> findOtherProInShop(@Param("shopId") int shopId, @Param("proKeyWord") String proKeyWord,
                                          @Param("oneProPrice") String oneProPrice, @Param("twoProPrice") String twoProPrice, @Param("goodsType") int goodsType, @Param("startIndex") int startIndex, @Param("limit") int limit);

    public int findOtherProInShopCount(@Param("shopId") int shopId, @Param("proKeyWord") String proKeyWord,
                                       @Param("oneProPrice") String oneProPrice, @Param("twoProPrice") String twoProPrice, @Param("goodsType") int goodsType);

//	//用户通过店铺左边的商品分类搜索"其他商品"（类型为4）
//	public List<Goods> findOtherProInShop(int userId, String proKeyWord,
//			String oneProPrice, String twoProPrice,int goodsType, int startIndex, int limit);
//
//	//用户通过店铺左边的商品分类（或者搜索出来的页面上面的搜索条）搜索"其他商品"（类型为4）,搜索总共有多少个类型为4，并符合搜索条件的商品
//	public int findOtherProInShopCount(int userId, String proKeyWord,
//			String oneProPrice, String twoProPrice, int goodsType);

}
