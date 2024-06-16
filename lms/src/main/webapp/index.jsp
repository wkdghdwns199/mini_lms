<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>Hello LMS</h1>
    <%
        String userName = (String) session.getAttribute("userName");
   		Integer ifStudent = (Integer) session.getAttribute("ifStudent");
        if (userName != null && ifStudent != null) {
        	if (ifStudent ==1){
        		out.println("<h2>" + userName + "님</h2>");
        		%>
	            <a href=enrolled.jsp><label>강의 목록</label></a>
            	<a href=enroll.jsp><label>수강신청</label></a>
            <%
        	}
        	else {
        		out.println("<h2>" + userName + " 교수님</h2>");
        		%>
	            <a href=enrolled.jsp><label>강의 목록</label></a>
            	<a href=enroll.jsp><label>출석기록</label></a>
            <%
        	}
            
    %>
            <form action="logout" method="post">
                <button type="submit">로그아웃</button>
            </form>

    <%
        } else {
    %>
    <a href="loginStudent.jsp"><label>로그인</label></a>
    <a href="registerStudent.jsp"><label>회원가입</label></a>
    <%
        }
    %>
</body>
</html>
