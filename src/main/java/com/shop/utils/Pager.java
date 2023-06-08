package com.shop.utils;

public class Pager {

    private int totalRecords;//	总记录数

    private int everyPageRecords;//	每页记录数

    private int totalPages;//	总页数

    private int currentPage;//	当前页数

    private int beginIndexRecord;//	从第几条记录开始

    private boolean hasPrePage;//	是否有上一页

    private boolean hasNextPage;//	是否有下一页
    private int currentPageStart;//因为显示页码的数量是动态变化的，假如总共有一百页，则不可能同时显示100个链接。而是根据当前的页数显示
    private int currentPageEnd;//一定数量的页面链接

    public Pager() {
    }

    public Pager(int totalRecords, int everyPageRecords, int currentpage) {
        setTotalRecords(totalRecords);//设置总记录数
        setEveryPageRecords(everyPageRecords);//设置每一页的显示多少条记录
        setTotalPages(getTotalPages());//设置有多少页
        setCurrentPage(currentpage);//设置当前页码数
        setBeginIndexRecord(getBeginIndexRecord());//设置从哪条纪录开始取
        this.hasNextPage = isHasNextPage();//设置是否有下一条记录
        this.hasPrePage = isHasPrePage();//设置是否有上一条记录
        setCurrentPageStartOrEnd();
        setCurrentPageStart(getCurrentPageStart());
        setCurrentPageEnd(getCurrentPageEnd());
    }

    public int getTotalRecords() {
        return this.totalRecords;//得到总的记录数
    }

    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;//设置总的记录数
    }

    public int getEveryPageRecords() {
        return this.everyPageRecords;//得到每一页的显示多少条记录
    }

    public void setEveryPageRecords(int everyPageRecords) {
        if (everyPageRecords <= 0) {//判断传来的每页记录数是否小于或等于零
            this.everyPageRecords = 6;//设置默认每页记录数为10条记录
        } else {
            this.everyPageRecords = everyPageRecords;//否则，设置当前页为传来的记录数。
        }
    }

    public int getTotalPages() {
        if (totalRecords % everyPageRecords == 0) {//判断总的记录是否被每页的记录数整除
            return totalPages = totalRecords / everyPageRecords;//设置整除的的总页数
        } else {
            return totalPages = totalRecords / everyPageRecords + 1;//设置不能整除的总页数
        }
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;//设置总的页数
    }

    public int getCurrentPage() {
        return this.currentPage;//得到当前页码数
    }

    public void setCurrentPage(int currentPage) {
        if (currentPage > 0 && currentPage < totalPages + 1) {//判断当前页码数是否大于零 而且当前的页码数是否在总页数+1 之内，注意，可以等于总的页码数，及最后页码数。
            this.currentPage = currentPage;//设置当前页码数
        } else if (currentPage <= 0) {//假如小于1，则没有上一页了
            this.currentPage = 1;//设置为最前一页
        } else {
            this.currentPage = currentPage;//totalPages
        }
    }

    public int getBeginIndexRecord() {
        return (currentPage - 1) * everyPageRecords;//从哪一条记录开始
    }

    public void setBeginIndexRecord(int beginIndexRecord) {
        this.beginIndexRecord = beginIndexRecord;//设置那一条记录开始
    }

    public boolean isHasNextPage() {
        return currentPage == totalPages || currentPage > totalPages ? false : true;//是否有下一条
    }

    public boolean isHasPrePage() {
        return currentPage == 1 || currentPage < 1 ? false : true;//是否有上一条
    }

    public void next() {//设置下一条的页码数
        if (this.isHasNextPage()) {
            this.currentPage = this.currentPage + 1;
        } else {
            this.currentPage = totalPages;
        }
    }

    public void previ() {
        if (this.isHasPrePage()) {//设置上一条的页码数
            this.currentPage = this.currentPage - 1;
        } else {
            this.currentPage = 1;
        }
    }

    public int getCurrentPageStart() {
        return currentPageStart;
    }

    public void setCurrentPageStart(int currentPageStart) {

        this.currentPageStart = currentPageStart;
    }

    public int getCurrentPageEnd() {
        return currentPageEnd;
    }

    public void setCurrentPageEnd(int currentPageEnd) {
        this.currentPageEnd = currentPageEnd;
    }

    /*显示有多少页，如 11 12 13 14 15 16 17 18 19 20 其中currentPageStart为10，currentPageEnd为20
     *
     * 如果来到第20页，当点击下一页的时候，会跳转到21 22 23 24 25 26 27 28 29 30
     */


    public void setCurrentPageStartOrEnd() {
        if (currentPage % everyPageRecords == 0) {
            currentPageStart = currentPage - (everyPageRecords - 1);
        } else {
            currentPageStart = currentPage - (currentPage % everyPageRecords) + 1;
        }
        currentPageEnd = currentPageStart + (everyPageRecords - 1);
    }


    /*显示有多少页，如 11 12 13 14 15 16 17 18 19 20 其中currentPageStart为10，currentPageEnd为20
     *
     * a相对于对于上个setCurrentPageStartOrEnd()方法中的currentPageStart，b对应于currentPageEnd
     * 如果点击16页或17页（超过11到20的一半），就显示16 17 18 19 20 21 22 23 24 25
     */
//	public void setCurrentPageStartOrEnd(){
//		
//		int a=0,b=0;
//		
//		if(currentPage%everyPageRecords==0){
//			a=currentPage-(everyPageRecords-1);
//		}
//		else{
//			a=currentPage-(currentPage%everyPageRecords)+1;
//		}
//			b=a+(everyPageRecords-1);
//		
//			if(currentPage<(a+5)){
//			currentPageStart=a;
//			currentPageEnd=b;
//			}else{
//			currentPageStart=a+5;
//			currentPageEnd=b+5;
//			}
//		
//	}

}
