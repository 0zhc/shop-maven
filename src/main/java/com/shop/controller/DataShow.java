package com.shop.controller;

import com.shop.entity.DataResponse;
import com.shop.entity.SexNum;
import com.shop.service.SextNum;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DataShow {
    @Resource
    SextNum sextNum;

    @RequestMapping("/admin/sexCount.do")
    @ResponseBody
    public Map<String, List<SexNum>> test(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("+++++qwdada");


        SexNum a1 = new SexNum();
        System.out.println("pppp");

        a1.setName("男");
        a1.setValue(sextNum.sexNum(1));
        System.out.println(a1.getValue() + "fefkkanka");
        SexNum a2 = new SexNum();
        a2.setName("女");
        a2.setValue(sextNum.sexNum(2));
        ArrayList<SexNum> aas = new ArrayList<>();
        aas.add(a1);
        aas.add(a2);
//        jsonStr = JSON.toJSONString(aas);
//        return jsonStr;
//        out.print(jsonStr);
//        return aas;
        Map<String, List<SexNum>> map = new HashMap<String, List<SexNum>>();
        map.put("data", aas);
////        out.write(String.valueOf(map));
//        System.out.println("pppp");
        return map;
    }

    @RequestMapping("/admin/typeCount.do")
    @ResponseBody
    public Map<String, List<SexNum>> typeNum(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        System.out.println("+++++qwdada");


        SexNum a1 = new SexNum();

        a1.setName("零食");
        a1.setValue(sextNum.typeNum(2));
//        System.out.println(a1.getValue() + "fefkkanka");
        SexNum a2 = new SexNum();
        a2.setName("电子产品");
        a2.setValue(sextNum.typeNum(1));

        SexNum a3 = new SexNum();
        a3.setName("宿舍用品");
        a3.setValue(sextNum.typeNum(3));

        SexNum a4 = new SexNum();
        a4.setName("其他");
        a4.setValue(sextNum.typeNum(4));


        ArrayList<SexNum> aas = new ArrayList<>();
        aas.add(a1);
        aas.add(a2);
        aas.add(a3);
        aas.add(a4);
//        jsonStr = JSON.toJSONString(aas);
//        return jsonStr;
//        out.print(jsonStr);
//        return aas;
        Map<String, List<SexNum>> map = new HashMap<String, List<SexNum>>();
        map.put("data", aas);
////        out.write(String.valueOf(map));
//        System.out.println("pppp");
        return map;
    }

    @RequestMapping("/admin/ageCount.do")
    @ResponseBody
    public int[] ageCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int[] arr = new int[3];
        arr[0] = sextNum.ageNum(18, 30);
        arr[1] = sextNum.ageNum(30, 40);
        arr[2] = sextNum.ageNum(40, 50);

//        ArrayList<Integer> list = new ArrayList<>();
//        list.add(sextNum.ageNum(18,30));
//        list.add(sextNum.ageNum(30,40));
//        list.add(sextNum.ageNum(40,50));

        return arr;
    }

    @RequestMapping("/admin/gradeCount.do")
    @ResponseBody
    public int[] gradeCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int[] arr = new int[5];
        arr[0] = sextNum.gradeNum("大一");
        arr[1] = sextNum.gradeNum("大二");
        arr[2] = sextNum.gradeNum("大三");
        arr[3] = sextNum.gradeNum("大四");
        arr[4] = sextNum.gradeNum("老师");
        return arr;
    }

    @RequestMapping("/searchSellData.do")
    @ResponseBody
    public Map<String, Object> searchSellData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> data = new HashMap<String, Object>();
//        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
//        Integer id = user.getId();
        int orderCount = sextNum.getorderCount();
//        System.out.println("订单数量:::"+orderCount);
        int salesAmount = sextNum.salesAmount();


        data.put("orderCount", orderCount);
        data.put("salesAmount", salesAmount);
        return data;
    }

    @RequestMapping("/shopSexData.do")
    @ResponseBody
    public Map<String, Object> shopSexData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> data = new HashMap<String, Object>();
//        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");
        //商家订单总数

        int Boy = sextNum.sexNum(1);
        int Girl = sextNum.sexNum(2);
        data.put("Boy", Boy);
        data.put("Girl", Girl);
        return data;
    }

    @RequestMapping("/userData.do")
    @ResponseBody
    public Map<String, Object> userData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map<String, Object> data = new HashMap<String, Object>();
//        com.shop.entity.User user = (com.shop.entity.User) request.getSession().getAttribute("user");

        int userNum = sextNum.getUserCount();
        int sellNum = sextNum.getSellNum();
        int buyNum = sextNum.getBuyNum();
        int errorNum = sextNum.getErrorNum();
        int newUser = sextNum.getNewUser();

        //商家订单总数


        data.put("userNum", userNum);
        data.put("sellNum", sellNum);
        data.put("buyNum", buyNum);
        data.put("errorNum", errorNum);
        data.put("newUser", newUser);
        return data;
    }

    @RequestMapping("/admin/sellCount.do")
    @ResponseBody
    public DataResponse sellCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Integer> yearData = sextNum.getYearData();
        List<Integer> quarterData = sextNum.getQuarterData();
        List<Integer> monthData = sextNum.getMonthData();
        List<Integer> weekData = sextNum.getWeekData();

        DataResponse dataResponse = new DataResponse();
        dataResponse.setYear(yearData);
        dataResponse.setQuarter(quarterData);
        dataResponse.setMonth(monthData);
        dataResponse.setWeek(weekData);

        return dataResponse;

    }
}

