<%@ page import="com.javalec.lms.CourseBean" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Enrollment</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        // 카드 클릭 시 체크박스의 체크 상태를 토글하는 함수
        function toggleCheckbox(event, checkboxId) {
            if (event.target.type !== 'checkbox') { // 이벤트 타겟이 체크박스가 아닌 경우에만 실행
                var checkbox = document.getElementById(checkboxId);
                checkbox.checked = !checkbox.checked; // 체크박스의 체크 상태를 반전시킴
            }
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
    
    <!-- 수강 신청 폼 -->
    <div class="container">
        <h1>수강 신청</h1>
        <form action="saveEnrollment.jsp" method="post">
            <%
                // CourseBean의 모든 과목 정보를 가져와서 리스트에 저장
                List<CourseBean> courses = CourseBean.getAllCourses();
                for (CourseBean course : courses) {
            %>
            <!-- 각 과목의 정보를 카드 형식으로 표시하고 클릭 시 체크박스를 체크 -->
            <div class="card" onclick="toggleCheckbox(event, '<%= course.getCourseCode() %>')">
                <div class="info">
                    <span><strong>강의명:</strong> <%= course.getCourseName() %></span>
                    <span><strong>강의코드:</strong> <%= course.getCourseCode() %></span>
                    <span><strong>담당교수:</strong> <%= course.getProfessor() %></span>
                </div>
                <div class="select">
                    <!-- 각 과목의 체크박스 -->
                    <input type="checkbox" id="<%= course.getCourseCode() %>" name="selectedCourses" value="<%= course.getCourseCode() %>">
                </div>
            </div>
            <% } %>
            <!-- 저장 버튼 -->
            <div class="actions">
                <input type="submit" value="Save">
            </div>
        </form>
    </div>
</body>
</html>
