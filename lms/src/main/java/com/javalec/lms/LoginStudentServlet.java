package com.javalec.lms;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/loginStudent")
public class LoginStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = null;
        try {
            user = userDAO.getUserByUserId(userId);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        if (user != null && BCrypt.checkpw(password, user.getPassword()) && user.getIfStudent() == 1) {
            HttpSession session = request.getSession();
            session.setAttribute("userName", user.getUserName());
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("ifStudent", 1);
            response.sendRedirect("index.jsp");
        } else {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('로그인에 실패하였습니다. 아이디와 패스워드를 확인해주세요.'); window.location='loginStudent.jsp';</script>");
        }
    }
}
