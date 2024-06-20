<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
   
    <title>Update Attendance Status</title>
</head>
<body>
<%
    String attendanceHistoryId = request.getParameter("attendanceHistoryId");
    String classId = request.getParameter("classId");

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

    String sql = "UPDATE attendance SET ATTENDANCE_STATUS = ? WHERE ATTENDANCE_HISTORY_ID = ? AND CLASS_ID = ? AND STUDENT_ID = ?";
    PreparedStatement pstmt = connection.prepareStatement(sql);

    Map<String, String[]> parameterMap = request.getParameterMap();
    for (String paramName : parameterMap.keySet()) {
        if (paramName.startsWith("attendanceStatus_")) {
            String studentId = paramName.substring("attendanceStatus_".length());
            int attendanceStatus = Integer.parseInt(request.getParameter(paramName));
            pstmt.setInt(1, attendanceStatus);
            pstmt.setString(2, attendanceHistoryId);
            pstmt.setString(3, classId);
            pstmt.setString(4, studentId);
            pstmt.executeUpdate();
        }
    }

    pstmt.close();
    connection.close();

    response.sendRedirect("attendanceDetails.jsp?attendanceHistoryId=" + attendanceHistoryId + "&classId=" + classId);
%>
</body>
</html>
   