<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
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

        .back-button, .edit-button, .save-button {
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

        .back-button:hover, .edit-button:hover, .save-button:hover {
            background-color: #45a049;
        }

        .hidden {
            display: none;
        }

        textarea {
            width: 100%;
            height: 150px;
            font-size: 16px;
            margin-top: 20px;
        }
    </style>
    <script>
        function toggleEdit() {
            var descriptionText = document.getElementById("descriptionText");
            var descriptionTextarea = document.getElementById("descriptionTextarea");
            var editButton = document.getElementById("editButton");
            var saveButton = document.getElementById("saveButton");

            if (descriptionText.classList.contains("hidden")) {
                descriptionText.classList.remove("hidden");
                descriptionTextarea.classList.add("hidden");
                editButton.classList.remove("hidden");
                saveButton.classList.add("hidden");
            } else {
                descriptionText.classList.add("hidden");
                descriptionTextarea.classList.remove("hidden");
                editButton.classList.add("hidden");
                saveButton.classList.remove("hidden");
            }
        }

        function saveDescription() {
            document.getElementById("descriptionForm").submit();
        }
    </script>
</head>
<body>
<%
    String classId = request.getParameter("classId");

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","scott","tiger");

    String description = null;
    String className = null;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        description = request.getParameter("description");
        String updateSql = "UPDATE class SET description = ? WHERE class_id = ?";
        PreparedStatement updatePstmt = connection.prepareStatement(updateSql);
        updatePstmt.setString(1, description);
        updatePstmt.setString(2, classId);
        updatePstmt.executeUpdate();
        updatePstmt.close();
    } else {
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
    }

    connection.close();
%>

<div class="layout">
    <h1>강의 설명: <%= className %></h1>
    <p id="descriptionText"><%= description %></p>
    <form id="descriptionForm" method="post" action="/lms/description">
        <textarea id="descriptionTextarea" name="description" class="hidden"><%= description %></textarea>
        <input type="hidden" name="classId" value="<%= classId %>">
        <input type=submit id="saveButton" class="save-button hidden" value="저장하기"/>
    </form>
    <button id="editButton" class="edit-button" onclick="toggleEdit()">수정하기</button>
    
    <button class="back-button" onclick="window.history.back()">뒤로 가기</button>
</div>
</body>
</html>
