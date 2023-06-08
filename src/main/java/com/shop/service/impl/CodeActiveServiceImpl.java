package com.shop.service.impl;


import com.shop.dao.CodeActiveDao;
import com.shop.entity.CodeActive;
import com.shop.service.CodeActiveService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CodeActiveServiceImpl implements CodeActiveService {
    @Resource
    CodeActiveDao codeActiveDao;

    @Override
    public CodeActive findCodeActiveByBusinessId(Integer businessId) {
        return codeActiveDao.findCodeActiveByBusinessId(businessId);
    }

    @Override
    public void add(int businessId, String activeCode) {
        codeActiveDao.add(businessId, activeCode);
    }


    public List<CodeActive> activeCodes(int begin, int RecordCount, String userName, String activeCode) {

        return codeActiveDao.activeCodes(begin, RecordCount, userName, activeCode);
    }

    public int counts(String userName, String activeCode) {

        return codeActiveDao.counts(userName, activeCode);
    }

    @Override
    public void isActiveModifyByBusinessId(Integer businessId) {
        codeActiveDao.isActiveModifyByBusinessId(businessId);
    }

}
