package com.shop.entity;

import org.springframework.stereotype.Repository;

import java.util.HashSet;
import java.util.Set;

@Repository
public class Complaint implements java.io.Serializable {

    private Integer id;
    private Integer tradeId;
    private Integer userId;
    private Integer complaintId;
    private String complain;
    private String detailreason;
    private String complaintTime;
    private Integer adminReply;
    private Integer alertType;
    private Integer tag;
    private Set complaintReplies = new HashSet(0);
    private TradeRecord tradeRecord;
    private User user;
    private User complaint;

    public Complaint(Integer id, Integer tradeId, Integer userId, Integer complaintId, String complain, String detailreason, String complaintTime, Integer adminReply, Integer alertType, Integer tag) {
        this.id = id;
        this.tradeId = tradeId;
        this.userId = userId;
        this.complaintId = complaintId;
        this.complain = complain;
        this.detailreason = detailreason;
        this.complaintTime = complaintTime;
        this.adminReply = adminReply;
        this.alertType = alertType;
        this.tag = tag;
    }

    public Complaint() {
    }

    public Integer getTradeId() {
        return tradeId;
    }

    public void setTradeId(Integer tradeId) {
        this.tradeId = tradeId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(Integer complaintId) {
        this.complaintId = complaintId;
    }

    public User getComplaint() {
        return complaint;
    }

    public void setComplaint(User complaint) {
        this.complaint = complaint;
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

    public String getComplain() {
        return this.complain;
    }

    public void setComplain(String complain) {
        this.complain = complain;
    }

    public String getDetailreason() {
        return this.detailreason;
    }

    public void setDetailreason(String detailreason) {
        this.detailreason = detailreason;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public Set getComplaintReplies() {
        return this.complaintReplies;
    }

    public void setComplaintReplies(Set complaintReplies) {
        this.complaintReplies = complaintReplies;
    }

    public String getComplaintTime() {
        return complaintTime;
    }

    public void setComplaintTime(String complaintTime) {
        this.complaintTime = complaintTime;
    }

    public Integer getAdminReply() {
        return adminReply;
    }

    public void setAdminReply(Integer adminReply) {
        this.adminReply = adminReply;
    }

    public TradeRecord getTradeRecord() {
        return tradeRecord;
    }

    public void setTradeRecord(TradeRecord tradeRecord) {
        this.tradeRecord = tradeRecord;
    }

    public Integer getAlertType() {
        return alertType;
    }

    public void setAlertType(Integer alertType) {
        this.alertType = alertType;
    }

}