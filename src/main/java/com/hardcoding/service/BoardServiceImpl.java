package com.hardcoding.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hardcoding.repository.CommonDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {

	private final CommonDao dao;
	
	@Transactional
	public String enroll(Map map) {
		
		int affectCount = dao.insert("board.insertNewboard", map);
		if(affectCount == 1) {
			
			return "success";// OK 여기로 보내야함.
		}
		else 
		{
			return "fail";
		}
		
	}
	
	@Transactional
	public String renew(Map map) {
		
		int affectCount = dao.update("board.updatelist", map);
		if(affectCount == 1) {
			
			return "success";// OK 여기로 보내야함.
		}
		else 
		{
			return "fail";
		}
		
		
	}
	
	@Transactional
	public String delete(Map map) {
		
		int affectCount = dao.update("board.deletelist", map);
		if(affectCount == 1) {
			
			return "success";// OK 여기로 보내야함.
		}
		else 
		{
			return "fail";
		}
		
		
	}
	
	@Transactional
	public int total() {
		
		int getTotal = dao.selectInt2("grid.getTotal"); 
		
		return getTotal;
	}
	
	@Transactional
	public List<Map<String, Object>> getDataList(String statement, Map condition) {
		List<Map<String, Object>> resultList = dao.selectList(statement, condition);
		return resultList;
	}
	
	
	
	
	@Transactional
	public List<Map<String, Object>> upload3(MultipartHttpServletRequest req, HttpSession session) {
		
		
		List<MultipartFile> files = req.getFiles("files");
		List<Map<String,Object>> resultList = new ArrayList<>();
		
		String sPath = "c:" + File.separator + "NAS" + File.separator;
		String sGroupKey = dao.selectStr("board.selectFileGroupKey", null);
		
		for(int i=0; i<files.size(); i++) {
			MultipartFile mpf = files.get(i);
			//result.add(mpf.getOriginalFilename());
			
			try {
				
				//1. 파일관리 테이블에 데이터를 insert 한다.
				Map<String, Object> param = new HashMap<String, Object>(); //param 하나여서 params 는 복수
				param.put("GROUP_KEY", sGroupKey);
				param.put("FILE_KEY", (i+1));
				param.put("FILE_REALNAME", mpf.getOriginalFilename());
				param.put("FILE_NAME", Calendar.getInstance().getTimeInMillis());
				param.put("FILE_PATH", sPath);
				param.put("FILE_LENGTH", mpf.getBytes().length);
				param.put("FILE_TYPE", mpf.getContentType());
				param.put("USER_ID", System.getProperty("spring.profiles.active"));
				
				session.setAttribute("GROUP_KEY", sGroupKey);
				session.setAttribute("FILE_KEY", (i+1));
			
				resultList.add(param);
				dao.insert("board.insertFileInfo", param);
				
				//2. 지정된 위치가 존재하는지 확인하고 없으면 경로를 생성한다.
				File chkDir = new File(sPath);
				if(!chkDir.isDirectory()) {
					chkDir.mkdirs();
				}
				
				//3. 지정된 위치에 파일을 복사한다.
				FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(sPath +param.get("FILE_NAME")));
			}
			catch(Exception e) {
				System.out.println("error -" + e.getMessage());
				//e.printStackTrace(); 잘 안씀
				log.info(e.getMessage());
			}
		//	map.put("files", result);
		}
		
		return resultList;
	}
	
}
