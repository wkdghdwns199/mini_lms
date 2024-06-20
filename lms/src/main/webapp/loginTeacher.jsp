<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Teacher Login</title>
    <style>
        /* 전체적인 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 컨테이너 스타일 */
        .container {
            width: 80%;
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* 제목 스타일 */
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* 폼 스타일 */
        form {
            display: flex;
            flex-direction: column;
        }

        /* 레이블 스타일 */
        label {
            margin-bottom: 10px;
            color: #333;
        }

        /* 입력 필드 스타일 */
        input[type="text"],
        input[type="password"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* 제출 버튼 스타일 */
        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* 제출 버튼 호버 효과 */
        input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* 링크 스타일 */
        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            text-decoration: none;
            font-size: 16px;
            color: #333;
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        .links a:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Teacher Login</h2>
        <form action="loginTeacher" method="post">
            <label for="userId">아이디 :</label>
            <input type="text" id="userId" name="userId" required><br>
            <label for="password">비밀번호 :</label>
            <input type="password" id="password" name="password" required><br>
            <input type="submit" value="Login">
        </form>
        <div class="links">
            <a href="loginStudent.jsp"><label>학생으로 로그인</label></a>

        </div>
    </div>
</body>
</html>
