package com.shop.service;

import com.shop.entity.Friendlink;

import java.util.List;

public interface FriendlinkService {

    public List<Friendlink> addFriendLink(int userId, String oneLinkName, String oneLinkUrl,
                                          String twoLinkName, String twoLinkUrl, String threeLinkName, String threeLinkUrl);

    //
    public List<Friendlink> findFriendlinkByShopId(int shopId);

    //
    public List<Friendlink> modifyFriendlink(int userId, String oneLinkName, String oneLinkUrl,
                                             String twoLinkName, String twoLinkUrl, String threeLinkName, String threeLinkUrl);
}
