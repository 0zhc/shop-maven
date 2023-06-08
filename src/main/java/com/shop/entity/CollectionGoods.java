package com.shop.entity;

import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class CollectionGoods implements java.io.Serializable {

    private Integer id;
    private Integer userId;
    private Integer goodsId;
    private Date storeDate;
    private Integer tag;

    private User user;
    private Goods goods;

    public CollectionGoods() {
    }

    public CollectionGoods(Integer id, Integer userId, Integer goodsId, Date storeDate, Integer tag) {
        this.id = id;
        this.userId = userId;
        this.goodsId = goodsId;
        this.storeDate = storeDate;
        this.tag = tag;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
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

    public Goods getGoods() {
        return this.goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public Date getStoreDate() {
        return this.storeDate;
    }

    public void setStoreDate(Date storeDate) {
        this.storeDate = storeDate;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

}