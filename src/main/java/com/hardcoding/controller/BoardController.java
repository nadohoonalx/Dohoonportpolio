package com.hardcoding.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hardcoding.DTO.PageMakerDTO;
import com.hardcoding.model.Criteria;
import com.hardcoding.service.BoardServiceImpl;
import com.hardcoding.service.CommonService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("board")
public class BoardController {

	private final CommonService commonService;
	private final BoardServiceImpl boardServiceImpl;

	@GetMapping("writeForm3")
	public String writeForm3(Model model, HttpServletRequest req, HttpServletResponse res) {
		return "board/writeForm3";
	}

	/* 다운로드 */
	@RequestMapping("getFileDownload")
	public ModelAndView getFileDownload(@RequestParam Map<String, String> map) throws Exception {
		log.info("getFileDownload");
		Map fileMap = commonService.getData("board.getFileInfo", map); // groupkey + filekey 값이 받아져서 옴
		String path = null;

		if (fileMap != null) {
			path = "" + fileMap.get("FILE_PATH").toString() + fileMap.get("FILE_NAME").toString();
		}

		File downloadFile = new File(path);
		Map data = new HashMap();
		data.put("model", downloadFile);
		data.put("FILE_REALNAME", fileMap.get("FILE_REALNAME"));

		return new ModelAndView("downloadView", "downloadFile", data);

	}

	/* 다중업로드 */
	@ResponseBody
	@PostMapping("upload3")
	public Map upload3(MultipartHttpServletRequest req, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		List<Map<String, Object>> resultList = boardServiceImpl.upload3(req, session);

		result.put("files", resultList);

		return result;

	}

	

	/* 게시판 등록 */

	@RequestMapping("doReg")
	public String doReg(Model model, HttpServletRequest req, HttpServletResponse res) {

		return "board/enroll";
	}

	@ResponseBody
	@PostMapping("enroll")
	public Map enroll(@RequestParam Map<String, String> model2, HttpServletRequest req, HttpServletResponse res) {

		Map<String, Object> result = new HashMap<>();
		HttpSession session = req.getSession();

		log.info("board.enroll controller로 들어왔음");
		System.out.println(session.getAttribute("GROUP_KEY"));
		System.out.println(session.getAttribute("FILE_KEY"));

		model2.put("GROUP_KEY", String.valueOf(session.getAttribute("GROUP_KEY")));
		model2.put("FILE_KEY", String.valueOf(session.getAttribute("FILE_KEY")));

		System.out.println("Parameter ::" + model2.toString());
		log.info("board.enroll전");

		result.put("result", boardServiceImpl.enroll(model2));

		return result;

	}

	// 2페이지 10개씩 가져와서 그리즈에 뿌려주기 구현중

	/* 게시판 목록 페이지 접속 */
	
	
	  @GetMapping("list") 
	  public ModelAndView list (@RequestParam Map<String, Object> param, Model model, Criteria cri) {
	  
		
	  log.info("게시판 리스트 목록 페이지 진입");
	  if(param.get("amount") != null) {
	  new Criteria(Integer.parseInt(param.get("pageNum").toString()),Integer.parseInt(param.get("amount").toString()));
	  log.info(param.get("amount").toString());
	  }
	  log.info("cri : ", cri);
	  int total = boardServiceImpl.total();
	  PageMakerDTO pageMake = new PageMakerDTO(cri, total);
	  ModelAndView mav = new ModelAndView();	  
	  mav.addObject("pageMaker", pageMake);
	  mav.setViewName("board/list");
	  
	  return mav; 
	  }
	 
	
	
	
	  @ResponseBody 
	  @GetMapping("selectTengrid") 
	  public ResponseEntity<?>selectlistgrid(@RequestParam Map<String, Object> param, HttpServletRequest request) {
      List<Map<String, Object>> listMap = boardServiceImpl.getDataList("grid.selectlistPaging", param);       
      
      Map<String,Object> list = new HashMap<>();
	  list.put("listMap", listMap); 
	  final HttpHeaders httpHeaders = new HttpHeaders();
	  httpHeaders.setContentType(MediaType.APPLICATION_JSON);
	  log.info("selectTengridgrid"); 
	  return new ResponseEntity(list, httpHeaders,HttpStatus.OK); 
	  }
	 

	@GetMapping("detail")
	public ModelAndView detail(@RequestParam Map<String, Object> param) {

		log.info("detail 진입");
		Map<String, Object> detailData = commonService.getData("grid.detailView", param);

		ModelAndView mav = new ModelAndView();
		mav.addObject("bno", detailData.get("BNO"));
		mav.addObject("title", detailData.get("TITLE"));
		mav.addObject("content", detailData.get("CONTENT"));
		mav.addObject("category", detailData.get("CATEGORY"));
		mav.addObject("writer", detailData.get("WRITER"));
		mav.addObject("REGDATE", detailData.get("REGDATE"));

		mav.setViewName("board/detail");

		return mav;
	}

	@GetMapping("update")
	public ModelAndView update(@RequestParam Map<String, Object> param) {
		log.info("update 진입");
		System.out.println(param.toString());

		Map<String, Object> detailData = commonService.getData("grid.detailView", param);
		ModelAndView mav = new ModelAndView();
		System.out.println(detailData.toString());
		mav.addObject("data", detailData);
		mav.setViewName("board/update");

		log.info("update 뿌려주기 진입");
		return mav;
	}

	// 나는 업데이트해서 갱신해주는 걸 해줘야 함.

	@ResponseBody
	@PostMapping("renew")
	public Map renew(@RequestParam Map<String, Object> param) {
		Map<String, Object> renewData = new HashMap<>();
		log.info("renew 진입");
		System.out.println(param.toString()); // ex BNO=24 값 들어감

		renewData.put("result", boardServiceImpl.renew(param));

		return renewData;
	}

	@ResponseBody
	@PostMapping("delete")
	public Map delete(@RequestParam Map<String, Object> param) {
		Map<String, Object> renewData = new HashMap<>();
		log.info("delete");
		System.out.println(param.toString()); // ex BNO=24 값 들어감

		boardServiceImpl.delete(param);

		return renewData;

	}

}
