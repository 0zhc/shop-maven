package com.shop.utils.pageUtil;

public class Page {
    private int total;
    private int everyPage;
    private int num;
    private int currentPage;
    private int beginIndex;
    private boolean hasPrePage;
    private boolean hasNextPage;

    public Page() {
    }

    public Page(int total, int everyPage, int currentpage) {
        setTotal(total);
        setEveryPage(everyPage);
        setNum(getNum());
        setCurrentPage(currentpage);
        setBeginIndex(getBeginIndex());
        this.hasNextPage = isHasNextPage();
        this.hasPrePage = isHasPrePage();
    }

    public int getTotal() {
        return this.total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getEveryPage() {
        return this.everyPage;
    }

    public void setEveryPage(int page) {
        if (page <= 0) {
            this.everyPage = 10;
        } else {
            this.everyPage = page;
        }
    }

    public int getNum() {
        if (total % everyPage == 0) {
            return num = total / everyPage;
        } else {
            return num = total / everyPage + 1;
        }
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getCurrentPage() {
        return this.currentPage;
    }

    public void setCurrentPage(int currentPage) {
        if (currentPage > 0 && currentPage < num + 1) {
            this.currentPage = currentPage;
        } else if (currentPage <= 0) {
            this.currentPage = 1;
        } else {
            if (num == 0) {
                this.currentPage = 1;
            } else {
                this.currentPage = num;
            }

        }
    }

    public int getBeginIndex() {
        return (currentPage - 1) * everyPage;
    }

    public void setBeginIndex(int begin) {
        this.beginIndex = begin;
    }

    public boolean isHasNextPage() {
        return currentPage == num || currentPage > num ? false : true;
    }

    public boolean isHasPrePage() {
        return currentPage == 1 || currentPage < 1 ? false : true;
    }

    public void next() {
        if (this.isHasNextPage()) {
            this.currentPage = this.currentPage + 1;
        } else {
            this.currentPage = num;
        }
    }

    public void previ() {
        if (this.isHasPrePage()) {
            this.currentPage = this.currentPage - 1;
        } else {
            this.currentPage = 1;
        }
    }

}
