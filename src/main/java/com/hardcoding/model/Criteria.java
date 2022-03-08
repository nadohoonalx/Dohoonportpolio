package com.hardcoding.model;

import lombok.Data;

@Data
public class Criteria {
	
	//현재 페이지
	private int pageNum;
	
	//한 페이지 당 보여질 게시물 갯수
	private int amount;
	
	/* 검색 키워드 */
	private String keyword;
	
	/* 검색 타입 */
	private String type;
	
	/* 검색 타입 배열 변환 */
	private String[] typeArr;
	
	/* 기본 생성자 -> 기봅 세팅 : pageNum = 1, amount = 10 */
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
 
	}
}
