package com.course;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class CourseDao {
	private static final String url = "jdbc:postgresql://localhost:5432/StudentCourseDB?charSet=UTF-8";
	private static final String username = "postgres";
	private static final String password = "Qhien123";

	
	public List<Course> getAllCourses() throws ClassNotFoundException {
		
		String SELECT_ALL_COURSES = "SELECT * FROM course";
		
        List<Course> courses = new ArrayList<>();
        Class.forName("org.postgresql.Driver");
        try (
        	 Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURSES);
             ResultSet resultSet = preparedStatement.executeQuery();
        ) {
            while (resultSet.next()) {
                Course course = new Course();
                course.setStudentId(resultSet.getInt("course_id"));
                course.setName(resultSet.getString("name"));
                course.setLecture(resultSet.getString("lecture"));
                course.setYear(resultSet.getInt("year"));
                course.setNotes(resultSet.getString("notes"));
                courses.add(course);
            }
            connection.close();
        } catch (SQLException ex) {
        	ex.printStackTrace();
        }
        return courses;
	}

	public boolean addCourse(Course course) {
		
		String ADD_NEW_COURSE = "INSERT INTO course (course_id, name, lecture, year, notes) VALUES (?, ?, ?, ?, ?)";
		
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        try {
            // Tạo câu truy vấn SQL để chèn dữ liệu vào bảng khoá học
            Connection connection = DriverManager.getConnection(url, username, password);
            PreparedStatement preparedStatement = connection.prepareStatement(ADD_NEW_COURSE);
            // ResultSet resultSet = preparedStatement.executeQuery();

            // Đặt giá trị cho các tham số trong câu truy vấn
            preparedStatement.setInt(1, course.getCourseId());
            preparedStatement.setString(2, course.getName());
            preparedStatement.setString(3, course.getLecture());
            preparedStatement.setInt(4, course.getYear());
            preparedStatement.setString(5, course.getNotes());
            

            // Thực thi câu truy vấn và lấy số dòng bị ảnh hưởng
            int rowsInserted = preparedStatement.executeUpdate();

            // Kiểm tra xem có dòng nào bị ảnh hưởng không, nếu có trả về true
            if (rowsInserted > 0) {
                return true;
            }
            
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
		
		return false;
	}
	
	public void deleteCourse(int courseId) throws ClassNotFoundException, SQLException {
		
		String DELETE_COURSE = "DELETE FROM course WHERE course_id = ?";
		
		Class.forName("org.postgresql.Driver");
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COURSE);
		preparedStatement.setInt(1, courseId);
		preparedStatement.executeUpdate();
		connection.close();
	}
	
	public void updateCourse(Course course) throws ClassNotFoundException, SQLException {
		
		String UPDATE_COURSE = "UPDATE course SET name=?, lecture=?, year=?, notes=? WHERE course_id=?";
		
		Class.forName("org.postgresql.Driver");
		Connection connection = DriverManager.getConnection(url, username, password);
		PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COURSE);
		preparedStatement.setString(1, course.getName());
		preparedStatement.setString(2, course.getLecture());
		preparedStatement.setInt(3, course.getYear());
		preparedStatement.setString(4, course.getNotes());
		preparedStatement.setInt(5, course.getCourseId());
		preparedStatement.executeUpdate();
		connection.close();
	}
}

