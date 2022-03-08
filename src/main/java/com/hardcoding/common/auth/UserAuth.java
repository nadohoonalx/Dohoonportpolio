package com.hardcoding.common.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@AllArgsConstructor
@Getter
@Builder
public class UserAuth {
	private String name;
	private String email;
}
