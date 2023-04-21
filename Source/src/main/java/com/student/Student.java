package com.student;


public class Student {
    private int studentId;
    private String name;
    private String grade;
    private String birthday;
    private String address;
    private String notes;
    
    public Student() {}
    
    public Student(int studentId, String name, String grade, String birthday, String address, String notes)
    {
    	this.studentId = studentId;
    	this.name = name;
    	this.grade = grade;
    	this.birthday = birthday;
    	this.address = address;
    	this.notes = notes;
    }
    

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}