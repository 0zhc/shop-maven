package com.shop.utils;

public class CutDateTime {
    public static String cut(String date) {
        return date.substring(0, 4) + "-" + date.substring(5, 7) + "-" + date.substring(8, 10);
    }
}
