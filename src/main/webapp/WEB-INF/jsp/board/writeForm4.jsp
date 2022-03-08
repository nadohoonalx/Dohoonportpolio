<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

   <link rel="stylesheet" href="/node_modules/tui-grid/dist/tui-grid.min.css">
   <script src="/node_modules/tui-grid/dist/tui-grid.min.js"></script>
   <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<style>
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
    border:2px dotted #3292A2;
    width:90%;
    height:50px;
    color:#92AAB0;
    text-align:center;
    font-size:24px;
    padding-top:12px;
    margin-top:10px;
}
</style>
<script>


$(function () {
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
                   util.requestSync("/board/selectgrid", null, "GET", result);
                	
                },
                error: function(res) {
                    alert("업로드 중에 에러가 발생했습니다. 파일은 10M를 넘을 수 없습니다.");
                }
             });
         }
    }
    // 파일 멀티 업로드 Callback
    function F_FileMultiUpload_Callback(files) {
    	// res -> Object
    	// Object > files[]
    	
    	console.log("filemultialfdcal");
    	console.dir(files);
        for(var i=0; i < files.length; i++) {
            var file = files[i];
        	console.dir(file);
        	//  $("#downloadzone").append("<a href='<c:url value='/board/getFileDownload'/>?filename="+ files[i] +"'>"+ files[i]+ "</a>\n");
        $("#downloadzone").append("<a href='/board/getFileDownload?GROUP_KEY="
        		+file.GROUP_KEY+"&FILE_KEY="+file.FILE_KEY+"'>"+file.FILE_REALNAME+"</a><br>");
    
        
      							  		}
    										} 
    function fnAlert(e, msg) {
        e.stopPropagation();
        alert(msg);
    }
});

const grid = new tui.Grid({
    el: document.getElementById('grid'),
   // data: [],
    scrollX: false,
    scrollY: false,
    columns: [{
        header: 'FILE_REALNAME',
        name: 'FILE_REALNAME'
    }, {
        header: 'FILE_NAME',
        name: 'FILE_NAME'
    }, {
        header: 'FILE_PATH',
        name: 'FILE_PATH',
        width : 100
    }, {
        header: 'FILE_LENGTH',
        name: 'FILE_LENGTH',
        align : 'right',
        width : 100
    } , {
        header: 'GROUP_KEY',
        name: 'GROUP_KEY',
        align : 'center',
        width : 400
    }, {
        header: 'FILE_KEY',
        name: 'FILE_KEY',
        align : 'right',
        width : 30
    }]
});


    
    function btnSearch(){
       
    	   util.requestSync("/board/selectgrid", null, "GET", result);
    	   alert('testHELLO');
    }
    
    function result(res){
    	grid.resetData(res); //const grid를 reset
    }
    
    
    
    function btnSearch2(){
        
 	   alert('btnSearch2');
 	}
    
   
    
    grid.on('click', (e) => {
    	console.log(e)
    	console.log(e.columnName + 'clicked!');
    });
    
    grid.on('dblclick', (e) => {
    	
    	 
    	 if(e.columnName == "FILE_REALNAME"){
    		 console.log("HELLO");
    		 var GROUP_KEY = grid.getValue(e.rowKey, "GROUP_KEY");
    		 var FILE_KEY = grid.getValue(e.rowKey, "FILE_KEY");
    		 console.log(GROUP_KEY);
    		 console.log(FILE_KEY);
    		 alert(GROUP_KEY);
    		 console.log(FILE_KEY);
    /* 		 
    		location.href='/board/getFileDownload?GROUP_KEY="
     		+GROUP_KEY+"&FILE_KEY="+FILE_KEY;		
     */	
     	  location.href="/board/getFileDownload?GROUP_KEY="
    	        		+GROUP_KEY+"&FILE_KEY="+FILE_KEY+"/"; 
    	 }
    	 
  
    });


</script>
</head>
 <body>
          <div id="dropzone">Drag & Drop Files Here</div>
    
     		 <br><br>** 첨부된 파일 목록<br>
    		 <div id="downloadzone"></div>
        	 <button onClick="btnSearch()">Search</button>
       	     <button onClick="btnSearch2()">Search2</button>
        
        <hr>
        <!--     <div id="grid"></div> -->
</body>
</html>