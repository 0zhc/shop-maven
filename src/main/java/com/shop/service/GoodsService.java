package com.shop.service;

import com.shop.entity.Goods;

import java.util.List;

public interface GoodsService {
    //通过商店的id查找用户所有的商品
    public List<Goods> getUserGoods(int shopId);

    public Goods findGoodsById(Integer id);

    //分页查询所有商品搜索的关键字为商品名
    public int getAllGoodsCount(int isNew, String name, int isSore, float beginPrice, float endPrice);

    public List<Goods> getAllGoodses(int begin, int RecordCount, int isNew, String name, int isSore, float beginPrice, float endPrice);

    public int updateGoods(Goods goods);


    //	//分页查询
    public int count(int goodsType, String name, int userId);

    public List<Goods> goodses(int begin, int RecordCount, int goodType, String name, int userId);

    //	  public Goods getGoodsById(int goodsId);
//	  //修改商品
    public boolean ModifyGoodsById(int goodsId, Goods good);

    //
//	  //删除商品
    public boolean deleteGoodsById(int goodsId);
    //分页查询所有商品搜索的关键字为商品名


//
//
//		//liuming
//		public Goods findGoodsById(Integer id);
//		public List<Goods> findGoodsByName(String goodsName);

}
