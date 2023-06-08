package com.shop.service.impl;


import com.shop.dao.FriendlinkDao;
import com.shop.entity.Friendlink;
import com.shop.service.FriendlinkService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class FriendlinkServiceImpl implements FriendlinkService {

    @Resource
    private FriendlinkDao friendlinkDao;

    //
//	public void setFriendlinkDao(FriendlinkDao friendlinkDao) {
//		this.friendlinkDao = friendlinkDao;
//	}
//
    public List<Friendlink> findFriendlinkByShopId(int shopId) {

        return friendlinkDao.findFriendlinkByShopId(shopId);
    }

    //
    public List<Friendlink> addFriendLink(int shopId, String oneLinkName,
                                          String oneLinkUrl, String twoLinkName, String twoLinkUrl,
                                          String threeLinkName, String threeLinkUrl) {
        List linkNameList = new ArrayList();
        linkNameList.add(oneLinkName);
        linkNameList.add(twoLinkName);
        linkNameList.add(threeLinkName);

        List linkList = new ArrayList();
        linkList.add(oneLinkUrl);
        linkList.add(twoLinkUrl);
        linkList.add(threeLinkUrl);

        Date date = new Date();
        for (int i = 0; i < 3; i++) {
            Friendlink friendlink = new Friendlink();
            friendlink.setShopId(shopId);
            friendlink.setUrlText((String) linkNameList.get(i));
            friendlink.setUrl((String) linkList.get(i));
            friendlink.setInTime(date);
            friendlink.setTag(1);
            friendlinkDao.addFriendLink(friendlink);

        }


        return friendlinkDao.findFriendlinkByShopId(shopId);
    }

    //
    public List<Friendlink> modifyFriendlink(int shopId, String oneLinkName,
                                             String oneLinkUrl, String twoLinkName, String twoLinkUrl,
                                             String threeLinkName, String threeLinkUrl) {

        List<Friendlink> friendlinkByShopId = friendlinkDao.findFriendlinkByShopId(shopId);
        List linkNameList = new ArrayList();
        linkNameList.add(oneLinkName);
        linkNameList.add(twoLinkName);
        linkNameList.add(threeLinkName);

        List linkList = new ArrayList();
        linkList.add(oneLinkUrl);
        linkList.add(twoLinkUrl);
        linkList.add(threeLinkUrl);

//		Date date = new Date();
        for (int i = 0; i < friendlinkByShopId.size(); i++) {
            Friendlink friendlink = friendlinkByShopId.get(i);
            Integer id = friendlink.getId();
            friendlinkDao.modifyFriendlink(id, (String) linkNameList.get(i), (String) linkList.get(i));

        }
        return friendlinkDao.findFriendlinkByShopId(shopId);


//		return friendlinkDao.modifyFriendlink(userId, oneLinkName, oneLinkUrl, twoLinkName, twoLinkUrl, threeLinkName, threeLinkUrl);
    }

}
