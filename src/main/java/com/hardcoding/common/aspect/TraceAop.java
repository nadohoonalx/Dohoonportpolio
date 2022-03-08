//package com.hardcoding.common.aspect;
//
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.aspectj.lang.ProceedingJoinPoint;
//import org.aspectj.lang.annotation.Around;
//import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Pointcut;
//import org.springframework.stereotype.Component;
//import org.springframework.ui.Model;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import lombok.extern.slf4j.Slf4j;
//
////@Slf4j
////@Aspect
////@Component
///*
//public class TraceAop {
//		
//	@Pointcut("execution(public * com.hardcoding.controller..*(..))")
//	public void pointCutMethod() {}
//	
//	@Around("pointCutMethod() && args(model, req, res)")
//	public Object trace(ProceedingJoinPoint joinPoint, Model model, HttpServletRequest req, HttpServletResponse res) throws Throwable {
//		
//		log.info("================================================");
//		log.info("profiler == Before ||" + joinPoint.getSignature().toShortString());
//		log.info("==이 시스템은 " + System.getProperty("spring.profiles.active") + "입니다.");
//		String addr = req.getRemoteAddr();
//		log.info("== 서비스 요청 ip는 " + addr + "입니다.");
//		log.info("=============================================");
//		ObjectMapper oMapper = new ObjectMapper();
//		Map<String, Object> map = oMapper.convertValue(joinPoint.getArgs()[0], Map.class);
//		Object result = new Object();
//		
//		try {
//			//false로 하면 java.lang.NullPointerException 발생
//			HttpSession session = req.getSession(true);
//			log.info("session id ::" + session.getId());
//			if(session.getAttribute("authUser") == null) {
//				log.info("로그인 해야함 .!! " + session.toString());
//				res.sendRedirect(req.getContextPath() + "/nossesion/loginForm");
//			}
//			else {
//				log.info("로그인 되었음...!!" + session.toString());
//			}
//			result = joinPoint.proceed();
//			model.addAttribute("ServerInfo", System.getProperty("spring.profiles.active"));
//			map.put("Service", req.getServletPath().replace("/","")); //요청 서비스 id
//			map.put("ACCESS_IP", addr);			//서비스 요청 ip
//			map.put("Request Query", req.getQueryString());	//요청 URL
//			System.out.println(map);
//			
//			return result;
//		}
//		finally { 
//		}
//     }
//	}
//	*/
//	
//
