<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강의 설명</title>
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
            max-width: 800px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            line-height: 1.6;
            text-align: justify;
        }

        .back-button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    String classId = request.getParameter("classId");

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","scott","tiger");

    String description = null;
    String className = null;

    String sql = "SELECT description, class_name FROM class WHERE class_id = ?";
    PreparedStatement pstmt = connection.prepareStatement(sql);
    pstmt.setString(1, classId);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        description = rs.getString("description");
        className = rs.getString("class_name");
    }

    if (description == null || description.trim().isEmpty()) {
        description = "없음";
    }

    rs.close();
    pstmt.close();
    connection.close();
%>

<div class="layout">
    <h1>강의 설명: <%= className %></h1>
    <p><%= description %></p>
    <button class="back-button" onclick="window.history.back()">뒤로 가기</button>
</div>
</body>
</html>
