package com.shop.dao;


import com.shop.entity.Friendlink;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FriendlinkDao {

    public void addFriendLink(@Param("friendlink") Friendlink friendlink);

    //
    public List<Friendlink> findFriendlinkByShopId(@Param("shopId") int shopId);

    //
    public void modifyFriendlink(@Param("id") int id, @Param("LinkName") String LinkName, @Param("LinkUrl") String LinkUrl);
}
