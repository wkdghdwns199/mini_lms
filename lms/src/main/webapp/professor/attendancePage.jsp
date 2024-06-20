<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>출석 페이지</title>
    <style>
        /* 전체적인 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 레이아웃 스타일 */
        .layout {
            width: 80%;
            max-width: 1200px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-layout {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-image {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #ddd;
            margin-right: 20px;
        }

        .profile-name {
            font-size: 20px;
            font-weight: bold;
        }

        .home-layout {
            margin-bottom: 20px;
        }

        .home-button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .home-button:hover {
            background-color: #45a049;
        }

        .modal {
            width: 100%;
        }

        .modal-body {
            width: 100%;
        }

        .modal-header-layout {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-bottom: 20px;
        }

        .modal-header-layout h1 {
            margin: 0;
        }

        .time-select-layout {
            margin-right: 10px;
        }

        .attendance-button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .attendance-button:hover {
            background-color: #45a049;
        }

        .modal-body-layout {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .modal-student-layout {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-bottom: 10px;
        }

        .profile-information {
            display: flex;
            align-items: center;
        }

        .student-name-ID {
            margin-left: 10px;
        }

        .attendance-select {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .modal-footer-layout {
            display: flex;
            justify-content: center;
            width: 100%;
            margin-top: 20px;
        }

        .close-area {
            margin-left: 10px;
        }
        
        select option[value="attend"] {
        background-color: #BEFFA0; 
    }

    select option[value="late"] {
        background-color: #FFDD29;
    }

    select option[value="absent"] {
        background-color: #FF2A2A; 
    }

    select {
        background-color: transparent;
    }
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521","scott","tiger");

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
%>

<div class="layout">
    <div class="profile-layout">
        <div class="profile-name"><%= session.getAttribute("userName") %></div>
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
                        <% if (checkCode == null) { %>
                            <span class="time-select-layout">
                                <label>출석 인정 시간</label>
                                <select name="success_time" form="startAttendanceForm">
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
                                <select name="late_time" form="startAttendanceForm">
                                    <option value="5">5분</option>
                                    <option value="10">10분</option>
                                    <option value="15">15분</option>
                                    <option value="20">20분</option>
                                    <option value="25">25분</option>
                                    <option value="30">30분</option>
                                </select>
                            </span>
                            <form id="startAttendanceForm" action="/lms/startAttendance" method="post">
                                <input type="hidden" name="classId" value="<%= classId %>">
                                <input type="hidden" name="className" value="<%= className %>">
                                <input type="hidden" name="teacherName" value="<%= teacherName %>">
                                <button type="submit" class="attendance-button">출석 시작하기</button>
                            </form>
                        <% } else { %>
                            <div>
                                <p>출석 코드: <%= checkCode %></p>
                                <p>남은 출석 시간: <span id="remaining-success-time"></span></p>
                                <p>남은 지각 시간: <span id="remaining-late-time"></span></p>
                                <button id="updateCheckCodeButton" onclick="updateCheckCodeToNull('<%= classId %>')">출석 종료</button>
							</div>
                            </div>
                            <script>
                                const successTime = <%= (successTime != null) ? ("new Date('" + successTime.toString() + "').getTime()") : 0 %>;
                                const lateTime = <%= (lateTime != null) ? ("new Date('" + lateTime.toString() + "').getTime()") : 0 %>;

                                function updateRemainingTime() {
                                    const now = new Date().getTime();
                                    const remainingSuccessTime = Math.max(successTime - now, 0);
                                    const remainingLateTime = Math.max(lateTime - now, 0);

                                    document.getElementById('remaining-success-time').textContent = formatTime(remainingSuccessTime);
                                    document.getElementById('remaining-late-time').textContent = formatTime(remainingLateTime);

                                    if (remainingLateTime <= 0) {
                                        clearInterval(timerInterval);
                                        updateCheckCodeToNull("<%= classId %>");
                                    }
                                }

                                function formatTime(ms) {
                                    const minutes = Math.floor((ms % (1000 * 60 * 60)) / (1000 * 60));
                                    const seconds = Math.floor((ms % (1000 * 60)) / 1000);
                                    return minutes + "분 " + seconds + "초";
                                }

                                function updateCheckCodeToNull(classId) {
                                    fetch('/lms/updateCheckCode', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded'
                                        },
                                        body: new URLSearchParams({ classId: classId })
                                    })
                                    .then(response => response.text())
                                    .then(data => {
                                        console.log(data);
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                    });
                                }

                                const timerInterval = setInterval(updateRemainingTime, 1000);
                            </script>
                        <% } %>
                    </div>
                </div>
                <div class="modal-body-layout">
                    <%
                        String sql = "SELECT attendance_status, student_id FROM attendance WHERE class_id = ? and active = 1";
                        PreparedStatement pstmt = connection.prepareStatement(sql);
                        pstmt.setString(1, classId);

                        ResultSet rs = pstmt.executeQuery();
                    %>
                    <% while(rs.next()) {
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
                            <div class="profile-image"></div>
                            <div class="student-name-ID">
                                <h4 style="margin: 0"><%= studentName %></h4>
                                <p style="margin: 0"><%= studentId %></p>
                            </div>
                        </div>
                               <select class="attendance-select" name="colorSelect" >
                            <option value="attend" style="background-color: #BEFFA0;">출석</option>
                            <option value="late" style="background-color: #FFDD29;">지각</option>
                            <option value="absent" style="background-color: #FF2A2A;" selected>결석</option>
                        </select>
                    </div>
                    <% } %>
                </div>
                <div class="modal-footer-layout">
                    <button class="attendance-button">저장</button>
                    <button class="attendance-button close-area" onclick="location.href='professorPage.jsp'">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const successTime = <%= (successTime != null) ? ("new Date('" + successTime.toString() + "').getTime()") : 0 %>;
    const lateTime = <%= (lateTime != null) ? ("new Date('" + lateTime.toString() + "').getTime()") : 0 %>;

    function updateRemainingTime() {
        const now = new Date().getTime();
        const remainingSuccessTime = Math.max(successTime - now, 0);
        const remainingLateTime = Math.max(lateTime - now, 0);

        document.getElementById('remaining-success-time').textContent = formatTime(remainingSuccessTime);
        document.getElementById('remaining-late-time').textContent = formatTime(remainingLateTime);

        if (remainingLateTime <= 0) {
            clearInterval(timerInterval);
            updateCheckCodeToNull("<%= classId %>");
        }
    }

    function formatTime(ms) {
        const minutes = Math.floor((ms % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((ms % (1000 * 60)) / 1000);
        return minutes + "분 " + seconds + "초";
    }

    function updateCheckCodeToNull(classId) {
        fetch('/lms/updateCheckCode', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ classId: classId })
        })
        .then(response => response.text())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }

    function updateSelectColor(selectElement) {
        const selectedValue = selectElement.value;
        if (selectedValue === 'attend') {
            selectElement.style.backgroundColor = '#BEFFA0'; // 초록색
        } else if (selectedValue === 'late') {
            selectElement.style.backgroundColor = '#FFDD29'; // 노란색
        } else if (selectedValue === 'absent') {
            selectElement.style.backgroundColor = '#FF2A2A'; // 빨간색
        }
    }

    const selectElements = document.getElementsByClassName('attendance-select');
    for (let i = 0; i < selectElements.length; i++) {
        updateSelectColor(selectElements[i]); // 초기 색상 설정
        selectElements[i].addEventListener('change', function() {
            updateSelectColor(this);
        });
    }

    const timerInterval = setInterval(updateRemainingTime, 1000);
</script>
</body>
</html>
