package com.shop.dao;

import org.apache.ibatis.annotations.Param;

public interface ContactUsDao {

    //	public Shop findContactUsByUserId(int userId);
//
    public void modifySContactUs(@Param("userId") int userId, @Param("contactUs") String contactUs);

}
