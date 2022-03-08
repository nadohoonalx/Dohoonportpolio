<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head> 
<meta name="viewport" content="width=device-width, height=device-height, minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0"> 
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
       <link href="/resources/css/styles.css" rel="stylesheet" />
 	  <link href="/resources/css/login.css" rel="stylesheet" />
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <title>로그인 폼</title>
</head> 
<body> 
<header> 

</header> 


<form id='frm' action="common/enterPage" method="POST">
 
	<table>
		<tr>
			<td id="col1">아이디</td>
			<td><input type="text"></td>
			<td rowspan="2"><input type="submit"  >로그인</button></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password"></td>
		</tr>
		
	</table>
</form>

<script>
	function doReg(){
		('#frm').submit();
	}
</script>

<label>회원가입</label> 
<a href="/common/MemberRegist">회원가입</a>

<!-- 
1. 중간에 설정하게 만들고
한줄 아이디 
한줄 비밀번호 
로그인 오른쪽에 회원가입
그리고 폼으로 감싼다. 
 -->

</body> 
</html>

