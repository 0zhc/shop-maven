package com.shop.service.impl;

import com.shop.dao.SexNumDao;
import com.shop.service.SextNum;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class SexNumImp implements SextNum {
    @Resource
    SexNumDao sexNumDao;

    @Override
    public int sexNum(int id) {
        return sexNumDao.sexNum(id);
    }

    @Override
    public int typeNum(int id) {
        return sexNumDao.typeNum(id);
    }

    @Override
    public int getorderCount() {
        return sexNumDao.getTotalSizeIsSole();
    }

    @Override
    public int getShopSexNum(int id, int isMan) {
        return sexNumDao.getShopSexNum(id, isMan);
    }


    @Override
    public List<Integer> getQuarterData() {
        return sexNumDao.getQuarterData();
    }

    @Override
    public List<Integer> getYearData() {
        return sexNumDao.getYearData();
    }

    @Override
    public List<Integer> getWeekData() {
        return sexNumDao.getWeekData();
    }

    @Override
    public List<Integer> getMonthData() {
        return sexNumDao.getMonthData();
    }

    @Override
    public int salesAmount() {
        return sexNumDao.salesAmount();
    }

    @Override
    public int ageNum(int begin, int end) {
        return sexNumDao.ageNum(begin, end);
    }

    @Override
    public int gradeNum(String grade) {
        return sexNumDao.gradeNum(grade);
    }

    @Override
    public int getUserCount() {
        return sexNumDao.getUserCount();
    }

    @Override
    public int getSellNum() {
        return sexNumDao.getSellNum();
    }

    @Override
    public int getBuyNum() {
        return sexNumDao.getBuyNum();
    }

    @Override
    public int getErrorNum() {
        return sexNumDao.getErrorNum();
    }

    @Override
    public int getNewUser() {
        return sexNumDao.getNewUser();

    }
}
