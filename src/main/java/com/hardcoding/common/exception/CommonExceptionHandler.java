package com.hardcoding.common.exception;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


 @Component
 
 @ControllerAdvice("com.hardcoding") 
 public class CommonExceptionHandler {
	
	@ExceptionHandler(ArithmeticException.class)
	public String handleException(ArithmeticException ex) {
		
		System.out.println("ArithmeticException ::" + ex.getLocalizedMessage());
		System.out.println("getMessage ::" + ex.getMessage());
		System.out.println("toString :: " + ex.toString());
		
		return "error/commonException";
		
	}
 }
