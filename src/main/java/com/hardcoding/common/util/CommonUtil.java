package com.hardcoding.common.util;

public class CommonUtil {
	
	public static String getSelect() {
		
		return  "<select id = 'searchdate' >"
				+ "<option value = 'all' selected=' '>-select-</option>"
				+ "<option value='id'> 1일</option>"
				+ "<option value='iw'> 1주일</option>"
				+ "<option value='im'> 1개월</option>"
				+ "<option value='6m'> 6개월</option>"
				+ "<option value='1y'> 1년</option>"
				+ "</select>";

	}

}
