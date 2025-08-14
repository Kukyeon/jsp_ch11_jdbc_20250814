<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>

	<h2>회원가입</h2>
	<hr>
	<form action="memberJoinOk.jsp" method="post">
		아이디 : <br><input type="text" name="mid"><br>
		비밀번호 :<br> <input type="password" name="mpw"> <br>
		이름 : <br><input type="text" name="mname"> <br>
		이메일 : <br><input type="text" name="memail"> <br>
		<br><input type="submit" value="회원가입">
	
	</form>
	

</body>
</html>