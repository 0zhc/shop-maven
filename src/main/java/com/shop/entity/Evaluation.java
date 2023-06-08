package com.shop.entity;

import org.springframework.stereotype.Repository;

@Repository
public class Evaluation implements java.io.Serializable {


    private Integer id;
    private Integer goodsId;
    private String authorName;
    private String content;
    private String createDate;
    private Integer tag;
    private Goods goods;

    public Evaluation(Integer id, Integer goodsId, String authorName, String content, String createDate, Integer tag) {
        this.id = id;
        this.goodsId = goodsId;
        this.authorName = authorName;
        this.content = content;
        this.createDate = createDate;
        this.tag = tag;
    }

    public Evaluation() {
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Goods getGoods() {
        return this.goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
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