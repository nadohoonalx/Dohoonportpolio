package com.hardcoding.security;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class SecurityAccount extends User {
	
	public SecurityAccount(Account account) {
		super(
			account.getId();
			account.getPassword();
			AuthorityUtils.createAuthorityList(account.getRole());
	 );
	}
}
