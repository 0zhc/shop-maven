package com.shop.service;

import com.shop.entity.StationAnnouce;

import java.util.List;

public interface StationAnnouceService {
    public void saveStationAnnounce(StationAnnouce stationAnnouce);

    public int getTotalSize();

    int getTotalStationAnnouce();

    List<StationAnnouce> findStationAnnouces(int beginIndex, int max);

    //	public List<StationAnnouce> findStationAnnouces(String hql,int start,int max);
    public void updateStationAnnouce(StationAnnouce stationAnnouce, Integer id);

    public StationAnnouce getStationAnnouceById(Integer id);

    public void deleteStationAnnouce(Integer id);

    int getTotalStationAnnouceByTime(String startTime, String endTime);

    List<StationAnnouce> findStationAnnoucesByTime(String startTime, String endTime, int beginIndex, int max);

    List<StationAnnouce> findStationAnnoucesByState(String startTime, String endTime, int beginIndex, int max);

    int getTotalStationAnnouceByTimeAndState(String startTime, String endTime);
}
