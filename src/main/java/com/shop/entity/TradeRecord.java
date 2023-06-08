package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class TradeRecord implements java.io.Serializable {


    private Integer id;
    private Integer userId;
    private Integer goodsId;
    private Integer goodsOrderId;
    private Integer buyerId;
    private String tradeTime;
    private Integer preRightsId;
    private Integer isBuy;
    private Integer tag;
    private User buyer;
    private GoodsOrder goodsOrder;
    private Goods goods;
    private User user;

    public TradeRecord(Integer id, Integer userId, Integer goodsId, Integer goodsOrderId, Integer buyerId, String tradeTime, Integer preRightsId, Integer isBuy, Integer tag) {
        this.id = id;
        this.userId = userId;
        this.goodsId = goodsId;
        this.goodsOrderId = goodsOrderId;
        this.buyerId = buyerId;
        this.tradeTime = tradeTime;
        this.preRightsId = preRightsId;
        this.isBuy = isBuy;
        this.tag = tag;
    }


    public TradeRecord() {
    }

    public Integer getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(Integer buyerId) {
        this.buyerId = buyerId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Integer getGoodsOrderId() {
        return goodsOrderId;
    }

    public void setGoodsOrderId(Integer goodsOrderId) {
        this.goodsOrderId = goodsOrderId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGoodOrderId() {
        return goodsOrderId;
    }

    public void setGoodOrderId(Integer goodOrderId) {
        this.goodsOrderId = goodOrderId;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
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


    public GoodsOrder getGoodsOrder() {
        return goodsOrder;
    }

    public void setGoodsOrder(GoodsOrder goodsOrder) {
        this.goodsOrder = goodsOrder;
    }

    public String getTradeTime() {
        return this.tradeTime;
    }

    public void setTradeTime(String tradeTime) {
        this.tradeTime = tradeTime;
    }

    public Integer getPreRightsId() {
        return this.preRightsId;
    }

    public void setPreRightsId(Integer preRightsId) {
        this.preRightsId = preRightsId;
    }

    public Integer getIsBuy() {
        return this.isBuy;
    }

    public void setIsBuy(Integer isBuy) {
        this.isBuy = isBuy;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }


    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

}