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
        .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card .info {
            display: flex;
            flex-direction: column;
        }
        .card .info span {
            margin-bottom: 5px;
        }
    </style>
    <script>
        function checkAttendance(classId, checkCode) {
            if (checkCode !== null) {
                window.location.href = "attendanceCode.jsp?classId=" + classId;
            } else {
                alert("출석 번호가 없습니다!");
            }
        }
    </script>
</head>
<body>
    <div class="home-button-container">
        <div class="home-button">
            <a href="index.jsp">🏠 홈으로</a>
        </div>
    </div>
    
    <div class="container">
        <h1>강의 목록</h1>
        <%
            String studentId = (String) session.getAttribute("userId");
            ClassDAO classDAO = new ClassDAO();
            List<ClassInfo> enrolledCourses = classDAO.getEnrollClasses(studentId);
            
            if (enrolledCourses != null) {
                for (ClassInfo course : enrolledCourses) {
                    String coursePage = "javascript:checkAttendance('" + course.getClassId() + "', '" + course.getCheckCode() + "')";
        %>
        <a href="<%= coursePage %>" class="card">
            <div class="info">
                <span><strong>강의명:</strong> <%= course.getClassName() %></span>
                <span><strong>강의코드:</strong> <%= course.getClassId() %></span>
                <span><strong>담당교수:</strong> <%= course.getTeacherName() %></span>
            </div>
        </a>
        <% 
                }
            } else {
        %>
        <p>No courses enrolled.</p>
        <% } %>
    </div>
</body>
</html>
