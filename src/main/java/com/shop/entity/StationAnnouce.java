package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class StationAnnouce implements java.io.Serializable {


    private Integer id;
    private Integer userId;
    private String title;
    private String content;
    private String inTime;
    private Integer state;
    private Integer tag;
    private User user;

    public StationAnnouce(Integer id, Integer userId, String title, String content, String inTime, Integer state, Integer tag) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.inTime = inTime;
        this.state = state;
        this.tag = tag;
    }

    public StationAnnouce() {
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

    public String getInTime() {
        return this.inTime;
    }

    public void setInTime(String inTime) {
        this.inTime = inTime;
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

}