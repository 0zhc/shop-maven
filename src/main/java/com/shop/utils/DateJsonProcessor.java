package com.shop.utils;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateJsonProcessor implements JsonValueProcessor {

    private DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public Object processArrayValue(Object value, JsonConfig arg1) {

        System.out.println("###############" + dateFormat.format((Date) value));
        return dateFormat.format((Date) value);
    }

    public Object processObjectValue(String s, Object value, JsonConfig arg2) {
        // TODO Auto-generated method stub
        System.out.println("***********" + dateFormat.format((Date) value));
        return dateFormat.format((Date) value);
    }

}
