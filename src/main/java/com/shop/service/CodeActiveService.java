package com.shop.service;

import com.shop.entity.CodeActive;

import java.util.List;

public interface CodeActiveService {
    CodeActive findCodeActiveByBusinessId(Integer businessId);

    public void add(int businessId, String activeCode);

    //分页   按用户名和激活码查看所有的激活码
    public List<CodeActive> activeCodes(int begin, int RecordCount, String userName, String activeCode);

    //分页   按用户名和激活码查看所有的激活码记录数
    public int counts(String userName, String activeCode);

    void isActiveModifyByBusinessId(Integer businessId);
}
