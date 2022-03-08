<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include libraries(jQuery, bootstrap) --> 
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

 <!-- 서머노트를 위해 추가해야할 부분 -->
  <%-- <script src="${pageContext.request.contextPath}/resources/sss/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/resources/sss/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sss/summernote-lite.css">
 --%>
	<link rel="stylesheet" href="/node_modules/tui-grid/dist/tui-grid.min.css">
   <script src="/node_modules/tui-grid/dist/tui-grid.min.js"></script>
   <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script src = "/resources/js/common.js"></script>
<style>

</style>
	

</head>
<body>
<script>
		
	
		$("#renewBtn").click(function(){
				reNew();
				console.dir("되는건가?");
		});

		function reNew(){	 
				util.requestSync("board/renew?BNO="+${data.BNO}, $("#frmupdate").serialize(), 'POST', updateCallback);	
		};

		function updateCallback(res){
			console.dir(res);
			
			if(res.result == "success"){
				
			//다시 리스트로 업데이트 내용을 뿌려줘야함
			util.showLoad("board/detail?BNO="+${data.BNO}, '상세페이지');	
			}
		};
</script>		
		<h4><b>책 수정</b></h4>
		<hr>
		<form action="/board/renew" method="post" id="frmupdate">	
<select name="category" value= style="padding:0px 0px 0px 2px; margin-left:10px;">

        <option value="${data.CATEGORY}" ><option>
        <option value="freeboard" selected>자유게시판</option>
        <option value="simpleboard">간편게시판</option>
        <option value="selfappeal">자기소개(등업요청)</option>
        <option value="portpolio">포트폴리오(요청사항)</option>

   		</select>
   		<br>
   		<br>
	
		<input type="text" name="title" value="${data.TITLE}" id="title" size="100" style="margin-left:10px;">
		</input><br><br>
		<input type="text" name="content" value="${data.CONTENT}" id="content" style="width:700px; height:250px;" ></input><br>
		<br>
	
		
		
		<input type="button" id="renewBtn" value="수정" style="margin-left:18px;" ></input>
			
		</form>
		

</body>
</html>