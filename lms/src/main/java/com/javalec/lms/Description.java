package com.javalec.lms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/description")
public class Description extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        String classId = request.getParameter("classId");
        String description = request.getParameter("description");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","scott","tiger");

            String updateSql = "UPDATE class SET description = ? WHERE class_id = ?";
            PreparedStatement updatePstmt = connection.prepareStatement(updateSql);
            updatePstmt.setString(1, description);
            updatePstmt.setString(2, classId);
            updatePstmt.executeUpdate();
            updatePstmt.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("explain.jsp?classId=" + classId);
    }
}
