package com.shop.dao;

import com.shop.entity.Goods;
import com.shop.entity.Shop;
import com.shop.entity.searchShop;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopDao {
    public Shop getShopByUserId(@Param("userId") int userId);

    public Shop shop(@Param("shopId") int shopId);

    public int isShowHot(@Param("isShow") int isShow, @Param("shopId") int shopId);

    public int isShowNew(@Param("isShow") int isShow, @Param("shopId") int shopId);

    public int isShowSecond(@Param("isShow") int isShow, @Param("shopId") int shopId);

    public Shop getShopById(@Param("shopId") Integer shopId);


    //   //是否显示   最热 /最新/二手商品
//   public int isShow(@Param("isShow") int isShow,@Param("shopId") int shopId,@Param("setType") String setType);

//   public int add(Shop Dao);

    //   //增加店铺 logo
    public int addLogo(@Param("logoPath") String logoPath, @Param("shopId") int shopId);

    //  //增加banner
    public int addBanner(@Param("bannerPath") String bannerPath, @Param("shopId") int shopId);

    //   //是否显示   最热 /最新/二手商品
//   public void isShow(int isShow,int shopId,String setType);
//   //修改其他商品的文本
    public void setOtherText(@Param("shopId") int shopId, @Param("otherText") String otherText);

    //   //查询滚动图片的个数
    public List<Goods> getRollings(@Param("shopId") int shopId, @Param("goodsType") int goodsType);

    //   //增加店铺滚动图片
    public int addRollingGoods(@Param("goods") Goods goods);

    //   //修改店铺滚动图片
    public int modifRollingGoods(@Param("rollingGoodsPath") String rollingGoodsPath, @Param("goodsId") int goodsId);

    // //分页查询所有店铺名称根据时间排序
    public int getAllShopsCount(@Param("name") String name, @Param("isSore") int isSore, @Param("beginDate") String beginDate, @Param("endDate") String endDate);

    public List<searchShop> getAllShopObject(@Param("begin") int begin, @Param("RecordCount") int RecordCount, @Param("name") String name, @Param("isSore") int isSore, @Param("beginDate") String beginDate, @Param("endDate") String endDate);
//

    //分页查询所有开店类型称根据时间排序
    public int getAllShopsCountByShopBuyType(@Param("shopBuyType") String shopBuyType);

    public List<searchShop> getAllShopObjectbyShopBuyType(@Param("begin") int begin, @Param("RecordCount") int RecordCount, @Param("shopBuyType") String shopBuyType);
//
//   //通过店铺查找用户
//   public List<String> userTelephones(List<Shop> shop);

}
