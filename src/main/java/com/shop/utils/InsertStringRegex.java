package
        com.shop.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InsertStringRegex {

    public static String insertStringRegex(String oldStr, String regEx,
                                           String insert) {
        String newStr = "";
        boolean result;
        Pattern p = Pattern.compile(regEx);
        String[] hh = p.split(oldStr);
        Matcher m = p.matcher(oldStr);
        int i = 0;
        result = true;
        while (result) {
            result = m.find();
            if (result) {
                newStr += hh[i] + m.group() + insert;
                i++;
            }
        }
        newStr += hh[hh.length - 1];
        return newStr;
    }


}
