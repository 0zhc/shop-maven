package com.shop.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class Goods implements java.io.Serializable {

    private Integer id;
    private Integer shopId;
    private Shop shop;
    private String name;
    private String description;
    private String commQuality;
    private String goodsUrl;
    private String productAdd;
    private String color;
    private String weight;
    private String brand;
    private String size;
    private float price;
    private Integer amount;
    private String origin;
    private String sizeUnit;
    private String grossUnit;
    private String amountUnit;
    private Date createDate;
    private Integer goodsType;
    private int goodsIsNew;
    private String url;
    private Integer tag;
    private Set messages = new HashSet(0);
    private Set collectionShops = new HashSet(0);
    private Set tradeRecords = new HashSet(0);
    private Set collectionGoodses = new HashSet(0);

    public Goods() {
    }

    public Goods(Integer id, Integer shopId, String name, String description, String commQuality, String goodsUrl, String productAdd, String color, String weight, String brand, String size, float price, Integer amount, String origin, String sizeUnit, String grossUnit, String amountUnit, Date createDate, Integer goodsType, int goodsIsNew, String url, Integer tag) {
        this.id = id;
        this.shopId = shopId;
        this.name = name;
        this.description = description;
        this.commQuality = commQuality;
        this.goodsUrl = goodsUrl;
        this.productAdd = productAdd;
        this.color = color;
        this.weight = weight;
        this.brand = brand;
        this.size = size;
        this.price = price;
        this.amount = amount;
        this.origin = origin;
        this.sizeUnit = sizeUnit;
        this.grossUnit = grossUnit;
        this.amountUnit = amountUnit;
        this.createDate = createDate;
        this.goodsType = goodsType;
        this.goodsIsNew = goodsIsNew;
        this.url = url;
        this.tag = tag;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCommQuality() {
        return commQuality;
    }

    public void setCommQuality(String commQuality) {
        this.commQuality = commQuality;
    }

    public String getGoodsUrl() {
        return goodsUrl;
    }

    public void setGoodsUrl(String goodsUrl) {
        this.goodsUrl = goodsUrl;
    }

    public String getProductAdd() {
        return productAdd;
    }

    public void setProductAdd(String productAdd) {
        this.productAdd = productAdd;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getSizeUnit() {
        return sizeUnit;
    }

    public void setSizeUnit(String sizeUnit) {
        this.sizeUnit = sizeUnit;
    }

    public String getGrossUnit() {
        return grossUnit;
    }

    public void setGrossUnit(String grossUnit) {
        this.grossUnit = grossUnit;
    }

    public String getAmountUnit() {
        return amountUnit;
    }

    public void setAmountUnit(String amountUnit) {
        this.amountUnit = amountUnit;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(Integer goodsType) {
        this.goodsType = goodsType;
    }

    public int getGoodsIsNew() {
        return goodsIsNew;
    }

    public void setGoodsIsNew(int goodsIsNew) {
        this.goodsIsNew = goodsIsNew;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getTag() {
        return tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public Set getMessages() {
        return messages;
    }

    public void setMessages(Set messages) {
        this.messages = messages;
    }

    public Set getCollectionShops() {
        return collectionShops;
    }

    public void setCollectionShops(Set collectionShops) {
        this.collectionShops = collectionShops;
    }

    public Set getTradeRecords() {
        return tradeRecords;
    }

    public void setTradeRecords(Set tradeRecords) {
        this.tradeRecords = tradeRecords;
    }

    public Set getCollectionGoodses() {
        return collectionGoodses;
    }

    public void setCollectionGoodses(Set collectionGoodses) {
        this.collectionGoodses = collectionGoodses;
    }


}