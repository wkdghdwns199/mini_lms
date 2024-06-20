package com.javalec.lms;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/enrollClass")
public class EnrollClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // request 객체에서 selectedCourses라는 이름으로 전달된 값들을 String 배열로 받음
        String[] selectedCourses = request.getParameterValues("selectedCourses");

//        response.setContentType("text/html;charset=UTF-8");
//        response.getWriter().println("<html><body>");
//        response.getWriter().println("<h1>Selected Courses</h1>");

        if (selectedCourses != null) {
        	HttpSession session = request.getSession();
        	String studentId = (String) session.getAttribute("userId");
            for (String courseId : selectedCourses) {
            	ClassDAO classDAO = new ClassDAO();
            	try {
					classDAO.enrollClass(courseId, studentId);
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					response.getWriter().println("<script>alert('수강신청 실패.'); window.location='enrolled.jsp';</script>");
					return ;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					response.getWriter().println("<script>alert('수강신청 실패.'); window.location='enrolled.jsp';</script>");
					return ;
				}
//                response.getWriter().println("<p>Course ID: " + courseId + "</p>");
            	
//                response.sendRedirect("index.jsp");
            }
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>alert('수강신청 성공.'); window.location='enrolled.jsp';</script>");
        } else {
        	response.setContentType("text/html; charset=UTF-8");
        	response.getWriter().println("<script>alert('수강신청 실패.'); window.location='enrolled.jsp';</script>");
        	return ;
//            response.getWriter().println("<p>No courses selected.</p>");
        }

//        response.getWriter().println("</body></html>");
    }
}
