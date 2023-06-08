package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class ReceiveAddress implements java.io.Serializable {

    private Integer id;
    private Integer orderId;
    private String receiverName;
    private String address;
    private String phone;
    private String shortPhone;
    private Integer tag;
    private GoodsOrder goodsOrder;

    public ReceiveAddress() {
    }

    public ReceiveAddress(Integer id, Integer orderId, String receiverName, String address, String phone, String shortPhone, Integer tag) {
        this.id = id;
        this.orderId = orderId;
        this.receiverName = receiverName;
        this.address = address;
        this.phone = phone;
        this.shortPhone = shortPhone;
        this.tag = tag;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public GoodsOrder getGoodsOrder() {
        return this.goodsOrder;
    }

    public void setGoodsOrder(GoodsOrder goodsOrder) {
        this.goodsOrder = goodsOrder;
    }

    public String getReceiverName() {
        return this.receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getShortPhone() {
        return this.shortPhone;
    }

    public void setShortPhone(String shortPhone) {
        this.shortPhone = shortPhone;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

}