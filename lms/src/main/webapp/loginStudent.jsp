<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Student Login</title>
</head>
<body>
    <h2>Student Login</h2>
    <form action="loginStudent" method="post">
        <label for="userId">아이디 :</label>
        <input type="text" id="userId" name="userId" required><br>
        <label for="password">비밀번호 :</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <label>학생으로 로그인</label>
    <a href=loginTeacher.jsp><label>교수 로그인</label></a>
</body>
</html>
