package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class CodeActive implements java.io.Serializable {

    private Integer id;
    private Integer businessId;
    private String active;
    private Integer isActive;
    private Integer type;
    private User user;

    public CodeActive() {
    }

    public CodeActive(Integer id, Integer businessId, String active, Integer isActive, Integer type) {
        this.id = id;
        this.businessId = businessId;
        this.active = active;
        this.isActive = isActive;
        this.type = type;
    }

    public Integer getBusinessId() {
        return businessId;
    }

    public void setBusinessId(Integer businessId) {
        this.businessId = businessId;
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

    public String getActive() {
        return this.active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public Integer getIsActive() {
        return this.isActive;
    }

    public void setIsActive(Integer isActive) {
        this.isActive = isActive;
    }

    public Integer getType() {
        return this.type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

}