<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강의 설명 저장</title>
</head>
<body>
<%
    // 파라미터 가져오기
    String classId = request.getParameter("classId");
    String newDescription = request.getParameter("newDescription");

    if (classId != null && newDescription != null) {
        // 데이터베이스 연결
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","scott","tiger");

        // SQL 업데이트
        String updateSql = "UPDATE class SET description = ? WHERE class_id = ?";
        PreparedStatement updatePstmt = connection.prepareStatement(updateSql);
        updatePstmt.setString(1, newDescription);
        updatePstmt.setString(2, classId);
        int rowsUpdated = updatePstmt.executeUpdate();

        updatePstmt.close();
        connection.close();

        if (rowsUpdated > 0) {
            out.println("<script>alert('저장이 완료되었습니다.');</script>");
        } else {
            out.println("<script>alert('저장에 실패했습니다. 다시 시도해주세요.');</script>");
        }
    } else {
        out.println("<script>alert('잘못된 요청입니다.');</script>");
    }

    // 페이지 리다이렉트
    String redirectURL = "yourMainJSPFile.jsp?classId=" + classId;
    response.sendRedirect(redirectURL);
%>
</body>
</html>
