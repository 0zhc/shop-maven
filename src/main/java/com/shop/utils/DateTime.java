package com.shop.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTime {
    public static String getNow() {
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String date = dateFormat.format(now);
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("HH:mm:ss");
        String time = dateFormat1.format(now);
        String dateTime = date + " " + time;
        return dateTime;
    }

}
