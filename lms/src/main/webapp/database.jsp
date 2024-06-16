<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <!-- 홈 버튼을 포함한 컨테이너 -->
    <div class="home-button-container">
        <div class="home-button">
            <a href="index.jsp">🏠 홈으로</a>
            <a href="enrolled.jsp">🔙 수강신청된 과목으로</a>
        </div>
    </div>
    <!-- 메인 컨테이너 -->
    <div class="container">
        <h1>Database</h1>
        <!-- 출석 테이블 -->
        <table class="attendance-table">
            <thead>
                <tr>
                    <th>주차</th>
                    <th>1교시</th>
                    <th>2교시</th>
                    <th>3교시</th>
                </tr>
            </thead>
            <tbody>
                <!-- 1주차부터 7주차까지 반복 -->
                <% for (int i = 1; i <= 7; i++) { %>
                <tr>
                    <td><%= i %>주차</td>
                    <!-- 1교시 출석 버튼 -->
                    <td>
                        <form action="attendanceCode.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="week" value="<%= i %>">
                            <input type="hidden" name="session" value="1">
                            <input type="hidden" name="course" value="Database">
                            <button type="submit">1</button>
                        </form>
                    </td>
                    <!-- 2교시 출석 버튼 -->
                    <td>
                        <form action="attendanceCode.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="week" value="<%= i %>">
                            <input type="hidden" name="session" value="2">
                            <input type="hidden" name="course" value="Database">
                            <button type="submit">2</button>
                        </form>
                    </td>
                    <!-- 3교시 출석 버튼 -->
                    <td>
                        <form action="attendanceCode.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="week" value="<%= i %>">
                            <input type="hidden" name="session" value="3">
                            <input type="hidden" name="course" value="Database">
                            <button type="submit">3</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>


