package com.shop.entity;

import java.util.List;

public class DataResponse {
    private List<Integer> year;
    private List<Integer> quarter;
    private List<Integer> month;
    private List<Integer> week;

    // getters and setters

    public List<Integer> getYear() {
        return year;
    }

    public void setYear(List<Integer> year) {
        this.year = year;
    }

    public List<Integer> getQuarter() {
        return quarter;
    }

    public void setQuarter(List<Integer> quarter) {
        this.quarter = quarter;
    }

    public List<Integer> getMonth() {
        return month;
    }

    public void setMonth(List<Integer> month) {
        this.month = month;
    }

    public List<Integer> getWeek() {
        return week;
    }

    public void setWeek(List<Integer> week) {
        this.week = week;
    }
}