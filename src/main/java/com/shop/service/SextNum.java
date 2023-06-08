package com.shop.service;

import java.util.List;

public interface SextNum {
    int sexNum(int id);

    int typeNum(int id);

    int getorderCount();

    int getShopSexNum(int id, int isMan);

    List<Integer> getQuarterData();

    List<Integer> getYearData();

    List<Integer> getWeekData();

    List<Integer> getMonthData();

    int salesAmount();

    int ageNum(int begin, int end);

    int gradeNum(String grade);

    int getUserCount();

    int getSellNum();

    int getBuyNum();

    int getErrorNum();


    int getNewUser();
}
