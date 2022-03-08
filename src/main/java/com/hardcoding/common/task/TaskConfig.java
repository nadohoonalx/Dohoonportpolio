package com.hardcoding.common.task;

import java.io.IOException;
import java.time.LocalDateTime;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class TaskConfig implements Runnable {

	@Override
 public void run() {
		// TODO Auto-generated method stub
		log.info("왜안돼");
		log.info("배치가 실행된다네.." + LocalDateTime.now());
		
		final String URL = "https://news.naver.com/";
		
		Document doc = null;
		try {
			doc = Jsoup.connect(URL).get();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		System.out.println(doc.toString());
//		System.out.println("======================");
//		
//		Elements list = doc.select(".cjs_t");
		
//		list.stream()
//			.forEach(x -> System.out.println(x.text()));
	
	}
	
	
}	
