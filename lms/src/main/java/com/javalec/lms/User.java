package com.javalec.lms;

public class User {
    private String userId;
    private String password;
    private String userName;
    private String userEmail;
    private int ifStudent;

    public User(String userId, String password, String userName, String userEmail, int ifStudent) {
        this.userId = userId;
        this.password = password;
        this.userName = userName;
        this.userEmail = userEmail;
        this.ifStudent = ifStudent;
    }

    public String getUserId() {
        return userId;
    }

    public String getPassword() {
        return password;
    }
    
    public String getUserName() {
    	return userName;
    }
    
    public String getUserEmail() {
    	return userEmail;
    }
    
    public int getIfStudent() {
    	return ifStudent;
    }
    
}
