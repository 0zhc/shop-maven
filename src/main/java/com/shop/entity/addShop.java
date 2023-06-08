package com.shop.entity;


/**
 * Shop entity. @author MyEclipse Persistence Tools
 */

public class addShop implements java.io.Serializable {

    // Fields
    private String name;
    private String shopBuyType;
    private String shopBigAddress;
    private String shopDetailAddress;
    private String shopInfo;
    private Integer template;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShopBuyType() {
        return shopBuyType;
    }

    public void setShopBuyType(String shopBuyType) {
        this.shopBuyType = shopBuyType;
    }

    public String getShopBigAddress() {
        return shopBigAddress;
    }

    public void setShopBigAddress(String shopBigAddress) {
        this.shopBigAddress = shopBigAddress;
    }

    public String getShopDetailAddress() {
        return shopDetailAddress;
    }

    public void setShopDetailAddress(String shopDetailAddress) {
        this.shopDetailAddress = shopDetailAddress;
    }

    public String getShopInfo() {
        return shopInfo;
    }

    public void setShopInfo(String shopInfo) {
        this.shopInfo = shopInfo;
    }

    public Integer getTemplate() {
        return template;
    }

    public void setTemplate(Integer template) {
        this.template = template;
    }
}