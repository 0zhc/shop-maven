package com.shop.dao;

import com.shop.entity.Evaluation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EvaluationDao {
    public List<Evaluation> findAllEvaluationByHql(@Param("goodId") Integer goodId, @Param("start") Integer start, @Param("max") Integer max);

    public int getTotal(@Param("goodId") Integer goodId);

    public void addEvaluation(@Param("evaluation") Evaluation evaluation);
//	public void deleteEvaluation(Integer id);
//	public void editEvaluation(Evaluation evaluation);
//	public List<Evaluation> findAllEvaluations();
//	public Evaluation findEvaluationById(Integer id);
//	public Integer getTotal(String hql);
//	public List<Evaluation> findAllEvaluationByHql(String hql,Integer start,Integer max);
}
