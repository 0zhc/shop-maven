package com.shop.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class Shop implements java.io.Serializable {


    private Integer id;
    private Integer userId;
    private User user;
    private String name;
    private String shopBigAddress;
    private String shopDetailAddress;
    private String url;
    private String logoUrl;
    private String bannerUrl;
    private String shopBuyType;
    private String shopInfo;
    private String deliverScope;
    private String secureShop;
    private String contactUs;
    private Date createDate;
    private Integer template;
    private Integer tag;
    private Integer isShowHot;
    private Integer isShowNew;
    private Integer isShowSecond;
    private String otherText;
    private Integer isModify;
    private Set shopAnnouces = new HashSet(0);
    private Set goodses = new HashSet(0);

    public Shop(Integer id, Integer userId, String name, String logoUrl, String shopBuyType, String shopInfo, Date createDate) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.logoUrl = logoUrl;
        this.shopBuyType = shopBuyType;
        this.shopInfo = shopInfo;
        this.createDate = createDate;
    }

    public Shop(Integer id, Integer userId, User user, String name, String shopBigAddress, String shopDetailAddress, String url, String logoUrl, String bannerUrl, String shopBuyType, String shopInfo, String deliverScope, String secureShop, String contactUs, Date createDate, Integer template, Integer tag, Integer isShowHot, Integer isShowNew, Integer isShowSecond, String otherText, Integer isModify, Set shopAnnouces, Set goodses) {
        this.id = id;
        this.userId = userId;
        this.user = user;
        this.name = name;
        this.shopBigAddress = shopBigAddress;
        this.shopDetailAddress = shopDetailAddress;
        this.url = url;
        this.logoUrl = logoUrl;
        this.bannerUrl = bannerUrl;
        this.shopBuyType = shopBuyType;
        this.shopInfo = shopInfo;
        this.deliverScope = deliverScope;
        this.secureShop = secureShop;
        this.contactUs = contactUs;
        this.createDate = createDate;
        this.template = template;
        this.tag = tag;
        this.isShowHot = isShowHot;
        this.isShowNew = isShowNew;
        this.isShowSecond = isShowSecond;
        this.otherText = otherText;
        this.isModify = isModify;
        this.shopAnnouces = shopAnnouces;
        this.goodses = goodses;
    }

    public Shop() {
    }

    public Shop(Integer id, User user, String name, String shopBigAddress, String shopDetailAddress, String url, String logoUrl, String bannerUrl, String shopBuyType, String shopInfo, String deliverScope, String secureShop, String contactUs, Date createDate, Integer template, Integer tag, Integer isShowHot, Integer isShowNew, Integer isShowSecond, String otherText, Integer isModify, Set shopAnnouces, Set goodses) {
        this.id = id;
        this.user = user;
        this.name = name;
        this.shopBigAddress = shopBigAddress;
        this.shopDetailAddress = shopDetailAddress;
        this.url = url;
        this.logoUrl = logoUrl;
        this.bannerUrl = bannerUrl;
        this.shopBuyType = shopBuyType;
        this.shopInfo = shopInfo;
        this.deliverScope = deliverScope;
        this.secureShop = secureShop;
        this.contactUs = contactUs;
        this.createDate = createDate;
        this.template = template;
        this.tag = tag;
        this.isShowHot = isShowHot;
        this.isShowNew = isShowNew;
        this.isShowSecond = isShowSecond;
        this.otherText = otherText;
        this.isModify = isModify;
        this.shopAnnouces = shopAnnouces;
        this.goodses = goodses;
    }


    public Shop(User user, String name, String url, String shopBuyType,
                String contactUs, Date createDate, Integer template) {
        this.user = user;
        this.name = name;
        this.url = url;
        this.shopBuyType = shopBuyType;
        this.contactUs = contactUs;
        this.createDate = createDate;
        this.template = template;
    }

    public Shop(User user, String name, String url, String logoUrl,
                String shopBuyType, String shopInfo, String deliverScope,
                String secureShop, String contactUs, Date createDate,
                Integer template, Integer tag, Set shopAnnouces) {
        this.user = user;
        this.name = name;
        this.url = url;
        this.logoUrl = logoUrl;
        this.shopBuyType = shopBuyType;
        this.shopInfo = shopInfo;
        this.deliverScope = deliverScope;
        this.secureShop = secureShop;
        this.contactUs = contactUs;
        this.createDate = createDate;
        this.template = template;
        this.tag = tag;
        this.shopAnnouces = shopAnnouces;

    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Set getGoodses() {
        return goodses;
    }

    public void setGoodses(Set goodses) {
        this.goodses = goodses;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getUrl() {
        return this.url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLogoUrl() {
        return this.logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getShopBuyType() {
        return this.shopBuyType;
    }

    public void setShopBuyType(String shopBuyType) {
        this.shopBuyType = shopBuyType;
    }

    public String getShopInfo() {
        return this.shopInfo;
    }

    public void setShopInfo(String shopInfo) {
        this.shopInfo = shopInfo;
    }

    public String getDeliverScope() {
        return this.deliverScope;
    }

    public void setDeliverScope(String deliverScope) {
        this.deliverScope = deliverScope;
    }

    public String getSecureShop() {
        return this.secureShop;
    }

    public void setSecureShop(String secureShop) {
        this.secureShop = secureShop;
    }

    public String getContactUs() {
        return this.contactUs;
    }

    public void setContactUs(String contactUs) {
        this.contactUs = contactUs;
    }

    public Date getCreateDate() {
        return this.createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getTemplate() {
        return this.template;
    }

    public void setTemplate(Integer template) {
        this.template = template;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public Set getShopAnnouces() {
        return this.shopAnnouces;
    }

    public void setShopAnnouces(Set shopAnnouces) {
        this.shopAnnouces = shopAnnouces;
    }


    public String getBannerUrl() {
        return bannerUrl;
    }

    public void setBannerUrl(String bannerUrl) {
        this.bannerUrl = bannerUrl;
    }

    public Integer getIsShowHot() {
        return isShowHot;
    }

    public void setIsShowHot(Integer isShowHot) {
        this.isShowHot = isShowHot;
    }

    public Integer getIsShowNew() {
        return isShowNew;
    }

    public void setIsShowNew(Integer isShowNew) {
        this.isShowNew = isShowNew;
    }

    public Integer getIsShowSecond() {
        return isShowSecond;
    }

    public void setIsShowSecond(Integer isShowSecond) {
        this.isShowSecond = isShowSecond;
    }

    public String getOtherText() {
        return otherText;
    }

    public void setOtherText(String otherText) {
        this.otherText = otherText;
    }

    public Integer getIsModify() {
        return isModify;
    }

    public void setIsModify(Integer isModify) {
        this.isModify = isModify;
    }

}