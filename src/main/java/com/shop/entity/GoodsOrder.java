package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class GoodsOrder implements java.io.Serializable {

    private Integer id;
    private Integer userId;
    private String OrderNum;
    private Integer goodId;
    private Integer amount;
    private String total;
    private String TradeTime;
    private Integer state;
    private Integer tag;
    private User user;

    private Goods good;

    public GoodsOrder() {
    }

    public GoodsOrder(Integer id, Integer userId, String OrderNum, Integer goodId, Integer amount, String total, String TradeTime, Integer state, Integer tag) {
        this.id = id;
        this.userId = userId;
        this.OrderNum = OrderNum;
        this.goodId = goodId;
        this.amount = amount;
        this.total = total;
        this.TradeTime = TradeTime;
        this.state = state;
        this.tag = tag;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGoodId() {
        return goodId;
    }

    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
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

    public String getOrderNum() {
        return this.OrderNum;
    }

    public void setOrderNum(String OrderNum) {
        this.OrderNum = OrderNum;
    }


    public Goods getGood() {
        return good;
    }

    public void setGood(Goods good) {
        this.good = good;
    }

    public String getTradeTime() {
        return this.TradeTime;
    }

    public void setTradeTime(String TradeTime) {
        this.TradeTime = TradeTime;
    }

    public Integer getState() {
        return this.state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }


}