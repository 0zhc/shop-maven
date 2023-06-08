package com.shop.service;

import com.shop.entity.Goods;
import com.shop.entity.Shop;
import com.shop.entity.searchShop;

import java.util.List;

public interface ShopService {

    public Shop getShopByUserId(int userId);

    public Shop shop(int shopId);

    //设置模块是否显示   1 为显示 2为不显示  最热、最新、二手
    public int isShowHot(int isShow, int shopId);

    public int isShowNew(int isShow, int shopId);

    public int isShowSecond(int isShow, int shopId);

    public Shop getShopById(Integer shopId);


    //	//增加店铺 logo
    public int addLogo(String logoPath, int shopId);

    //	//增加banner
    public int addBanner(String bannerPath, int shopId);

    //查询滚动图片的个数
    public List<Goods> getRollings(int shopId, int goodsType);

    //	////增加店铺滚动图片
    public int addRollingGoods(Goods goods);

    //    //修改店铺滚动图片
    public int modifRollingGoods(String rollingGoodsPath, int goodsId);

    //	//设置其他商品文本
    public boolean setOtherText(int shopId, String otherText);

    //分页查询所有店铺名称根据时间排序
    public List<searchShop> getAllShopObject(int begin, int RecordCount, String name, int isSore, String beginDate, String endDate);

    public int getAllShopsCount(String name, int isSore, String beginDate, String endDate);

    //	//通过店铺查找用户
//	public List<String> userTelephones(List<Shop> shops);
//
    //分页查询所有开店类型称根据时间排序
    public List<searchShop> getAllShopObjectbyShopBuyType(int begin, int RecordCount, String shopBuyType);

    public int getAllShopsCountByShopBuyType(String shopBuyType);
//

}
