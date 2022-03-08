package com.hardcoding.security;

import lombok.Data;

@Data
public class Account {
	
	private String id;
	private String password;
	private String joinDate;
	private String authGrpNm;
	
}
