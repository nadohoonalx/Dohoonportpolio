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
<style>
	#category {
		width : 300;
	}
	
	#gle {
	 font-size : 50px;
	}
	
	#doc {
    width:1370px;
    clear: both;
    /* margin: 0 auto; */
    border: 0 none;
    background: #ffffff none repeat scroll 0 0;
    outline: 0 none;
    padding: 0;
}
	#dropzone {
    border:2px solid black;
    width:100%;
    height:150px;
    color:black;
    text-align:left;
    font-size:10px;
    padding-top:5px;
    margin-top:5px;
}

#downloadzone {
    border:2px solid #3292A2;
    width:50%;
    height:230px;
  
    text-align:left;
    font-size:1px;
    padding-top:1px;
    margin-top:1px;
}

#dropzonecheck {
 border:2px  solid black;
    width:40%;
   height:30px;
    color:#92AAB0;
    text-align:center;
    font-size:10px;
  
}

button3{
	width:50%;
	height:50%;
}
</style>
<script>

$(function(){
	//다운로드
	var obj = $("#dropzone");
    obj.on('dragenter', function (e) {
         e.stopPropagation();  //상위 노드로 가는 이벤트를 멈춘다.
         e.preventDefault();  //현재 객체에 있는 모든 실행요소를 멈춘다.
         $(this).css('border', '2px solid #5272A0');
    });
    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');
    });
    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    obj.on('drop', function (e) {
        e.preventDefault();
        $(this).css('border', '2px dotted #8296C2');
        var files = e.originalEvent.dataTransfer.files;
        if(files.length < 1)
            return;
                  
        for(var i = 0; i < files.length; i++) {
            var file = files[i];
        }
        F_FileMultiUpload(files, obj);
    });

    //파일 멀티 업로드
    function F_FileMultiUpload(files, obj) {
         if(confirm(files.length + "개의 파일을 업로드 하시겠습니까?") ) {
             var data = new FormData();
             for (var i = 0; i < files.length; i++) {
                data.append('files', files[i]);
               
             }
             var url = "/board/upload3";                  
             $.ajax({
                url: url,
                method: 'POST',
                data: data,
                dataType: 'json',
                processData: false,
                contentType: false,
                success: function(res) {
                	console.dir(res);
                    alert("업로드가 완료되었습니다.");
                    F_FileMultiUpload_Callback(res.files);
                    //util.requestSync("/board/selectgrid", null, "GET", result);
                	
                },
                error: function(res) {
                    alert("업로드 중에 에러가 발생했습니다. 파일은 10M를 넘을 수 없습니다.");
                }
             });
         }
    } 
    // 파일 멀티 업로드 Callback
    function F_FileMultiUpload_Callback(files, obj) {
    
    	console.dir(files);
    
        for(var i=0; i < files.length; i++) {
        	
        	$("#downloadzone").append(files[i].FILE_REALNAME + '<br>');
        }
    }    
});
	function regBoard(){
		util.requestSync('/board/enroll', $("#frm").serialize() , 'POST', result);
	}

	function result(res){
		console.dir(res);
		if(res.result == "success"){
			alert("저장되었습니다");
			util.showLoad('board/list', '게시물');
		}
		else {
			alert("실패했습니다");
		}
	}
	alert(1);
	$('#btnReg').click(function(){
		alert(123);
	});
	
</script>
</head>
<body>
		
		<h4><b>카페 글쓰기</b></h4>
		
		<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  파일 업로드
</button>

<div id="downloadzone">
	<input type="checkbox" value="되라"/>
	<hr>
	<p><input type="checkbox" name="all" class="check-all"> <label>Check ALL</label></p>
	<hr>
  
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
	      	<div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		         <span aria-hidden="true">&times;</span>
		        </button>
	      	</div>
		     <div class="modal-body">
			      <div id="dropzone">Drag & Drop Files Here</div> 	
			      </div>
			      <div class="modal-footer">
			      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
    </div>
  </div>
</div>
		
		
		<div id="grid"></div>
		<hr>
		
		<form action="/board/enroll" method="post" id="frm">
		
			<div id="category" >
				<select name="category" style="padding:0px 0px 0px 2px; margin-left:10px;">
		        <option value="freeboard">자유게시판</option>
		        <option value="simpleboard">간편게시판</option>
		        <option value="selfappeal">자기소개(등업요청)</option>
		        <option value="portpolio">포트폴리오(요청사항)</option>
		   		</select>
			</div>
	   		<br>
	   		<br>
			
			<div class="input_wrap">
				<input type="text" name="title" id="title" placeholder="제목을 입력해 주세요." size="100" style="margin-left:10px;" >
			</div>
			<br>
			<textarea rows="20" cols="90" name='content'></textarea>
			<br/>
			<br>
			<input type="button" value="등록" style="margin-left:18px;" id="btnReg" >
			
		</form>
		
		

</body>
</html>