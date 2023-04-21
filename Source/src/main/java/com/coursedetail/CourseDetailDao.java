package com.coursedetail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class CourseDetailDao {
	private static final String url = "jdbc:postgresql://localhost:5432/StudentCourseDB?charSet=UTF-8";
	private static final String username = "postgres";
	private static final String password = "Qhien123";
	
	public List<CourseDetail> getAllCourseDetail() throws ClassNotFoundException, SQLException {
		
		String SELECT_ALL_COURSEDETAILS = "SELECT * FROM coursedetail";
		
		List<CourseDetail> coursedetails = new ArrayList<>();
		
		Class.forName("org.postgresql.Driver");
		
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURSEDETAILS);
		ResultSet resultSet = preparedStatement.executeQuery();
		while(resultSet.next()) {
			CourseDetail courseDetail = new CourseDetail();
			courseDetail.setId(resultSet.getInt("id"));
			courseDetail.setCourseId(resultSet.getInt("course_id"));
			courseDetail.setYear(resultSet.getInt("year"));
			courseDetail.setStudentId(resultSet.getInt("student_id"));
			courseDetail.setScore(resultSet.getDouble("score"));
			courseDetail.setNotes(resultSet.getString("notes"));
			coursedetails.add(courseDetail);
		}
		
		connection.close();
		return coursedetails;
	}
	
	public List<CourseDetail> getCourseDetailsByCourseId(int courseId) throws ClassNotFoundException, SQLException {
		
		String SELECT_COURSEDETAIL = "SELECT * FROM coursedetail WHERE course_id = ?";
		
		List<CourseDetail> courseDetails = new ArrayList<>();
		
		Class.forName("org.postgresql.Driver");
		
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSEDETAIL);
		
		preparedStatement.setInt(1, courseId);
		
		ResultSet resultSet = preparedStatement.executeQuery();
		while(resultSet.next()) {
			CourseDetail courseDetail = new CourseDetail();
			courseDetail.setId(resultSet.getInt("id"));
			courseDetail.setCourseId(resultSet.getInt("course_id"));
			courseDetail.setYear(resultSet.getInt("year"));
			courseDetail.setStudentId(resultSet.getInt("student_id"));
			courseDetail.setScore(resultSet.getDouble("score"));
			courseDetail.setNotes(resultSet.getString("notes"));
			courseDetails.add(courseDetail);
		}
		
		connection.close();
		return courseDetails;
	}
	
	public List<CourseDetail> getCourseDetailsByStudentId(int studentId) throws ClassNotFoundException, SQLException {
		
		String SELECT_COURSEDETAIL = "SELECT * FROM coursedetail WHERE student_id = ?";
		
		List<CourseDetail> courseDetails = new ArrayList<>();
		
		Class.forName("org.postgresql.Driver");
		
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSEDETAIL);
		
		preparedStatement.setInt(1, studentId);
		
		ResultSet resultSet = preparedStatement.executeQuery();
		while(resultSet.next()) {
			CourseDetail courseDetail = new CourseDetail();
			courseDetail.setId(resultSet.getInt("id"));
			courseDetail.setCourseId(resultSet.getInt("course_id"));
			courseDetail.setYear(resultSet.getInt("year"));
			courseDetail.setStudentId(resultSet.getInt("student_id"));
			courseDetail.setScore(resultSet.getDouble("score"));
			courseDetail.setNotes(resultSet.getString("notes"));
			courseDetails.add(courseDetail);
		}
		
		connection.close();
		return courseDetails;
	}
	
	public void updateStudentCourse(CourseDetail courseDetail) throws ClassNotFoundException, SQLException {
		
		String UPDATE_COURSEDETAIL = "UPDATE coursedetail SET score=?, notes=? WHERE id=?";
		
		Class.forName("org.postgresql.Driver");
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COURSEDETAIL);
		preparedStatement.setDouble(1, courseDetail.getScore());
		preparedStatement.setString(2, courseDetail.getNotes());
		preparedStatement.setInt(3, courseDetail.getId());
		preparedStatement.executeUpdate();
		connection.close();
	}
	
	public void deleteStudentCourse(int id) throws ClassNotFoundException, SQLException {
		
		String DELETE_COURSEDETAIL = "DELETE FROM coursedetail WHERE id=?";
		
		Class.forName("org.postgresql.Driver");
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COURSEDETAIL);
		preparedStatement.setInt(1, id);
		preparedStatement.executeUpdate();
		connection.close();
	}
	
	public boolean addStudentCourse(int courseId, int year, int studentId) throws ClassNotFoundException, SQLException {
		
		String ADD_COURSEDETAIL = "INSERT INTO coursedetail (course_id, year, student_id, score, notes) VALUES (?, ?, ?, ?, ?)";
		
		Class.forName("org.postgresql.Driver");
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(ADD_COURSEDETAIL);
		preparedStatement.setInt(1, courseId);
		preparedStatement.setInt(2, year);
		preparedStatement.setInt(3, studentId);
		preparedStatement.setDouble(4, 0);
		preparedStatement.setString(5, "Chưa có điểm");
		
		int rowsInserted = preparedStatement.executeUpdate();
		if (rowsInserted > 0) {
			return true;
		}
		
		return false;
	}

}
