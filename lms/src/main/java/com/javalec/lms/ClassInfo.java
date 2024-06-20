package com.javalec.lms;

 public class ClassInfo {
 	private String classId;
 	private String className;
 	private String teacherId;
 	private String checkCode;
 	private String teacherName;
 	private String description;
 	
 	public ClassInfo(String classId, String className, String teacherId, String checkCode, String teacherName, String description) {
        this.classId = classId;
        this.className = className;
        this.teacherId = teacherId;
        this.checkCode = checkCode;
        this.teacherName = teacherName;
        this.description = description;
	}
	public String getClassId() {
 		return classId;
 	}
 	public void setClassId(String classId) {
 		this.classId = classId;
 	}
 	public String getClassName() {
 		return className;
 	}
 	public void setClassName(String className) {
 		this.className = className;
 	}
 	public String getTeacherId() {
 		return teacherId;
 	}
 	public void setTeacherId(String teacherId) {
 		this.teacherId = teacherId;
 	}
	public String getCheckCode() {
		return checkCode;
	}
	public void setCheckCode(String checkCode) {
		this.checkCode = checkCode;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
 }