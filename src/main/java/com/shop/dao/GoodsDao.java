package com.shop.dao;

import com.shop.entity.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsDao {

    //通过商店的id查找用户所有的商品
    public List<Goods> getUserGoods(@Param("shopId") int shopId);

    public Goods findGoodsById(@Param("id") Integer id);

    //	//分页查询
    public int count(@Param("goodType") int goodType, @Param("name") String name, @Param("userId") int userId);

    public List<Goods> goodses(@Param("begin") int begin, @Param("RecordCount") int RecordCount, @Param("goodType") int goodType, @Param("name") String name, @Param("userId") int userId);

    //  //通过Id找到相应的商品
//  public Goods getGoodsById(int goodsId);
//  //修改商品
    public void ModifyGoodsById(@Param("goodsId") int goodsId, @Param("good") Goods good);

    //
//  //删除商品
    public void deleteGoodsById(@Param("goodsId") int goodsId);

    //分页查询所有商品搜索的关键字为商品名
    public int getAllGoodsCount(@Param("isNew") int isNew, @Param("name") String name, @Param("isSore") int isSore, @Param("beginPrice") float beginPrice, @Param("endPrice") float endPrice);

    public List<Goods> getAllGoodses(@Param("begin") int begin, @Param("RecordCount") int RecordCount, @Param("isNew") int isNew, @Param("name") String name, @Param("isSore") int isSore, @Param("beginPrice") float beginPrice, @Param("endPrice") float endPrice);

    //
//  //liuming
//  //根据ID获取产品
//  public Goods findGoodsById(Integer id);
//  //根据产品名获取产品
//  public List<Goods> findGoodsByName(String goodsName);
//  //更新产品
    public int updateGoods(@Param("goods") Goods goods);
//

}
