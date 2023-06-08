package com.shop.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SexNumDao {
    int sexNum(@Param("id") int id);

    int typeNum(@Param("id") int id);

    int salesAmount();

    int getTotalSizeIsSole();

    int getShopSexNum(@Param("id") int id, @Param("isMan") int isMan);

    int gradeNum(@Param("grade") String grade);

    int ageNum(@Param("begin") int begin, @Param("end") int end);

    List<Integer> getQuarterData();

    List<Integer> getYearData();

    List<Integer> getWeekData();

    List<Integer> getMonthData();

    int getUserCount();

    int getSellNum();

    int getBuyNum();

    int getErrorNum();

    int getNewUser();
}
