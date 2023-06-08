package com.shop.entity;


import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Repository
public class User implements java.io.Serializable {

    private Integer id;
    private int version;
    private String userName;
    private String userPassword;
    private String callName;
    private String email;
    private String qq;
    private Integer sex;
    private String identityld;
    private String realName;
    private String telephone;
    private String shortNumber;
    private Date createDate;
    private Integer sysRole;
    private Integer userType;
    private Integer age;
    private String grade;
    private Integer tag;
    private String createDateStr;
    private Shop shop;
    private Set tradeRecords = new HashSet(0);
    private Set dailies = new HashSet(0);
    private Set goodsOrders = new HashSet(0);
    private Set codeActives = new HashSet(0);
    private Set collectionGoodses = new HashSet(0);
    private Set businessAddresses = new HashSet(0);
    private Set goodses = new HashSet(0);
    private Set collectionShops = new HashSet(0);
    private Set friendlinks = new HashSet(0);
    private Set studentAddresses = new HashSet(0);
    private Set messages = new HashSet(0);
    private Set complaints = new HashSet(0);
    private Set stationAnnouces = new HashSet(0);

    public User() {
    }

    public User(Integer id, int version, String userName, String userPassword, String callName, String email, String qq, Integer sex, String identityld, String realName, String telephone, String shortNumber, Date createDate, Integer sysRole, Integer userType, Integer tag, Integer age, String grade) {
        this.id = id;
        this.version = version;
        this.userName = userName;
        this.userPassword = userPassword;
        this.callName = callName;
        this.email = email;
        this.qq = qq;
        this.sex = sex;
        this.identityld = identityld;
        this.realName = realName;
        this.telephone = telephone;
        this.shortNumber = shortNumber;
        this.createDate = createDate;
        this.sysRole = sysRole;
        this.userType = userType;
        this.tag = tag;
        this.age = age;
        this.grade = grade;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getCreateDateStr() {
        return createDateStr;
    }

    public void setCreateDateStr(String createDateStr) {
        this.createDateStr = createDateStr;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public String getUserName() {
        return this.userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return this.userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQq() {
        return this.qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public Integer getSex() {
        return this.sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public String getIdentityld() {
        return this.identityld;
    }

    public void setIdentityld(String identityld) {
        this.identityld = identityld;
    }

    public String getCallName() {
        return callName;
    }

    public void setCallName(String callName) {
        this.callName = callName;
    }

    public String getRealName() {
        return this.realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getTelephone() {
        return this.telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getShortNumber() {
        return this.shortNumber;
    }

    public void setShortNumber(String shortNumber) {
        this.shortNumber = shortNumber;
    }

    public Integer getSysRole() {
        return this.sysRole;
    }

    public void setSysRole(Integer sysRole) {
        this.sysRole = sysRole;
    }

    public Integer getUserType() {
        return this.userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public Integer getTag() {
        return this.tag;
    }

    public void setTag(Integer tag) {
        this.tag = tag;
    }

    public Set getTradeRecords() {
        return this.tradeRecords;
    }

    public void setTradeRecords(Set tradeRecords) {
        this.tradeRecords = tradeRecords;
    }

    public Set getDailies() {
        return this.dailies;
    }

    public void setDailies(Set dailies) {
        this.dailies = dailies;
    }

    public Set getGoodsOrders() {
        return this.goodsOrders;
    }

    public void setGoodsOrders(Set goodsOrders) {
        this.goodsOrders = goodsOrders;
    }

    public Set getCodeActives() {
        return this.codeActives;
    }

    public void setCodeActives(Set codeActives) {
        this.codeActives = codeActives;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Set getCollectionGoodses() {
        return this.collectionGoodses;
    }

    public void setCollectionGoodses(Set collectionGoodses) {
        this.collectionGoodses = collectionGoodses;
    }

    public Set getBusinessAddresses() {
        return this.businessAddresses;
    }

    public void setBusinessAddresses(Set businessAddresses) {
        this.businessAddresses = businessAddresses;
    }

    public Set getGoodses() {
        return this.goodses;
    }

    public void setGoodses(Set goodses) {
        this.goodses = goodses;
    }

    public Set getCollectionShops() {
        return this.collectionShops;
    }

    public void setCollectionShops(Set collectionShops) {
        this.collectionShops = collectionShops;
    }

    public Set getFriendlinks() {
        return this.friendlinks;
    }

    public void setFriendlinks(Set friendlinks) {
        this.friendlinks = friendlinks;
    }

    public Set getStudentAddresses() {
        return this.studentAddresses;
    }

    public void setStudentAddresses(Set studentAddresses) {
        this.studentAddresses = studentAddresses;
    }

    public Set getMessages() {
        return this.messages;
    }

    public void setMessages(Set messages) {
        this.messages = messages;
    }

    public Set getComplaints() {
        return this.complaints;
    }

    public void setComplaints(Set complaints) {
        this.complaints = complaints;
    }


    public Set getStationAnnouces() {
        return this.stationAnnouces;
    }

    public void setStationAnnouces(Set stationAnnouces) {
        this.stationAnnouces = stationAnnouces;
    }


}