<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>강의 등록 페이지</title>
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
        h1 {
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
        input[type="text"] {
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
        
          #description {
		    padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
		  }
    </style>
</head>
<body>
    <div class="container">
        <h1>강의 등록</h1>
        <form action="/lms/classRegister" method="post">
            <label for="classId">강의 코드 :</label>
            <input type="text" id="classId" name="classId" required><br>
            <label for="className">강의 이름 :</label>
            <input type="text" id="className" name="className" required><br>
            <label for="className">강의 설명 :</label>
            <textarea id="description" name="description" rows="10" cols="50" required></textarea>
            <input type="submit" value="강의 등록">
        </form>
    </div>
</body>
</html>
