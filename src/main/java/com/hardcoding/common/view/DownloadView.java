package com.hardcoding.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Component
public class DownloadView extends AbstractView{  //공통모듈
	
	public DownloadView() {
		log.info("DownloadView RealSpring2 생성자 ==");
		setContentType("application/download; charset=utf=8");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request ,HttpServletResponse response) throws Exception {
		
		log.info("DownloadView.rederMergedOutput Model ==");
		Map map = (HashMap) model.get("downloadFile");
		
		File file = (File) map.get("model");
		
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());
		
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String fileName = (String)map.get("FILE_REALNAME");
		
		if(ie) {
			fileName = URLEncoder.encode(fileName, "utf-8");
		}
		else {
			fileName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		}
		finally {
			if(fis !=null)
				try {
					fis.close();
				}
			catch(Exception ex) {
				
			}
		}
		out.flush();
	}
}
