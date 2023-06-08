package com.shop.utils;

import java.util.HashMap;
import java.util.Map;

public class CountUtil {
    static Map<Integer, Integer> complaintMap = new HashMap<Integer, Integer>();
    static Map<Integer, Integer> complaintAlertMap = new HashMap<Integer, Integer>();
    static Map<Integer, Integer> cusOrderMap = new HashMap<Integer, Integer>();
    static Map<Integer, Integer> ownOrderMap = new HashMap<Integer, Integer>();


    public static Map<Integer, Integer> getComplaintMap() {
        return complaintMap;
    }

    public static Map<Integer, Integer> getComplaintAlertMap() {
        return complaintAlertMap;
    }

    public static Map<Integer, Integer> getCusOrderMap() {
        return cusOrderMap;
    }

    public static Map<Integer, Integer> getOwnOrderMap() {
        return ownOrderMap;
    }


}
