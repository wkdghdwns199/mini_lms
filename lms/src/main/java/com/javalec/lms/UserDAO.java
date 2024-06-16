package com.javalec.lms;

import java.sql.*;
public class UserDAO {
	String jdbcURL="jdbc:oracle:thin:@localhost:1521";
	String jdbcUsername ="scott";
	String jdbcPassword ="tiger";
	
    public void saveUser(User user) throws ClassNotFoundException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");

        String INSERT_USERS_SQL = "INSERT INTO users (id, user_id, user_name, user_email, password, if_student) VALUES (count_seq.NEXTVAL, ?, ?, ?, ?, ?)";
        
        String INSERT_CATEGORICAL_USERS_SQL = "INSERT INTO student (id, student_id, student_name, student_email, password) VALUES (count_seq.NEXTVAL, ?, ?, ?, ?)";
        if (user.getIfStudent() == 0) {
        	INSERT_CATEGORICAL_USERS_SQL = "INSERT INTO teacher (id, teacher_id, teacher_name, teacher_email, password) VALUES (count_seq.NEXTVAL, ?, ?, ?, ?)";
        }
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setString(1, user.getUserId());
            preparedStatement.setString(2, user.getUserName());
            preparedStatement.setString(3, user.getUserEmail());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setInt(5, user.getIfStudent());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CATEGORICAL_USERS_SQL )) {
               preparedStatement.setString(1, user.getUserId());
               preparedStatement.setString(2, user.getUserName());
               preparedStatement.setString(3, user.getUserEmail());
               preparedStatement.setString(4, user.getPassword());
               preparedStatement.executeUpdate();
           } catch (SQLException e) {
               e.printStackTrace();
           }
    }
    
    public User getUserByUserId(String userId) throws ClassNotFoundException {
    	
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	
        String SELECT_USER_BY_USERID_SQL = "SELECT * FROM users WHERE user_id = ?";
        User user = null;

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_USERID_SQL)) {
            preparedStatement.setString(1, userId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String dbUserId = rs.getString("user_id");
                String dbPassword = rs.getString("password");
                String dbUserName = rs.getString("user_name");
                String dbUserEmail = rs.getString("user_email");
                int dbIfStudent = rs.getInt("if_student");
                user = new User(dbUserId, dbPassword, dbUserName, dbUserEmail, dbIfStudent);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean isUserIdAvailable(String userId) throws ClassNotFoundException, SQLException {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
        
    	Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        String sql = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) == 0;
        }
        return false;
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
}
