package com.shop.entity;

import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class CollectionShop implements java.io.Serializable {

    private Integer id;
    private Integer userId;
    private Integer shopsId;
    private Date storeDate;
    private Integer tag;
    private User user;
    private Shop shops;

    public CollectionShop(Integer id, Integer userId, Integer shopsId, Date storeDate, Integer tag) {
        this.id = id;
        this.userId = userId;
        this.shopsId = shopsId;
        this.storeDate = storeDate;
        this.tag = tag;
    }

    public CollectionShop() {
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getShopsId() {
        return shopsId;
    }

    public void setShopsId(Integer shopsId) {
        this.shopsId = shopsId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Shop getShops() {
        return shops;
    }

    public void setShops(Shop shops) {
        this.shops = shops;
    }

    public Date getStoreDate() {
        return storeDate;
    }

    public void setStoreDate(Date storeDate) {
        this.storeDate = storeDate;
    }

    public Integer getTag() {
        return tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }


}