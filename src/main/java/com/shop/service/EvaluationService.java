package com.shop.service;

import com.shop.entity.Evaluation;

import java.util.List;

public interface EvaluationService {
    public void addEvaluation(Evaluation evaluation);

    //	public void dropEvaluation(Integer id);
//	public void modifyEvaluation(Evaluation id);
//	public List<Evaluation> getAllEvaluation();
    public int getTotalEvaluationByGoodId(Integer goodId);

    public List<Evaluation> getEvaluationsByGoodId(Integer goodId, Integer start, Integer max);

}
