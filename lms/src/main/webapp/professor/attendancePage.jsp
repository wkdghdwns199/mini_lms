<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>출석 페이지</title>
   <link rel="stylesheet" href="style.css">
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","nunu","sunwo123");

	Statement statement = connection.createStatement();

	ResultSet classSet = statement.executeQuery("select * from CLASS");
	ResultSet studentSet = statement.executeQuery("select * from STUDENT");
	ResultSet class_studentSet = statement.executeQuery("select * from CLASS_STUDENT");
	
	String className = request.getParameter("className");
  String teacherName = request.getParameter("teacherName");
  String classId = request.getParameter("classId");
%>

<div class="layout">
	<div class="profile-layout">
  <div class="profile-image"></div>
  <div class="profile-name">nunu</div>
</div>
		
<div class="home-layout">
  <button class="home-button" onclick="location.href='professorPage.jsp'">
  <p class="home-word">홈으로</p>
  </button>
</div>
<div class="modal">
   <div class="modal-body">
     <div class="layout">
       <div class="modal-header-layout">
         <h1><% out.println(className); %></h1>
         <div>
           <span class="time-select-layout">
             <label>출석 인정 시간</label>
             <select name="success_time">
               <option value="5">5분</option>
               <option value="10">10분</option>
               <option value="15">15분</option>
               <option value="20">20분</option>
               <option value="25">25분</option>
               <option value="30">30분</option>
             </select>
           </span>
           <span class="time-select-layout">
             <label>지각 인정 시간</label>
             <select name="late_time">
               <option value="5">5분</option>
               <option value="10">10분</option>
               <option value="15">15분</option>
               <option value="20">20분</option>
               <option value="25">25분</option>
               <option value="30">30분</option>
             </select>
           </span>
           <button class="attendance-button">출석 시작하기</button>
         </div>
       </div>
       <div class="modal-body-layout">
       	 <%
		       	String sql = "SELECT student_id FROM class_student WHERE class_id = ?";
						PreparedStatement pstmt = connection.prepareStatement(sql);
						pstmt.setString(1, classId); // 4번째 컬럼에 있는 teacher_id 값을 설정
						
						ResultSet rs = pstmt.executeQuery();
       	 %>
         <%while(rs.next()) { 
        	 	String studentId = rs.getString("student_id");
        	 	
        	  String studentQuery = "SELECT * FROM student WHERE student_id = ?";
       	    PreparedStatement studentPstmt = connection.prepareStatement(studentQuery);
       	    studentPstmt.setString(1, studentId);
       	    ResultSet studentRs = studentPstmt.executeQuery();
       	    
       	    if(!studentRs.next()) continue;
       	    String studentName = studentRs.getString("student_name");
         %>
         <div class="modal-student-layout">
           <div class="profile-information">
             <div class="profile-image">
             </div>
             <div class="student-name-ID">
               <h4 style="margin: 0"><%= studentName %></h4>
               <p style="margin: 0"><%= studentId %></p>
             </div>
           </div>
           <select class="attendance-select" name="colorSelect" style="background-color: #ff2a2a">
             <option value="attend" style="background-color: #ffffff">출석</option>
             <option value="late" style="background-color: #ffffff">지각</option>
             <option value="absent" style="background-color: #ffffff" selected>결석</option>
           </select>
         </div>
         <%} %>
       </div>
       <div class="modal-footer-layout">
	       <button class="attendance-button">저장</button>
	       <button class="attendance-button close-area" onclick="location.href='professorPage.jsp'">닫기</button>
   		 </div>
     </div>
   </div>
</div>
<script>
   const selectList = document.getElementsByName('colorSelect');
   for (var i = 0; i < selectList.length; i++) {
     selectList[i].addEventListener('click', function (e) {
       var selectedOption = this.options[this.selectedIndex].value;
       if (selectedOption == 'absent') {
         this.style.backgroundColor = '#FF2A2A';
       } else if (selectedOption == 'attend') {
         this.style.backgroundColor = '#BEFFA0';
       } else if (selectedOption == 'late') {
         this.style.backgroundColor = '#FFDD29';
       }
     });
   }
 </script>
</body>
</html>