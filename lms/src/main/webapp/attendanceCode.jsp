<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String classId = request.getParameter("classId"); %>
<!DOCTYPE html>
<html>
<head>
    <title>출석 코드 입력</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        /* 중앙 정렬을 위한 스타일 */
        .center-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        /* 폼 요소 중앙 정렬 */
        .center-content form {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        /* 라벨과 입력 필드 사이의 간격 조정 */
        .center-content label {
            margin-right: 10px;
        }
        /* 입력 필드와 버튼 사이의 간격 조정 */
        .center-content input[type="text"] {
            margin-right: 10px;
        }
        /* 컨테이너 스타일 */
        .container {
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div class="center-content">
        <div class="container">
            <h1>출석 코드 입력</h1>
            <!-- 출석 코드 입력 폼 -->
            <form action="confirmAttendance.jsp?classId=<%= classId %>" method="post">
                <label for="code">출석 코드:</label>
                <input type="text" id="code" name="code" required>
                <button type="submit">확인</button>
            </form>
        </div>
    </div>
</body>
</html>
