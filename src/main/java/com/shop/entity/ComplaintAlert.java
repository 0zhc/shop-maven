package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class ComplaintAlert implements java.io.Serializable {

    private Integer id;
    private Integer PreRightId;
    private Integer userId;
    private String title;
    private String alertContent;
    private String alertTime;
    private Integer tag;
    private Complaint complaint;
    private User user;

    public ComplaintAlert() {
    }

    public ComplaintAlert(Integer id, Integer preRightId, Integer userId, String title, String alertContent, String alertTime, Integer tag) {
        this.id = id;
        PreRightId = preRightId;
        this.userId = userId;
        this.title = title;
        this.alertContent = alertContent;
        this.alertTime = alertTime;
        this.tag = tag;
    }

    public Integer getPreRightId() {
        return PreRightId;
    }

    public void setPreRightId(Integer preRightId) {
        PreRightId = preRightId;
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

    public Complaint getComplaint() {
        return this.complaint;
    }

    public void setComplaint(Complaint complaint) {
        this.complaint = complaint;
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

    public String getAlertContent() {
        return this.alertContent;
    }

    public void setAlertContent(String alertContent) {
        this.alertContent = alertContent;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public String getAlertTime() {
        return alertTime;
    }

    public void setAlertTime(String alertTime) {
        this.alertTime = alertTime;
    }

}