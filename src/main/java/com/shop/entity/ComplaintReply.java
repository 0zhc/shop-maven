package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class ComplaintReply implements java.io.Serializable {


    private Integer id;
    private Integer PreRightId;
    private Integer writerId;
    private String replyContent;
    private String replyTime;
    private Integer replyType;
    private Integer tag;
    private Complaint complaint;
    private User writer;

    public ComplaintReply() {
    }

    public ComplaintReply(Integer id, Integer preRightId, Integer writerId, String replyContent, String replyTime, Integer replyType, Integer tag) {
        this.id = id;
        this.PreRightId = preRightId;
        this.writerId = writerId;
        this.replyContent = replyContent;
        this.replyTime = replyTime;
        this.replyType = replyType;
        this.tag = tag;
    }

    public Integer getPreRightId() {
        return PreRightId;
    }

    public void setPreRightId(Integer preRightId) {
        PreRightId = preRightId;
    }

    public Integer getWriterId() {
        return writerId;
    }

    public void setWriterId(Integer writerId) {
        this.writerId = writerId;
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

    public String getReplyContent() {
        return this.replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public User getWriter() {
        return writer;
    }

    public void setWriter(User writer) {
        this.writer = writer;
    }

    public String getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

    public Integer getReplyType() {
        return replyType;
    }

    public void setReplyType(Integer replyType) {
        this.replyType = replyType;
    }

}