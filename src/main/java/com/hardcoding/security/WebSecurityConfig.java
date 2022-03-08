package com.hardcoding.security;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@EnableWebSecurity //스프링 시큐리티를 사용하기 위한 어노테이션 선언
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
//WebSecurityConfigurerAdapter 상속

	//접근 제한 설정
	protected void configure(HttpSecurity http) throws Exception {
		http.formLogin()
			.and() //chain 형태
		    .authorizeRequests()
			.anyRequest().authenticated();
	}
	
}
