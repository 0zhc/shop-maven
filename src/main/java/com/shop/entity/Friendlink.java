package com.shop.entity;

import java.util.Date;

public class Friendlink implements java.io.Serializable {

    private Integer id;
    private Integer shopId;
    private String urlText;
    private String url;
    private Date inTime;
    private Integer tag;

    private User user;

    public Friendlink() {
    }

    public Friendlink(Integer id, Integer shopId, String urlText, String url, Date inTime, Integer tag) {
        this.id = id;
        this.shopId = shopId;
        this.urlText = urlText;
        this.url = url;
        this.inTime = inTime;
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

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUrl() {
        return this.url;
    }

    public void setUrl(String url) {
        this.url = url;
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

    public String getUrlText() {
        return urlText;
    }

    public void setUrlText(String urlText) {
        this.urlText = urlText;
    }

}