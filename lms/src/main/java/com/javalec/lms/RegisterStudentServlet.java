package com.javalec.lms;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/registerStudent")
public class RegisterStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        
        // 비밀번호 암호화
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        UserDAO userDAO = new UserDAO();
        try {
        	userDAO.saveUser(new User(userId, hashedPassword, userName, userEmail, 1));
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('회원가입에 성공하였습니다!'); window.location='index.jsp';</script>");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('회원가입이 실패하였습니다..'); window.location=registerStudent.jsp';</script>");
		}

        
    }
}
