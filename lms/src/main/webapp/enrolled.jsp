<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javalec.lms.ClassInfo" %>
<%@ page import="com.javalec.lms.ClassDAO" %>
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
    <script>
        function checkAttendance(classId) {
            // 비동기 요청을 통해 check_code 값을 확인
            fetch('checkAttendance.jsp?classId=' + classId)
                .then(response => response.text())
                .then(data => {
                    if (data.trim() === 'valid') {
                        window.location.href = 'confirmAttendance.jsp?classId=' + classId;
                    } else {
                        alert('출석 번호가 없습니다!');
                    }
                });
        }
    </script>
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
            String studentId = (String) session.getAttribute("userId");
            ClassDAO classDAO = new ClassDAO();
            List<ClassInfo> enrolledCourses = classDAO.getEnrollClasses(studentId);
            if (enrolledCourses != null) {
                // 각 강의에 대해 페이지 경로를 설정하고 링크를 생성
                for (ClassInfo course : enrolledCourses) {
        %>
        <!-- 강의 정보를 카드 형식으로 표시 -->
        <div class="card" onclick="checkAttendance('<%= course.getClassId() %>')">
            <div class="info">
                <span><strong>강의명:</strong> <%= course.getClassName() %></span>
                <span><strong>강의코드:</strong> <%= course.getClassId() %></span>
                <span><strong>담당교수:</strong> <%= course.getTeacherName() %></span>
            </div>
        </div>
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
