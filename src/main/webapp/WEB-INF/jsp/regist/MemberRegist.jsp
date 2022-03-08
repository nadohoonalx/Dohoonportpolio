<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<title>Insert title here</title>
	
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script src = "/resources/js/common.js"></script>
	
	
</head>
<body>
		
		<h3>시큐리티 회원가입중</h3>
		<div style="border": 1px solid; width:100%; height:50px; text-align:right;">${ServerInfo}</div>
		<form id ="form" name="frm" method="post" action="/common/joinMember">
		
		<fieldset>
		<div id="idRow">
		<span>아이디</span>
		<input type="text" name="writer" id="writer" minlength="2" maxlength="20"/>
		<div id="writerStatus"></div>
		<input type="button" value = "아이디 중복 확인" id="writerCheck" style="margin-left:18px;">
		</div>
		
		<div id="emailRow">
		<span>Email</span>
		<input type="text" name="email" id="email" /><br/>
		</div>
		
		<div id="passwordRow">
		<span>비밀번호</span>
		<input type="password" name="password" id="password" /><br/>
		</div>
		<div id="passwordRow2">
		<span>비밀번호확인</span>
		<input type="password" id="passwordCheck"/><br/>				
		</div>
		<div id="passwordStatus"></div>	
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="submit" value="완료" id="btnRegMember"/>
		
		</fieldset>
		</form>
		
		</body>
		
		 <script>
		
		 var csrfHeaderName = "${_csrf.headerName}";
		 var csrfTokenValue = "${_csrf.token}";
		 var passwordCheck;
		 
		 
		 $("#btnRegMember").click(){
			 doReg();
		 }
		
		 function doReg(){
			 util.requestSync('board/joinMember',$("#frm").serialize() , 'POST', result);
		 }
		
		 
		 function result(){
		    util.showLoad('')
		 };
		 
			
			$("#writer").keyup(function() {
			    writerCheck = false;
				var writer = $("#writer").val();
				if(!writer){
				$("#writerStatus").html("").css("margin-bottom", 0);
				}
			});
			
			
			$("#password").keyup(function() {
				passwordCheck = false;
				var password = $(this).val();
				var passwordCheck = $("#passwordCheck").val();
				$("#passwordStatus").html("");
				
				if(!password && !passwordCheck){
					$("#passwordStatus").html("").css("margin-bottom", 0);
					return;
				}
				if(password !== passwordCheck) {
					$("#passwordStatus").html("").css("margin-bottom", 0);
					$("#passwordStatus").append("<span> 비밀번호가 일치하지 않습니다</span>");
					$("#passwordStatus").css({"color" : "red", "font-size": "10px"});
				
				}
				else {
					$("#passwordStatus").html("").css("margin-bottom", 0);
					$("#passwordStatus").append("<span> 두 비밀번호가 일치합니다</span>");
					$("#passwordStatus").css({"color" : "blue", "font-size": "10px"});
				  
				}
			});
		
			
		
			
			$("#passwordCheck").keyup(function() {
				passwordCheck = false;
				var password = $("#password").val();
				var passwordCheck = $(this).val();
				
				if(!password && !passwordCheck){
					$("#passwordStatus").html("").css("margin-bottom", 0);
					  //return; 위의 조건을 만족하면 해당 함수를 중단시킴
				}
				
				if(passwordCheck !== password) {
					$("#passwordStatus").html("").css("margin-bottom", 0);
					$("#passwordStatus").append("<span> 비밀번호체크와 일치하지 않습니다</span>");
					$("#passwordStatus").css({"color" : "red", "font-size": "10px"});
				 
				}
				else {
					$("#passwordStatus").html("").css("margin-bottom", 0);
					$("#passwordStatus").append("<span> 두 비밀번호가 일치합니다</span>");
					$("#passwordStatus").css({"color" : "blue", "font-size": "10px"});
					passwordCheck = true;
					/*아래꺼를 입력할 때 일치합니다라고 떠야 사용이 가능하다  */
				}
			});

		
			
		
		$("#writerCheck").click(function(){
			
			$("#writeStatus").html("");
			
			 var writer= $("#writer").val();
			 var data = { "writer" : writer};
				
			  $.ajax({
			  url : "/common/checkWriter",
			  data : data,
		      method : "POST",		     
		      dataType: 'json',		      
		      success : function(res) {
				
				alert("suceess" + res.result);
				//아이디가 없어서 추가
		    	if(res.result==0){
		    	$("#writeStatus").html("");
		        $("#writerStatus").append("<span> 아이디를 만들 수 있습니다. </span>");
		        $("#writerStatus").css("margin-bottom", "10px");
		        $("#writerStatus").css("color", "blue");
		        writerCheck = res.check;
		        console.log(writerCheck);
		    	}
		    	
		    	else {
		    		$("#writeStatus").html("");
		    		$('#writerStatus').append("아이디 사용이 불가능합니다");
	               	$('#writerStatus').css({"color": "red", "font-size": "10px"});
	               	writerCheck = false;
	               	console.log(writerCheck);
		        }

		      },
		      error : function(error) {
		        console.log(error);
		        alert(error.status);
		      }

			  });
		});
		
	
            
	</script>
</html>