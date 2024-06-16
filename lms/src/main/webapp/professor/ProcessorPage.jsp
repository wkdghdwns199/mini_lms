<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<jsp:useBean id="subject" class="com.javalec.ex.SubjectInfo" scope="page"></jsp:useBean>
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
	Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","nunu","sunwo123");

	Statement statement = connection.createStatement();

	ResultSet classSet = statement.executeQuery("select * from CLASS");
%>

<div class="layout">
	<div class="profile-layout">
  <div class="profile-image"></div>
  <div class="profile-name">nunu</div>
</div>
		
<div class="home-layout">
  <button class="home-button" onclick="location.href='ProcessorPage.jsp'">
  <p class="home-word">홈으로</p>
  </button>
</div>

<div class="center-layout">
  <div class ="subject-list" >
    <h4>과목 목록</h4>
    <table class = "table">
      <tr class = "subject-container">
        <th style="background-color: white; color : grey; text-align: left; padding: 4px 8px;">과목명</th>
        <th style="background-color: white; color : grey; text-align: left; padding: 4px 8px;">과목코드</th>
        <th style="background-color: white; color : grey; text-align: left; padding: 4px 8px;">담당교수</th>
        <th style="background-color: white; color : grey; text-align: left; padding: 4px 8px;">출석체크</th>
      </tr>
      <% while(classSet.next()){ %>
				<tr class = "subject-container">
					<%
						String className = classSet.getString(2);
						String sql = "SELECT teacher_name FROM teacher WHERE teacher_id = ?";
						String teacherName = sql.getString(1);
						PreparedStatement pstmt = connection.prepareStatement(sql);
						pstmt.setString(1, classSet.getString(4)); // 4번째 컬럼에 있는 teacher_id 값을 설정
						String classId = classSet.getString(2);
						
						ResultSet rs = pstmt.executeQuery();
								
						if(!rs.next())
						{
							continue;
						}
					%>
					<td style='font-size: 12px; font-weight: bold; padding: 4px 8px;' ><%= classSet.getString(3) %></td>
					<td style='font-size: 12px; font-weight: bold; padding: 4px 8px;' ><%= classSet.getString(2) %></td>
					<td style='font-size: 12px; font-weight: bold; padding: 4px 8px;' ><% out.println(rs.getString("TEACHER_NAME")); %></td>
					<form action = "attendancePage.jsp" method = "POST">
						<td style='padding: 4px 8px;'>
						<jsp:setProperty name="subject" property="name" value="${className}"/>
						<jsp:setProperty name="subject" property="classId" value="Jnunu"/>
						<jsp:setProperty name="subject" property="teacherId" value="Jnunu"/>
						<input type='submit' class='Check-button' value="출석 확인"> </td>
					</form>
				</tr>
			<% } %>
  	</table>
  </div>
  <div class = "register-class">
  	<button>강의 등록</button>
	</div>
</div>

</body>
</html>