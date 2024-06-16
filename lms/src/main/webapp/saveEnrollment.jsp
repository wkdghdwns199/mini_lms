<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javalec.lms.CourseBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 사용자가 선택한 강의 목록을 가져옴
    String[] selectedCourses = request.getParameterValues("selectedCourses");
    List<CourseBean> enrolledCourses = new ArrayList<>();

    // 선택된 강의가 있을 경우
    if (selectedCourses != null) {
        // 모든 강의 목록을 가져옴
        List<CourseBean> allCourses = CourseBean.getAllCourses();
        // 선택된 강의 코드와 일치하는 강의를 등록된 강의 목록에 추가
        for (String courseCode : selectedCourses) {
            for (CourseBean course : allCourses) {
                if (course.getCourseCode().equals(courseCode)) {
                    enrolledCourses.add(course);
                }
            }
        }
    }

    // 세션에 등록된 강의 목록을 저장
    session.setAttribute("enrolledCourses", enrolledCourses);
    // enrolled.jsp로 리다이렉트
    response.sendRedirect("enrolled.jsp");
%>

