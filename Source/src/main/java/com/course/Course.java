package com.course;


public class Course {
	private int courseId;
	private String name;
	private String lecture;
	private int year;
	private String notes;
	
	public Course() { }
	
	public Course(int courseId, String name, String lecture, int year, String notes)
	{
		this.courseId = courseId;
		this.name = name;
		this.lecture = lecture;
		this.year = year;
		this.notes = notes;
	}
	
	public int getCourseId() {
        return courseId;
    }

    public void setStudentId(int courseId) {
        this.courseId = courseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getLecture() {
        return lecture;
    }

    public void setLecture(String lecture) {
        this.lecture = lecture;
    }

    public int getYear() {
    	return year;
    }
    
    public void setYear(int year) {
    	this.year = year;
    }
    
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
