<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Details</title>
    <style>
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

        .layout {
            width: 80%;
            max-width: 1200px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
<div class="layout">
    <h1>Attendance Details</h1>
    <table>
        <thead>
            <tr>
                <th>Attendance History ID</th>
                <th>Class ID</th>
                <th>Student ID</th>
                <th>Attendance Status</th>
            </tr>
        </thead>
        <tbody>
        <%
            String attendanceHistoryId = request.getParameter("attendanceHistoryId");
            String classId = request.getParameter("classId");

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

            String sql = "SELECT ATTENDANCE_HISTORY_ID, CLASS_ID, STUDENT_ID, ATTENDANCE_STATUS " +
                         "FROM attendance " +
                         "WHERE ATTENDANCE_HISTORY_ID = ?";

            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, attendanceHistoryId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String attendanceHistoryIdValue = rs.getString("ATTENDANCE_HISTORY_ID");
                String classIdValue = rs.getString("CLASS_ID");
                String studentId = rs.getString("STUDENT_ID");
                int attendanceStatus = rs.getInt("ATTENDANCE_STATUS");

                String attendanceStatusStr;
                if (attendanceStatus == 0) {
                    attendanceStatusStr = "결석";
                } else if (attendanceStatus == 1) {
                    attendanceStatusStr = "지각";
                } else {
                    attendanceStatusStr = "출석";
                }
        %>
            <tr>
                <td><%= attendanceHistoryIdValue %></td>
                <td><%= classIdValue %></td>
                <td><%= studentId %></td>
                <td><%= attendanceStatusStr %></td>
            </tr>
        <%
            }
            rs.close();
            pstmt.close();
            connection.close();
        %>
        </tbody>
    </table>
</div>
</body>
</html>
