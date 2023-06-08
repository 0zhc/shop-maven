package com.shop.entity;

public class ShopEvaluation implements java.io.Serializable {


    private Integer id;
    private Integer shopId;
    private String authorName;
    private String content;
    private String createDate;
    private Integer tag;
    private Shop shop;

    public ShopEvaluation() {
    }


    public ShopEvaluation(Integer id, Integer shopId, String authorName, String content, String createDate, Integer tag) {
        this.id = id;
        this.shopId = shopId;
        this.authorName = authorName;
        this.content = content;
        this.createDate = createDate;
        this.tag = tag;
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

    public String getAuthorName() {
        return this.authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreateDate() {
        return this.createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }


}