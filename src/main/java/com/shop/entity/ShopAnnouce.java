package com.shop.entity;

import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class ShopAnnouce implements java.io.Serializable {

    private Integer id;
    private Integer shopId;

    private String title;
    private String content;
    private Date inTime;
    private Integer tag;
    private Shop shop;

    public ShopAnnouce() {
    }

    public ShopAnnouce(Integer id, Integer shopId, String title, String content, Date inTime, Integer tag) {
        this.id = id;
        this.shopId = shopId;
        this.title = title;
        this.content = content;
        this.inTime = inTime;
        this.tag = tag;
    }

    public ShopAnnouce(Shop shop) {
        this.shop = shop;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Shop getShop() {
        return this.shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getInTime() {
        return this.inTime;
    }

    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

}