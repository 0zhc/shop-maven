package com.shop.dao;

import com.shop.entity.StationAnnouce;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StationAnnouceDao {
    public void saveStationAnnounce(@Param("stationAnnouce") StationAnnouce stationAnnouce);

    //	public List<StationAnnouce> findStationAnnouceByHql(String hql,int start,int max);
    public int getTotal();

    int getTotalStationAnnouce();

    List<StationAnnouce> findStationAnnouces(@Param("beginIndex") int beginIndex, @Param("max") int max);

    public void updateStationAnnouce(@Param("stationAnnouce") StationAnnouce stationAnnouce, @Param("id") Integer id);

    public StationAnnouce getStationAnnouceById(@Param("id") Integer id);


    void deleteStationAnnouce(Integer id);

    int getTotalStationAnnouceByTime(@Param("startTime") String startTime, @Param("endTime") String endTime);

    List<StationAnnouce> findStationAnnoucesByTime(@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("beginIndex") int beginIndex, @Param("max") int max);

    List<StationAnnouce> findStationAnnoucesByState(@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("beginIndex") int beginIndex, @Param("max") int max);

    int getTotalStationAnnouceByTimeAndState(@Param("startTime") String startTime, @Param("endTime") String endTime);
}
