<%@ page import="java.util.List" %>
<%@ page import="com.javalec.lms.CourseBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enrolled Courses</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        /* 카드 스타일 정의 */
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
            text-decoration: none;
            color: inherit;
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
    </style>
</head>
<body>
    <!-- 홈으로 이동하는 버튼 -->
    <div class="home-button-container">
        <div class="home-button">
            <a href="index.jsp">🏠 홈으로</a>
        </div>
    </div>
    
    <!-- 강의 목록 컨테이너 -->
    <div class="container">
        <h1>강의 목록</h1>
        <%
            // 세션에서 등록된 강의 목록을 가져옴
            List<CourseBean> enrolledCourses = (List<CourseBean>) session.getAttribute("enrolledCourses");
            if (enrolledCourses != null) {
                // 각 강의에 대해 페이지 경로를 설정하고 링크를 생성
                for (CourseBean course : enrolledCourses) {
                    String coursePage = "";
                    switch (course.getCourseCode()) {
                        case "146146":
                            coursePage = "database.jsp";
                            break;
                        case "123123":
                            coursePage = "computerStructure.jsp";
                            break;
                        case "234123":
                            coursePage = "openSourceSoftware.jsp";
                            break;
                    }
        %>
        <!-- 강의 정보를 카드 형식으로 표시 -->
        <a href="<%= coursePage %>" class="card">
            <div class="info">
                <span><strong>강의명:</strong> <%= course.getCourseName() %></span>
                <span><strong>강의코드:</strong> <%= course.getCourseCode() %></span>
                <span><strong>담당교수:</strong> <%= course.getProfessor() %></span>
            </div>
        </a>
        <% 
                }
            } else {
        %>
        <!-- 등록된 강의가 없을 경우 메시지 표시 -->
        <p>No courses enrolled.</p>
        <% } %>
    </div>
</body>
</html>
