<%@ page import="com.javalec.lms.ClassDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.InetAddress"%>
<%@ page import="java.net.UnknownHostException"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="java.io.IOException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");
	
	String classId = request.getParameter("classId");
	String className = request.getParameter("className");
	String teacherName = request.getParameter("teacherName");
	
	String checkCode = null;
	Timestamp successTime = null;
	Timestamp lateTime = null;
	
	String checkCodeQuery = "SELECT check_code FROM class WHERE class_id = ?";
	PreparedStatement checkCodeStmt = connection.prepareStatement(checkCodeQuery);
	checkCodeStmt.setString(1, classId);
	ResultSet checkCodeRs = checkCodeStmt.executeQuery();
	if (checkCodeRs.next()) {
	    checkCode = checkCodeRs.getString("check_code");
	}
	checkCodeStmt.close();
	
	if (checkCode != null) {
	    String historyQuery = "SELECT SUCCESS_TIME, LATE_TIME FROM attendance_history WHERE CLASS_ID = ? ORDER BY ID DESC FETCH FIRST 1 ROWS ONLY";
	    PreparedStatement historyStmt = connection.prepareStatement(historyQuery);
	    historyStmt.setString(1, classId);
	    ResultSet historyRs = historyStmt.executeQuery();
	    if (historyRs.next()) {
	        successTime = historyRs.getTimestamp("SUCCESS_TIME");
	        lateTime = historyRs.getTimestamp("LATE_TIME");
	    }
	    historyStmt.close();
	}
	
	checkCodeRs.close();

    // 파라미터 값 가져오기
    String code = request.getParameter("code");
    String studentId = (String) session.getAttribute("userId");

    // DAO 객체 생성
    ClassDAO classDAO = new ClassDAO();
    
    // 결과 메시지 변수 초기화
    String message = "";
    
    String ipAddress = request.getRemoteAddr();

    // X-Forwarded-For 헤더를 확인하여 프록시 서버 뒤에 있는 경우 실제 IP 주소를 얻음
    String forwardedFor = request.getHeader("X-Forwarded-For");
    if (forwardedFor != null && !forwardedFor.isEmpty()) {
        ipAddress = forwardedFor.split(",")[0];
    }
	System.out.println(ipAddress);
    // IP 주소를 출력
    if (!ipAddress.equals("172.18.247.198")){
    	if (!ipAddress.equals("0:0:0:0:0:0:0:1")){
    		response.sendRedirect("./banned.jsp");	
    	}
    	
    }
	
    // check_code와 입력된 code 비교
    if (checkCode != null && !checkCode.equals("null")) {
        // 출석 상태 업데이트
        if (checkCode.equals(code)){
            long currentTimeMillis = System.currentTimeMillis();
            boolean updateSuccess = false;

            if (successTime != null && currentTimeMillis <= successTime.getTime()) {
                updateSuccess = classDAO.updateAttendanceStatus(classId, studentId);
                if (updateSuccess) {
                    message = "출석이 성공적으로 처리되었습니다.";
                } else {
                    message = "출석 처리 중 오류가 발생했습니다.";
                }
            } else if (lateTime != null && currentTimeMillis <= lateTime.getTime()) {
                updateSuccess = classDAO.updateLateStatus(classId, studentId);
                if (updateSuccess) {
                    message = "지각이 성공적으로 처리되었습니다.";
                } else {
                    message = "지각 처리 중 오류가 발생했습니다.";
                }
            }

            
        } else {
            message = "출석 코드가 올바르지 않습니다.";
        }
    } else {
        message = "출석 코드가 올바르지 않습니다.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>출석 결과</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        /* 중앙 정렬을 위한 스타일 */
        .center-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        /* 컨테이너 스타일 */
        .container {
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div class="center-content">
        <div class="container">
            <h1>출석 결과</h1>
            <p><%= message %></p>
            <a href="enrolled.jsp">강의 목록으로</a>
        </div>
    </div>
</body>
</html>
