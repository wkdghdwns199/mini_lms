<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    max-width: 800px;
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

/* 카드 스타일 */
.card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    margin-bottom: 10px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    cursor: pointer;
}

/* 카드 호버 효과 */
.card:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* 카드 내부 정보 섹션 스타일 */
.card .info {
    display: flex;
    flex-direction: column;
}

/* 각 정보 항목 스타일 */
.card .info span {
    margin-bottom: 5px;
}

/* 카드 선택 섹션 스타일 */
.card .select {
    display: flex;
    align-items: center;
}

/* 액션 버튼 스타일 */
.actions {
    text-align: center;
    margin-top: 20px;
}

/* 홈 버튼 컨테이너 스타일 */
.home-button-container {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

/* 홈 버튼 스타일 */
.home-button {
    margin: 0 10px;
}

/* 홈 버튼 링크 스타일 */
.home-button a {
    text-decoration: none;
    font-size: 16px;
    color: #333;
    padding: 10px 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    display: inline-block;
    transition: background-color 0.3s ease;
}

/* 홈 버튼 호버 효과 */
.home-button a:hover {
    background-color: #f0f0f0;
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

/* 출석 테이블 스타일 */
.attendance-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

/* 출석 테이블 헤더 스타일 */
.attendance-table th,
.attendance-table td {
    padding: 10px;
    text-align: center;
}

/* 출석 테이블 헤더 배경색 */
.attendance-table th {
    background-color: #f0f0f0;
}

/* 출석 테이블 셀 배경색 */
.attendance-table td {
    background-color: #fff;
}

/* 출석 테이블 버튼 스타일 */
.attendance-table td button {
    padding: 10px 40px; /* 가로로 더 넓게 설정 */
    border: 2px solid #888; /* 테두리 두께 설정 */
    border-radius: 5px;
    background-color: transparent;
    color: #333;
    cursor: pointer;
    transition: background-color 0.3s ease, border-color 0.3s ease;
}

/* 출석 테이블 버튼 호버 효과 */
.attendance-table td button:hover {
    background-color: #f0f0f0;
    border-color: #4CAF50;
}

/* 출석 테이블 첫 번째 셀 외의 셀의 왼쪽 테두리 제거 */
.attendance-table tr td:not(:first-child) {
    border-left: none;
}
</style>
</head>
<body>
    <div class="container">
        <h1>Hello LMS</h1>
        <%
            String userName = (String) session.getAttribute("userName");
            Integer ifStudent = (Integer) session.getAttribute("ifStudent");
            if (userName != null && ifStudent != null) {
                if (ifStudent == 1) {
                    out.println("<h2>" + userName + "님</h2>");
                    %>
                    <div class="home-button-container">
                        <div class="home-button"><a href="enrolled.jsp">강의 목록</a></div>
                        <div class="home-button"><a href="enroll.jsp">수강신청</a></div>
                    </div>
                    <%
                } else {
                    out.println("<h2>" + userName + " 교수님</h2>");
                    %>
                    <div class="home-button-container">
                        <div class="home-button"><a href="./professor/professorPage.jsp">강의 목록</a></div>
                   
                    </div>
                    <%
                }
        %>
                <div class="actions">
                    <form action="logout" method="post">
                        <input type="submit" value="로그아웃">
                    </form>
                </div>
        <%
            } else {
        %>
        <div class="home-button-container">
            <div class="home-button"><a href="loginStudent.jsp">로그인</a></div>
            <div class="home-button"><a href="registerStudent.jsp">회원가입</a></div>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
