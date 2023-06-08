package com.shop.utils;

import java.io.Serializable;
import java.security.MessageDigest;

public class PasswordEncryption implements Serializable {
    //�������
    public static String MD5(String data) {

        StringBuilder builder = new StringBuilder();
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(data.getBytes());
            byte[] bs = messageDigest.digest();
            for (int i = 0; i < bs.length; i++) {
                int v = bs[i] & 0xFF;
                if (v < 16) {
                    builder.append(0);
                }
                builder.append(Integer.toHexString(v));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return builder.toString();
    }
}
