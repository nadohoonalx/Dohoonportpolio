package com.hardcoding.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hardcoding.mapper.BoardMapper;
import com.hardcoding.model.BoardVO;
public class BoardServiceTest {
	
	
	@Autowired
	private BoardMapper mapper;
	@Test
	public void testEnroll() {
			
		BoardVO vo = new BoardVO();
		
		vo.setTitle("service Test");
		vo.setContent("service test");
		vo.setWriter("service test");
		
		mapper.enroll(vo);
		
		
	}
}
