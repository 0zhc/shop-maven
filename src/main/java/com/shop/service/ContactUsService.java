package com.shop.service;


import com.shop.entity.Shop;

public interface ContactUsService {

//	public Shop findContactUsByUserId(int userId);

    public Shop modifySContactUs(int userId, String contactUs);
}
