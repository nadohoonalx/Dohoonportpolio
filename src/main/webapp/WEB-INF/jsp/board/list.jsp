<!DOCTYPE html>
<%@ page language="java" contentType="text/html;  charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page  isELIgnored="false" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>     

<%@ page session="false" %>
<html lang="ko">
      <html>

        <head>
        <meta charset="EUC-KR">
        <style>
        	 .pageInfo{
		      list-style : none;
		      display: inline-block;
		      margin: 100px 200px 200px 100px;
		      padding-left : 250px;      
		  	 }
			 .pageInfo li{
			    float: left;
			    font-size: 20px;
			    margin-left: 28px;
			    padding: 7px;
			    font-weight: 500;
			 }
			 
			 
			 .active{
			     background-color: #cdd5ec;
			 }

			 a:link {
			 	color:black; 
			 	text-decoration: none;
			 }
			 a:visited {
			 	color:black; 
			 	text-decoration: none;
			 }
			 a:hover {
			 	color:black; 
			 	text-decoration: underline;
			 }
			 
        </style>
            <link rel="stylesheet" href="/node_modules/tui-grid/dist/tui-grid.min.css">
            <script src="/node_modules/tui-grid/dist/tui-grid.min.js"></script>
       		<script src = "/resources/js/common.js"></script>
     
        </head>

	
<script>

var grid = new tui.Grid({
    el: document.getElementById('boardgrid'),
   // data: [],
    scrollX: false,
    scrollY: false,
    columns: [{
        header: 'BNO',
        name: 'BNO',
        width : 100
    }, {
        header: 'CATEGORY',
        name: 'CATEGORY',
        width : 100
    }, {
        header: 'TITLE',
        name: 'TITLE',
        width : 450
    }, 
    
    {
        header: 'WRITER',
        name: 'WRITER',
        align : 'right',
        width : 170
    } , {
        header: 'REGDATE',
        name: 'REGDATE',
        align : 'center',
        width : 170
    }, {
        header: 'FILE_KEY',
        name: 'FILE_KEY',
        align : 'right',
        width : 170
    }],
    columnOptions: {
    	frozenCount: 4,
    	frozenBorderWidth: 2,
    	minWidth: 300
    }
});

	util.requestSync("/board/selectTengrid?amount="+${pageMaker.cri.amount}+"&pageNum="+${pageMaker.cri.pageNum}, null, "GET", result);	
		

		function result(res){
		
			grid.resetData(res.listMap);
			
		
		}
	
		
	
	  
		grid.on('dblclick', (e) => {
			
			if(e.columnName == 'TITLE' ){
				
		    var BNO = grid.getValue(e.rowKey, "BNO");
			 	 					
		 	EnterDetail(BNO);
			 
			}	
		
		});
					
	
	function EnterDetail(BNO){
		
			
			util.showLoad("/board/detail?BNO="+BNO, '등록페이지');
			//util.requestSync("/board/detail?BNO="+BNO,	null, "GET", result2);
			
			//아래 콜백으로 detail return 값이 넘어와서 그 Map 안에 들어있는 값을 처리하면 된다.
	}; 
	
	
	
	
</script>
 <body>
 	
 					<!--selectbox  -->
 				<div id="select">				
 				<select onchange="getUserDisplay(this.value)">
 			    <option value="5" <c:out value="${pageMaker.cri.amount eq '5'? 'selected':'' }"/>>5개씩</option>
                <option value="10" <c:out value="${pageMaker.cri.amount eq '10'? 'selected':'' }"/>>10개씩</option>
                <option value="15" <c:out value="${pageMaker.cri.amount eq '15'? 'selected':'' }"/>>15개씩</option>
                <option value="20" <c:out value="${pageMaker.cri.amount eq '20'? 'selected':'' }"/>>20개씩</option>
               
 				</select>
 				</div>			
 	<div id="boardgrid"></div>
 			
 	<div class="pageInfo_wrap" >
		<div class="pageInfo_area">
			<ul id="pageInfo" class="pageInfo">
			
				<!-- 이전페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
				</c:if>
				
				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }">
					<a href= "javascript:util.showLoad('board/list?pageNum='+${num}+'&amount='+${pageMaker.cri.amount}, '게시물');">${num}</a>
					</li>
		
				</c:forEach>
				
				<!-- 다음페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>	
				
			</ul>
		</div>
	</div>
 			
 			
 			
 			
 			<!--테이블에 값들 뿌려줘서 페이징이랑 같이 구현해보기  -->
				
				
				
				<!--여기는 페이징 구현해서 값 ?  -->
		<script>
		  function getUserDisplay(val) {
		      console.log(val);
		      
		      if(val) 
		    	  util.showLoad('/board/list?pageNum='+${pageMaker.cri.pageNum}+'&amount=' +val, '게시물');
		    	  //location.href = '/board/list?page=1&userDisplay=' + val + '&kind=${kind}';
		    }
		
		</script>
	</body>
  </html>