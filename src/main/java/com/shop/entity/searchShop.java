package com.shop.entity;

public class searchShop {
    String logoUrl;
    String shopInfo;
    String name;
    String qq;
    String shopBigAddress;
    String shopDetailAddress;
    String createDate;
    Integer id;

    public searchShop() {
    }

    public searchShop(String logoUrl, String shopInfo, String name, String qq, String shopBigAddress, String shopDetailAddress, String createDate, Integer id) {
        this.logoUrl = logoUrl;
        this.shopInfo = shopInfo;
        this.name = name;
        this.qq = qq;
        this.shopBigAddress = shopBigAddress;
        this.shopDetailAddress = shopDetailAddress;
        this.createDate = createDate;
        this.id = id;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getShopInfo() {
        return shopInfo;
    }

    public void setShopInfo(String shopInfo) {
        this.shopInfo = shopInfo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    @Override
    public String toString() {
        return "searchShop{" +
                "logoUrl='" + logoUrl + '\'' +
                ", shopInfo='" + shopInfo + '\'' +
                ", name='" + name + '\'' +
                ", qq='" + qq + '\'' +
                ", shopBigAddress='" + shopBigAddress + '\'' +
                ", shopDetailAddress='" + shopDetailAddress + '\'' +
                ", createDate='" + createDate + '\'' +
                ", id=" + id +
                '}';
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

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
