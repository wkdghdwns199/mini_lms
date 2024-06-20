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
                <th>Attendance</th>
            </tr>
        </thead>
        <tbody>
        <%
            String classId = request.getParameter("classId");
			String studentId = (String) session.getAttribute("userId");
			
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

            String sql = "SELECT DATE_STRING, ATTENDANCE_HISTORY_ID, CLASS_ID, SUCCESS_TIME, LATE_TIME " +
                         "FROM attendance_history " +
                         "WHERE class_id = ?" +
                         "ORDER BY DATE_STRING DESC";

            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, classId);
            ResultSet rs = pstmt.executeQuery();
				
            while (rs.next()) {
            	sql = "SELECT ATTENDANCE_STATUS " +
                        "FROM attendance " +
                        "WHERE class_id = ? and student_id = ? and attendance_history_id = ?";
                        
            
            	pstmt = connection.prepareStatement(sql);
                pstmt.setString(1, classId);
                pstmt.setString(2, studentId);
                pstmt.setString(3, rs.getString("ATTENDANCE_HISTORY_ID"));
                ResultSet rs2 = pstmt.executeQuery();
                
                if (rs2.next()){
                	String attendanceStatus = "";
                    int status = rs2.getInt("ATTENDANCE_STATUS");
                    if (status == 0) {
                        attendanceStatus = "결석";
                    } else if (status == 1) {
                        attendanceStatus = "지각";
                    } else if (status == 2) {
                        attendanceStatus = "출석";
                    }
        %>
            <tr>
                <td><%= rs.getString("DATE_STRING") %></td>
                <td><%= attendanceStatus %></td>
                
            </tr>
        <%
                }
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
