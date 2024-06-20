package com.javalec.lms;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class ClassDAO {
	String jdbcURL="jdbc:oracle:thin:@localhost:1521";
	String jdbcUsername ="scott";
	String jdbcPassword ="tiger";
	
    public void saveClass(ClassInfo classInfo) throws ClassNotFoundException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");

        String INSERT_CLASS_SQL = "INSERT INTO class (id, class_id, class_name, teacher_id, check_code, teacher_name, description) VALUES (count_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";
        
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CLASS_SQL)) {
            preparedStatement.setString(1, classInfo.getClassId());
            preparedStatement.setString(2, classInfo.getClassName());
            preparedStatement.setString(3, classInfo.getTeacherId());
            preparedStatement.setString(4, classInfo.getCheckCode());
            preparedStatement.setString(5, classInfo.getTeacherName());
            preparedStatement.setString(6, classInfo.getDescription());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<ClassInfo> getAllClasses() throws ClassNotFoundException,SQLException {
        List<ClassInfo> courses = new ArrayList<>();
    	
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	
        String SELECT_ALL_CLASSES_SQL = "SELECT * FROM class";
        

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CLASSES_SQL)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String dbClassId = rs.getString("class_id");
                String dbClassName = rs.getString("class_name");
                String dbTeacherId = rs.getString("teacher_id");
                String dbCheckCode = rs.getString("check_code");
                String dbTeacherName = rs.getString("teacher_name");
                String dbDescription = rs.getString("description");
                
                courses.add(new ClassInfo(dbClassId, dbClassName, dbTeacherId, dbCheckCode,dbTeacherName, dbDescription));
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        System.out.print(courses);
        return courses;
    }
    
    public void enrollClass(String classId, String studentId) throws ClassNotFoundException, SQLException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");

        String INSERT_CLASS_SQL = "INSERT INTO class_student (id, class_id, student_id) VALUES (count_seq.NEXTVAL, ?, ?)";
        
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CLASS_SQL)) {
            preparedStatement.setString(1, classId);
            preparedStatement.setString(2, studentId);
            
            preparedStatement.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<ClassInfo> getEnrollClasses(String studentId) throws ClassNotFoundException, SQLException {
        List<ClassInfo> courses = new ArrayList<>();
        Class.forName("oracle.jdbc.driver.OracleDriver");

        String SELECT_CLASSES_ID_SQL = "SELECT * FROM class_student WHERE student_id = ?";
        String SELECT_CLASSES_SQL = "SELECT * FROM class WHERE class_id = ?";

        try  {
        	Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CLASSES_ID_SQL);
            preparedStatement.setString(1, studentId);
            ResultSet rs = preparedStatement.executeQuery();
            PreparedStatement preparedStatement2 = connection.prepareStatement(SELECT_CLASSES_SQL);
            
                while (rs.next()) {
                    preparedStatement2.setString(1, rs.getString("class_id"));
                    ResultSet rs2 = preparedStatement2.executeQuery();
                    
                    if (rs2.next()) { 
                        String dbClassId = rs2.getString("class_id");
                        String dbClassName = rs2.getString("class_name");
                        String dbTeacherId = rs2.getString("teacher_id");
                        String dbCheckCode = rs2.getString("check_code");
                        String dbTeacherName = rs2.getString("teacher_name");
                        String dbDescription = rs2.getString("description");
                       
                        courses.add(new ClassInfo(dbClassId, dbClassName, dbTeacherId, dbCheckCode, dbTeacherName, dbDescription));
                        
                    }
                }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return courses;
    }

    
    public boolean isUserEmailAvailable(String userEmail) throws ClassNotFoundException, SQLException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        String sql = "SELECT COUNT(*) FROM users WHERE user_email = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userEmail);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) == 0;
        }
        return false;
    }
    
    public String findUserId(String userName, String userEmail) throws ClassNotFoundException, SQLException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
        
    	Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        String sql = "SELECT COUNT(*) FROM users WHERE user_name = ? AND WHERE user_email = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userName);
        pstmt.setString(2, userEmail);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getString("user_id");
        }
        return "";
    }
    

    // 특정 과목의 check_code를 가져오는 메서드
    public String getCheckCode(String classId) throws ClassNotFoundException, SQLException {
    	
    	Class.forName("oracle.jdbc.driver.OracleDriver");
        
        String checkCode = "";
  
        String query = "SELECT check_code FROM class WHERE class_id = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword); 
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, classId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    checkCode = rs.getString("check_code");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(checkCode);
        return checkCode;
    }

    // 출석 상태를 업데이트하는 메서드
    public boolean updateAttendanceStatus(String classId, String studentId) throws ClassNotFoundException, SQLException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    	
    	
    	
        String query = "UPDATE attendance SET attendance_status = 2 WHERE class_id = ? AND student_id = ? AND active = 1";
        
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, classId);
        pstmt.setString(2, studentId);
        
        int rowsUpdated = pstmt.executeUpdate();
    	if (rowsUpdated > 0) {
    		return true;
    	}
        
        return false;
        
//        try (Connection conn = getConnection(); 
//             PreparedStatement pstmt = conn.prepareStatement(query)) {
//            pstmt.setString(1, classId);
//            pstmt.setString(2, studentId);
//            int rowsUpdated = pstmt.executeUpdate();
//            return rowsUpdated > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
    }
    
    public boolean updateLateStatus(String classId, String studentId) throws ClassNotFoundException, SQLException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    	
    	
    	
        String query = "UPDATE attendance SET attendance_status = 1 WHERE class_id = ? AND student_id = ? AND active = 1";
        
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, classId);
        pstmt.setString(2, studentId);
        
        int rowsUpdated = pstmt.executeUpdate();
    	if (rowsUpdated > 0) {
    		return true;
    	}
        
        return false;
        
//        try (Connection conn = getConnection(); 
//             PreparedStatement pstmt = conn.prepareStatement(query)) {
//            pstmt.setString(1, classId);
//            pstmt.setString(2, studentId);
//            int rowsUpdated = pstmt.executeUpdate();
//            return rowsUpdated > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
    }
}
