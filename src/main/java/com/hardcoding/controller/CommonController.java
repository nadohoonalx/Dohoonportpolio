package com.hardcoding.controller;


import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hardcoding.service.CommonService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("common")
public class CommonController {
	
	private final CommonService commonService;
	
	@GetMapping("login")
	public String login() {	
		return "auth/loginForm";
	}
	
	
	//엔터페이지를 스프링시큐리티로 어떤식으로 할련지? 어떻게 할건지 생각해봐라.
	@GetMapping("enterPage")
	public String login(@RequestParam Map<String, Object> param) {	
		return "/";
 	}
	
	
	@GetMapping("MemberRegist")
	public String MemberRegist() {	
		return "regist/MemberRegist";
 	}
	
	@ResponseBody
	@PostMapping("checkWriter")
	public Map checkWriter(@RequestParam Map<String, Object> param)
	{	
		 Map<String, Object> result = new HashMap<>();
		 
		 
		result.put("result", commonService.checkWriter("Register.checkWriter", param)); 
		
		return result;
	}
	
	
	@PostMapping("joinMember")
	public String joinMember(@RequestParam Map<String, Object> param, Model model)
	{	
		 Map<String, Object> result = new HashMap<>();
		 String message;
		  
		 message = commonService.joinMember("Register.checkWriter", param); 
		 
		 model.addAttribute("message", message);
		 
		 return message;
	}
	
}
