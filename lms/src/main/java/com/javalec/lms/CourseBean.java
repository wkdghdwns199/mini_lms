package com.javalec.lms;

import java.util.ArrayList;
import java.util.List;

public class CourseBean {
    // 과목 이름, 과목 코드, 담당 교수 정보를 저장할 필드
    private String courseName;
    private String courseCode;
    private String professor;
    
    // 과목 이름을 반환하는 getter 메서드
    public String getCourseName() {
        return courseName;
    }

    // 과목 이름을 설정하는 setter 메서드
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    // 과목 코드를 반환하는 getter 메서드
    public String getCourseCode() {
        return courseCode;
    }

    // 과목 코드를 설정하는 setter 메서드
    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    // 담당 교수를 반환하는 getter 메서드
    public String getProfessor() {
        return professor;
    }

    // 담당 교수를 설정하는 setter 메서드
    public void setProfessor(String professor) {
        this.professor = professor;
    }

    // 모든 과목 정보를 반환하는 메서드
    public static List<CourseBean> getAllCourses() {
        List<CourseBean> courses = new ArrayList<>();
        
        // 예제 데이터 설정
        CourseBean course1 = new CourseBean();
        course1.setCourseName("Database");
        course1.setCourseCode("146146");
        course1.setProfessor("Kim Sunwoo");
        courses.add(course1);

        CourseBean course2 = new CourseBean();
        course2.setCourseName("Computer Structure");
        course2.setCourseCode("123123");
        course2.setProfessor("Lee Sunwoo");
        courses.add(course2);

        CourseBean course3 = new CourseBean();
        course3.setCourseName("Open Source Software");
        course3.setCourseCode("234123");
        course3.setProfessor("Jang Sunwoo");
        courses.add(course3);

        // 추가 과목 설정

        return courses;
    }
    
    // 과목 코드를 통해 특정 과목 정보를 반환하는 메서드
    public static CourseBean getCourseByCode(String courseCode) {
        List<CourseBean> courses = getAllCourses(); // 모든 과목 리스트 가져오기
        for (CourseBean course : courses) {
            if (course.getCourseCode().equals(courseCode)) { // 일치하는 과목 코드가 있는지 확인
                return course;
            }
        }
        return null; // 일치하는 과목이 없을 경우 null 반환
    }
}
