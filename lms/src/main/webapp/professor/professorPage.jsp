<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>교수 페이지</title>
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

        /* 레이아웃 스타일 */
        .layout {
            width: 80%;
            max-width: 1200px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-layout {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-image {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #ddd;
            margin-right: 20px;
        }

        .profile-name {
            font-size: 20px;
            font-weight: bold;
        }

        .home-layout {
            margin-bottom: 20px;
        }

        .home-button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .home-button:hover {
            background-color: #45a049;
        }

        .center-layout {
            width: 100%;
        }

        .subject-list {
            margin-bottom: 20px;
        }

        .subject-list h4 {
            margin-bottom: 10px;
            font-size: 18px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th,
        .table td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #f0f0f0;
            color: grey;
        }

        .subject-container {
            background-color: white;
        }

        .Check-button {
            padding: 8px 16px;
            font-size: 14px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .Check-button:hover {
            background-color: #45a049;
        }

        .register-class {
            text-align: center;
            margin-top: 20px;
        }

        .register-class button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .register-class button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

        Statement statement = connection.createStatement();
        ResultSet classSet = statement.executeQuery("select * from CLASS");
        String teacherID = (String) session.getAttribute("userId");
    %>

    <div class="layout">
        <div class="profile-layout">
            
            <div class="profile-name"><%= session.getAttribute("userName") %></div>
        </div>
            
        <div class="home-layout">
            <button class="home-button" onclick="location.href='/lms'">
                <p class="home-word">홈으로</p>
            </button>
        </div>

        <div class="center-layout">
            <div class="subject-list">
                <h4>과목 목록</h4>
                <table class="table">
                    <tr class="subject-container">
                        <th>과목명</th>
                        <th>과목코드</th>
                        <th>담당교수</th>
                        <th>출석체크</th>
                    </tr>
                    <% 
                        while(classSet.next()){ // 모든 클래스들에 대해서 
                            String sql = "SELECT teacher_name FROM teacher WHERE teacher_id = ?";
                            PreparedStatement pstmt = connection.prepareStatement(sql);
                            pstmt.setString(1, teacherID); // 4번째 컬럼에 있는 teacher_id 값을 설정

                            ResultSet rs = pstmt.executeQuery();

                            // 담당 교수님이 존재한다? 노노 우리가 원하는 것은 해당 수업이 담당 교수일 때를 원함.
                            if(!rs.next() || !classSet.getString(4).equals(teacherID)) {
                                continue;
                            }

                            String className = classSet.getString(3);
                            String teacherName = rs.getString("teacher_name");
                            String classId = classSet.getString(2);
                    %>
                    <tr class="subject-container">
                        <td><%= className %></td>
                        <td><%= classId %></td>
                        <td><%= teacherName %></td>
                        <td>
                            <form action="attendancePage.jsp" method="POST">
                                <input type="hidden" name="className" value="<%= className %>">
                                <input type="hidden" name="teacherName" value="<%= teacherName %>">
                                <input type="hidden" name="classId" value="<%= classId %>">
                                <input type="submit" class="Check-button" value="출석 확인">
                            </form>
                        </td>
                    </tr>
                    <% 
                        } 
                    %>
                </table>
            </div>
            <div class="register-class">
                <button onclick="location.href='classRegisterPage.jsp'">강의 등록</button>
            </div>
        </div>
    </div>

</body>
</html>
