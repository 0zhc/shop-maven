package com.shop.service.impl;


import com.shop.dao.EvaluationDao;
import com.shop.entity.Evaluation;
import com.shop.service.EvaluationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class EvaluationServiceImpl implements EvaluationService {
    //
    @Resource
    private EvaluationDao evaluationDao;

    public void addEvaluation(Evaluation evaluation) {
        evaluationDao.addEvaluation(evaluation);

    }

    //	public void setEvaluationDao(EvaluationDao evaluationDao) {
//		this.evaluationDao = evaluationDao;
//	}
//	public EvaluationDao getEvaluationDao() {
//		return evaluationDao;
//	}
//	public void dropEvaluation(Integer id) {
//		evaluationDao.deleteEvaluation(id);
//
//	}
//	public List<Evaluation> getAllEvaluation() {
//
//		return evaluationDao.findAllEvaluations();
//	}
    public int getTotalEvaluationByGoodId(Integer goodId) {

        return evaluationDao.getTotal(goodId);
    }

    //	public void modifyEvaluation(Evaluation evaluation) {
//		// TODO Auto-generated method stub
//		evaluationDao.editEvaluation(evaluation);
//	}
    public List<Evaluation> getEvaluationsByGoodId(Integer goodId, Integer start, Integer max) {
        // TODO Auto-generated method stub
        return evaluationDao.findAllEvaluationByHql(goodId, start, max);
    }


}
