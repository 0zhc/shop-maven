package com.shop.utils;

public class PageEvaluation {

    private Integer totalRecord;
    private Integer totalPage;
    private Integer everyPageRecord;
    private Integer currentPage;
    private Boolean hasPrevPage;
    private Boolean hasNextPage;

    public PageEvaluation(Integer totalRecord, Integer everyPageRecord,
                          Integer currentPage) {
        Integer totalPage = totalRecord / everyPageRecord;
        if (totalRecord % everyPageRecord != 0) {
            totalPage++;
        }
        this.totalPage = totalPage;
        this.totalRecord = totalRecord;
        this.everyPageRecord = everyPageRecord;
        this.currentPage = currentPage;
        this.hasPrevPage = currentPage > 1 ? true : false;
        this.hasNextPage = currentPage < this.totalPage ? true : false;
    }

    public Integer getTotalRecord() {
        return totalRecord;
    }

    public void setTotalRecord(Integer totalRecord) {
        this.totalRecord = totalRecord;
    }

    public Integer getTotalPage() {
        Integer totalPage = totalRecord / everyPageRecord;
        if (totalRecord % everyPageRecord != 0) {
            totalPage++;
        }
        return totalPage;
    }

    public Integer getEveryPageRecord() {
        return everyPageRecord;
    }

    public void setEveryPageRecord(Integer everyPageRecord) {
        this.everyPageRecord = everyPageRecord;
    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Boolean getHasPrevPage() {
        return hasPrevPage;
    }

    public void setHasPrevPage(Boolean hasPrevPage) {
        hasPrevPage = currentPage > 1 ? true : false;

    }

    public Boolean getHasNextPage() {
        return hasNextPage;
    }

    public void setHasNextPage(Boolean hasNextPage) {
        hasNextPage = currentPage < totalPage ? true : false;
    }


}
