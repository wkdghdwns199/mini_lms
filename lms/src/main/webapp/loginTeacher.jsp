<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Teacher Login</title>
</head>
<body>
    <h2>Teacher Login</h2>
    <form action="loginTeacher" method="post">
        <label for="userId">아이:</label>
        <input type="text" id="userId" name="userId" required><br>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <a href=loginStudent.jsp><label>학생으로 로그인</label></a>
    <label>교수 로그인</label>
</body>
</html>