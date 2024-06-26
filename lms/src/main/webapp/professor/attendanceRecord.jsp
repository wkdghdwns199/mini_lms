<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance History</title>
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
            cursor: pointer;
        }
    </style>
    <script>
        function viewAttendanceDetails(attendanceHistoryId, classId) {
            window.location.href = 'attendanceDetails.jsp?attendanceHistoryId=' + attendanceHistoryId + '&classId=' + classId;
        }
    </script>
</head>
<body>
<div class="layout">
    <h1>Attendance History</h1>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Attendance History ID</th>
                <th>Class ID</th>
                <th>Success Time</th>
                <th>Late Time</th>
            </tr>
        </thead>
        <tbody>
        <%
            String classId = request.getParameter("classId");

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

            String sql = "SELECT DATE_STRING, ATTENDANCE_HISTORY_ID, CLASS_ID, SUCCESS_TIME, LATE_TIME " +
                         "FROM attendance_history " +
                         "WHERE class_id = ? " +
                         "ORDER BY DATE_STRING DESC";

            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, classId);
            ResultSet rs = pstmt.executeQuery();
				
            while (rs.next()) {
           		
                String dateString = rs.getString("DATE_STRING");
                String attendanceHistoryId = rs.getString("ATTENDANCE_HISTORY_ID");
                String classIdValue = rs.getString("CLASS_ID");
                Timestamp successTime = rs.getTimestamp("SUCCESS_TIME");
                Timestamp lateTime = rs.getTimestamp("LATE_TIME");
        %>
            <tr onclick="viewAttendanceDetails('<%= attendanceHistoryId %>', '<%= classIdValue %>')">
                <td><%= dateString %></td>
                <td><%= attendanceHistoryId %></td>
                <td><%= classIdValue %></td>
                <td><%= successTime %></td>
                <td><%= lateTime %></td>
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
