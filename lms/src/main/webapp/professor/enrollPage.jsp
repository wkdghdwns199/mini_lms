<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>교수 페이지</title>
   <link rel="stylesheet" href="style.css">
</head>
<body>

<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection connection=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","scott","tiger");

	Statement statement = connection.createStatement();

	ResultSet classSet = statement.executeQuery("select * from CLASS");
%>

<div class="layout">
	<div class="profile-layout">
  <div class="profile-image"></div>
  <div class="profile-name">nunu</div>
</div>
		
<div class="home-layout">
  <button class="home-button">
  <p class="home-word">홈으로</p>
  </button>
</div>

<div class="center-layout">
  <div class ="subject-list" >
  	<div class="modal-body-layout">
	    <form action = "jsp" name = "subject_info" method="get">
	    	<fieldset>
	    	과목 이름 :
	    	<input type = "text" name="sub_name" size="20"><br><br>
	    	강의 계획서 :<br>
	    	<textarea name = "sub_intro" cols="50" rows="3">
	    	</textarea> <br><br>
	    	담당 교수 :
	    	<input type = "text" name="pro_name" size="10"><br><br>
	    	</fieldset> 
	    </form>
    </div>
    <div class="modal-footer-layout">
	      <button class="attendance-button">저장</button>
	      <button class="attendance-button close-area">닫기</button>
  	</div>
  </div>
</div>

</body>
</html>
</html>