package com.coursedetail;

public class CourseDetail {
	private int id;
	private int courseId;
	private int year;
	private int studentId;
	private double score;
	private String notes;
	
	public CourseDetail() { }
	
	public CourseDetail(int id, int courseId, int year, int studentId, double score, String notes) {
		super();
		this.id = id;
		this.courseId = courseId;
		this.year = year;
		this.studentId = studentId;
		this.score = score;
		this.notes = notes;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCourseId() {
		return courseId;
	}
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	
}
