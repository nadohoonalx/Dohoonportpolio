
  package com.hardcoding.mapper;
 
 import java.util.List;

import org.springframework.stereotype.Repository;

import com.hardcoding.model.BoardVO;
import com.hardcoding.model.Criteria;
 
 @Repository 
 public interface BoardMapper {
	 
	//게시판 목록(페이징 적용)
	 public List<BoardVO> getListPaging(Criteria cri);
	
	 //게시판 조회
	 public BoardVO getPage(int bno);
 
 }
