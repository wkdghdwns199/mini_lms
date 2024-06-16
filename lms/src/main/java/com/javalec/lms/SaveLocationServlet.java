package com.javalec.lms;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/saveLocation")
public class SaveLocationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");

        // 위치 정보를 처리 (예: 데이터베이스에 저장하거나 로그에 기록)
        // 여기서는 단순히 콘솔에 출력
        System.out.println("Received location: Latitude = " + latitude + ", Longitude = " + longitude);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Location received: Latitude = " + latitude + ", Longitude = " + longitude);
    }
}
