package com.javalec.lms;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/classRegister")
public class RegisterClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
    	HttpSession session = request.getSession();
        String classId = request.getParameter("classId");
        String className = request.getParameter("className");
        String teacherId = (String) session.getAttribute("userId");
        String teacherName = (String) session.getAttribute("userName");
        
        
        
        ClassInfo classInfo = new ClassInfo(classId, className, teacherId,  "", teacherName);
        ClassDAO classDAO = new ClassDAO();
        if (classId != null && className!=null) {
            try {
				classDAO.saveClass(classInfo);
				response.setContentType("text/html; charset=UTF-8");
				response.sendRedirect("./professor/professorPage.jsp");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('등록에 실패하였습니다. 관리자에게 문의해주세요!'); window.location='loginStudent.jsp';</script>");
				e.printStackTrace();
			}
            
        } else {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('등록에 실패하였습니다. 관리자에게 문의해주세요!'); window.location='loginStudent.jsp';</script>");
        }

//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write("{\"available\": " + isUserIdAvailable + "}");
    }
}
