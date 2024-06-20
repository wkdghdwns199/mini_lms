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

@WebServlet("/updateCheckCode")
public class UpdateCheckCodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String classId = request.getParameter("classId");

        Connection connection = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

            // class 테이블의 check_code를 null로 업데이트
            String updateClassSql = "UPDATE class SET check_code = NULL WHERE class_id = ?";
            pstmt = connection.prepareStatement(updateClassSql);
            pstmt.setString(1, classId);
            pstmt.executeUpdate();
            
            updateClassSql = "UPDATE attendance SET active = 0 WHERE class_id = ?";
            pstmt = connection.prepareStatement(updateClassSql);
            pstmt.setString(1, classId);
            pstmt.executeUpdate();

            // 성공 메시지 반환
            response.setContentType("text/plain");
            response.getWriter().write("Success");
            

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Error");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
