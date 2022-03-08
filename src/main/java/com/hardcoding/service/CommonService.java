package com.hardcoding.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hardcoding.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j // 스트링만됨
@Service
@RequiredArgsConstructor
public class CommonService {
	
	@Autowired
	public final CommonDao dao;
	
	@Transactional
	public List<Map<String, Object>> getCodeList(Map params) {
		List<Map<String, Object>> resultList = dao.selectList("common.selectItems", params);
		return resultList;
	}
	
	public Map<String, Object> getData(String statement, Map condition) {
		Map<String, Object> result = dao.selectOne(statement, condition);
		return result;
	}
	
	public List<Map<String, Object>> getDataList(String statement, Map condition) {
		List<Map<String, Object>> resultList = dao.selectList(statement, condition);
		return resultList;
	}

	public Map<String, Object> getUserInfo(Map<String, Object> param) {
		
		return dao.selectOne("common.getUserInfo", param);
	}
	
	public int checkWriter(String statement, Map<String, Object> condition) {
		log.info("condition" + condition.toString());
		int result = dao.selectInt(statement, condition);
		System.out.println(result);
		
		if(result==1) {
			//있으면 1
			return 1;
		}
		else {
			//없으면
			return 0;
		}
	}
	
	@Transactional
	public String joinMember(String statement, Map<String, Object> map) {
		
		String result;
		int cnt = dao.selectInt(statement, map);
		
		  if(cnt > 0) {
	            result = "이미 사용중인 id입니다.";
	        }
	        else {
	            dao.insert(statement, map);
	            result = "가입되었습니다.";
	        }
		return result;
	}
	
	


}
