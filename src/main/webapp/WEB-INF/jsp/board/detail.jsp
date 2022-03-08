<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
        <html>

        <head>
           <!--  <link rel="stylesheet" href="/node_modules/tui-grid/dist/tui-grid.min.css">
            <script src="/node_modules/tui-grid/dist/tui-grid.min.js"></script>
       		<script src="/node_modules/tui-grid/dist/jquery.min.js"></script>
      -->
        </head>

	

 
 	
 	<body>
 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
         
 	<form method="POST" id="frmupdate" action="board/update">
		<h1>책 상세</h1>
		<p>번호 : ${ bno } </p>
		<p>제목 : ${ title } </p>
		<p>내용 : ${ content } </p>
		<p>카테고리 : ${category }</p>
		<p>글쓴이 : ${writer}</p>
		<p>입력일 : "${REGDATE}</p>
		<p>입력일2 : <fmt:formatDate value="${REGDATE}" pattern="yyyy.MM.dd HH:mm:ss" /></p>
		<input type="hidden" name="bno" value="${bno}" />
		</form>
		<p>
			<button type="button" onclick="delete1()">삭제</button>
			<button type="button" onclick="update()">수정</button>
	    	<button type="button" onclick="list()">목록</button>
		</p>
		
		<script>
	
	function list(){
		util.showLoad('board/list', '그리드');
	};
	
	function update(){
		util.showLoad("board/update?BNO="+ ${bno}, '수정하기');
	};
	
	function delete1(){
		util.requestSync("board/delete?BNO="+ ${bno}, null, 'POST', result);
	};
	
	function result(res){
		if(res.result="success"){
		util.showLoad('board/list', '목록');
		}
	};
	
</script>
	</body>
  </html>
  
  