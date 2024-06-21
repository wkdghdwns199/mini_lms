package com.javalec.lms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteClass")
public class DeleteClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String classId = request.getParameter("classId");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

            String deleteSql = "DELETE FROM class WHERE class_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(deleteSql);
            pstmt.setString(1, classId);
            pstmt.executeUpdate();

            pstmt.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("professorPage.jsp");
    }
}
