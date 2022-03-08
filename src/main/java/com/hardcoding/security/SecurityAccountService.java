package com.hardcoding.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
public class SecurityAccountService implements UserDetailsService{
	
	private final AccountMapper accountMapper;

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
			
		SecurityAccount account = new SecurityAccount(accountMapper.getAccountById(id));
		return account;
	}
	
}
