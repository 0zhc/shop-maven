package com.shop.service.impl;

import com.shop.dao.ShopDao;
import com.shop.entity.Goods;
import com.shop.entity.Shop;
import com.shop.entity.searchShop;
import com.shop.service.ShopService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ShopServiceImpl implements ShopService {
    @Resource
    ShopDao shopDao;

    public Shop getShopByUserId(int userId) {
        return shopDao.getShopByUserId(userId);
    }

    public Shop shop(int shopId) {

        return shopDao.shop(shopId);
    }

    @Override
    public int isShowHot(int isShow, int shopId) {
        int updateNum = 0;
        try {
            if (shopDao.isShowHot(isShow, shopId) == 1)
                updateNum = 1;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;
    }

    @Override
    public int isShowNew(int isShow, int shopId) {
        int updateNum = 0;
        try {
            if (shopDao.isShowNew(isShow, shopId) == 1)
                updateNum = 1;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;
    }

    @Override
    public int isShowSecond(int isShow, int shopId) {
        int updateNum = 0;
        try {
            if (shopDao.isShowSecond(isShow, shopId) == 1)
                updateNum = 1;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;
    }

    @Override
    public Shop getShopById(Integer shopId) {
        return shopDao.getShopById(shopId);
    }

//    public int isShow(int isShow, int shopId, String setType) {
//        int updateNum=0;
//        try {
//            if (shopDao.isShow(isShow, shopId, setType)==1)
//            updateNum=1;
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        }
//        return updateNum;
//    }


//
//	public ShopDao getShopDao() {
//		return shopDao;
//	}
//
//	public void setShopDao(ShopDao shopDao) {
//		this.shopDao = shopDao;
//	}
//
//	public boolean add(Shop Dao) {
//
//		return false;
//	}
//

    //
    public int addLogo(String logoPath, int shopId) {
        int updateNum = 0;
        try {
            if (shopDao.addLogo(logoPath, shopId) == 1) {
                updateNum = 1;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;

    }

    //
    public int addBanner(String bannerPath, int shopId) {
        int updateNum = 0;
        try {
            if (shopDao.addBanner(bannerPath, shopId) == 1) {
                updateNum = 1;
            }
//			shopDao.addBanner(bannerPath, shopId);
//			isAdd=true;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return updateNum;

    }

    //
    public List<Goods> getRollings(int shopId, int goodsType) {

        return shopDao.getRollings(shopId, goodsType);
    }

    //    //增加店铺滚动图片
    public int addRollingGoods(Goods goods) {
        int getId = 0;
        try {
            getId = shopDao.addRollingGoods(goods);

        } catch (Exception e) {

            e.printStackTrace();
        }
        return getId;

    }

    //修改店铺滚动图片
    public int modifRollingGoods(String rollingGoodsPath, int goodsId) {
        int getId = 0;
        try {
            getId = shopDao.modifRollingGoods(rollingGoodsPath, goodsId);

        } catch (Exception e) {

            e.printStackTrace();
        }
        return getId;

    }


    public boolean setOtherText(int shopId, String otherText) {
        boolean isUpdate = false;
        try {
            shopDao.setOtherText(shopId, otherText);
            isUpdate = true;
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return isUpdate;
    }

    // 分页查询所有店铺名称根据时间排序
    public List<searchShop> getAllShopObject(int begin, int RecordCount, String name,
                                             int isSore, String beginDate, String endDate) {

        return shopDao.getAllShopObject(begin, RecordCount, name, isSore, beginDate, endDate);
    }

    public int getAllShopsCount(String name, int isSore, String beginDate,
                                String endDate) {
        // TODO Auto-generated method stub
        return shopDao.getAllShopsCount(name, isSore, beginDate, endDate);
    }

    //	public List<String> userTelephones(List<Shop> shops) {
//
//		return shopDao.userTelephones(shops);
//	}
//
    public List<searchShop> getAllShopObjectbyShopBuyType(int begin,
                                                          int RecordCount, String shopBuyType) {

        return shopDao.getAllShopObjectbyShopBuyType(begin, RecordCount, shopBuyType);
    }

    public int getAllShopsCountByShopBuyType(String shopBuyType) {

        return shopDao.getAllShopsCountByShopBuyType(shopBuyType);
    }
//


}
