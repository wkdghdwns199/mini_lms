package com.javalec.lms;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/startAttendance")
public class AttendanceStartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String classId = request.getParameter("classId");
        String className = request.getParameter("className");
        String teacherName = request.getParameter("teacherName");
        int successTimeMinutes = Integer.parseInt(request.getParameter("success_time"));
        int lateTimeMinutes = Integer.parseInt(request.getParameter("late_time"));

        // 랜덤 3자리 숫자 생성
        Random rand = new Random();
        String checkCode = String.format("%03d", rand.nextInt(1000));

        // 랜덤 10자리 문자열 생성
        String attendanceCode = generateRandomCode(10);

        // 현재 시간
        Timestamp currentTime = new Timestamp(new Date().getTime());

        // 출석 인정 시간과 지각 인정 시간 계산
        Timestamp successTime = new Timestamp(currentTime.getTime() + successTimeMinutes * 60 * 1000);
        Timestamp lateTime = new Timestamp(currentTime.getTime() + (lateTimeMinutes * 60 * 1000) + (successTimeMinutes * 60 * 1000));

        Connection connection = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521", "scott", "tiger");

            // check_code가 이미 설정되어 있는지 확인
            String checkCodeQuery = "SELECT check_code FROM class WHERE class_id = ?";
            pstmt = connection.prepareStatement(checkCodeQuery);
            pstmt.setString(1, classId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next() && rs.getString("check_code") != null) {
                // check_code가 이미 설정되어 있으면 기존 값을 사용
                checkCode = rs.getString("check_code");
                pstmt.close();
            } else {
                pstmt.close();
                // class 테이블의 check_code 업데이트
                String updateClassSql = "UPDATE class SET check_code = ? WHERE class_id = ?";
                pstmt = connection.prepareStatement(updateClassSql);
                pstmt.setString(1, checkCode);
                pstmt.setString(2, classId);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // attendance_history 테이블에 데이터 삽입
            String insertHistorySql = "INSERT INTO attendance_history (ID, DATE_STRING, ATTENDANCE_HISTORY_ID, CLASS_ID, SUCCESS_TIME, LATE_TIME) " +
                                      "VALUES (count_seq.NEXTVAL, ?, ?, ?, ?, ?)";
            pstmt = connection.prepareStatement(insertHistorySql);
            pstmt.setTimestamp(1, currentTime);
            pstmt.setString(2, attendanceCode);
            pstmt.setString(3, classId);
            pstmt.setTimestamp(4, successTime);
            pstmt.setTimestamp(5, lateTime);
            pstmt.executeUpdate();
            
            
            String studentQuery = "SELECT student_id FROM class_student WHERE class_id = ?";
            pstmt = connection.prepareStatement(studentQuery);
            pstmt.setString(1, classId);
            ResultSet rs2 = pstmt.executeQuery();
            

            String attendanceInsertQuery = "INSERT INTO attendance (ID, ATTENDANCE_HISTORY_ID, CLASS_ID, STUDENT_ID, ATTENDANCE_STATUS, ACTIVE) VALUES (count_seq.NEXTVAL, ?, ?, ?, 0, 1)";
            PreparedStatement attendancePstmt = connection.prepareStatement(attendanceInsertQuery);

            while (rs2.next()) {
                String studentId = rs2.getString("student_id");
                attendancePstmt.setString(1, attendanceCode);
                attendancePstmt.setString(2, classId);
                attendancePstmt.setString(3, studentId);
                attendancePstmt.executeUpdate();
            }

            attendancePstmt.close();
            
            rs2.close();
            
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        
        // 출석 페이지로 리다이렉트
        response.sendRedirect("/lms/professor/attendancePage.jsp?classId=" + classId + "&className=" + className + "&teacherName=" + teacherName);
    }

    private String generateRandomCode(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random rand = new Random();
        StringBuilder code = new StringBuilder();

        for (int i = 0; i < length; i++) {
            code.append(characters.charAt(rand.nextInt(characters.length())));
        }

        return code.toString();
    }
}

