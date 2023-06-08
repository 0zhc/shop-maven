package com.shop.dao;

import com.shop.entity.CodeActive;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CodeActiveDao {
    CodeActive findCodeActiveByBusinessId(@Param("businessId") Integer businessId);

    void add(@Param("businessId") int businessId, @Param("activeCode") String activeCode);

    //	//给客户添加一个激活码
//   public boolean add( CodeActive codeActive);
//   public int selectBusinessId(@Param("businessId")int businessId);
    //分页   按用户名和激活码查看所有的激活码
    public List<CodeActive> activeCodes(@Param("begin") int begin, @Param("RecordCount") int RecordCount, @Param("userName") String userName, @Param("activeCode") String activeCode);

    //分页   按用户名和激活码查看所有的激活码记录数
    public int counts(@Param("userName") String userName, @Param("activeCode") String activeCode);

    void isActiveModifyByBusinessId(@Param("businessId") Integer businessId);
}
