<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>출석 확인</title>
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
        /* 컨테이너 스타일 */
        .container {
            width: 400px;
            padding: 20px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            text-align: center; /* 텍스트 가운데 정렬 */
        }
        h1 {
            margin-bottom: 20px;
        }
        /* 돌아가기 버튼 스타일 */
        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="center-content">
        <div class="container">
            <h1>출석 확인</h1>
            <!-- 출석 확인 메시지 표시 -->
            <p><%= request.getParameter("week") %>주차 <%= request.getParameter("session") %>교시 출석이 확인되었습니다.</p>
            <%
                // 과목 정보를 기반으로 돌아갈 페이지 결정
                String course = request.getParameter("course");
                String returnPage = "";
                if ("Database".equals(course)) {
                    returnPage = "database.jsp";
                } else if ("Computer Structure".equals(course)) {
                    returnPage = "computerStructure.jsp";
                } else if ("Open Source Software".equals(course)) {
                    returnPage = "openSourceSoftware.jsp";
                }
            %>
            <!-- 돌아가기 버튼 -->
            <a href="<%= returnPage %>" class="back-button">돌아가기</a>
        </div>
    </div>
</body>
</html>
