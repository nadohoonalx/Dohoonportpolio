package com.hardcoding.model;

import java.util.List;

import org.junit.Test;

import com.hardcoding.mapper.BoardMapper;
import com.hardcoding.repository.CommonDao;

public class testGetListPaging implements BoardMapper {

	//private final CommonDao dao;
	
	@Test
	public void testGetListPaging() {
		
		Criteria cri = new Criteria();
		
		cri.setPageNum(2);
		//List list = mapper.getListPaging(cri);
		
		//list.forEach(board -> log.info("" + board));
	}

	@Override
	public List<BoardVO> getListPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardVO getPage(int bno) {
		// TODO Auto-generated method stub
		return null;
	}
		
	
	}
