package com.student;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class StudentDao {
	private static final String url = "jdbc:postgresql://localhost:5432/StudentCourseDB";
	private static final String username = "postgres";
	private static final String password = "Qhien123";

	
	public List<Student> getAllStudents() throws ClassNotFoundException {
		
		String SELECT_ALL_STUDENTS = "SELECT * FROM student";
		
        List<Student> students = new ArrayList<>();
        Class.forName("org.postgresql.Driver");
        try (
        	 Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STUDENTS);
             ResultSet resultSet = preparedStatement.executeQuery()
        ) {
            while (resultSet.next()) {
                Student student = new Student();
                student.setStudentId(resultSet.getInt("student_id"));
                student.setName(resultSet.getString("name"));
                student.setGrade(resultSet.getString("grade"));
                student.setBirthday(resultSet.getString("birthday"));
                student.setAddress(resultSet.getString("address"));
                student.setNotes(resultSet.getString("notes"));
                students.add(student);
            }
            connection.close();
        } catch (SQLException ex) {
        	ex.printStackTrace();
        }
        return students;
	}

	public boolean addStudent(Student student) {
		
		String ADD_NEW_STUDENT = "INSERT INTO student(student_id, name, grade, birthday, address, notes) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        
        try {
            // Tạo câu truy vấn SQL để chèn dữ liệu vào bảng sinh viên
            Connection connection = DriverManager.getConnection(url, username, password);
            PreparedStatement preparedStatement = connection.prepareStatement(ADD_NEW_STUDENT);

            // Đặt giá trị cho các tham số trong câu truy vấn
            preparedStatement.setInt(1, student.getStudentId());
            preparedStatement.setString(2, student.getName());
            preparedStatement.setString(3, student.getGrade());
            preparedStatement.setString(4, student.getBirthday());
            preparedStatement.setString(5, student.getAddress());
            preparedStatement.setString(6, student.getNotes());
            
            
            // Thực thi câu truy vấn và lấy số dòng bị ảnh hưởng
            int rowsInserted = preparedStatement.executeUpdate();
            // Kiểm tra xem có dòng nào bị ảnh hưởng không, nếu có trả về true
            if (rowsInserted > 0) {
                return true;
            }
            else {
            	
            }
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
		
		return false;
	}
	
	public void deleteStudent(int studentId) {
		
		String DELETE_STUDENT = "DELETE FROM student WHERE student_id = ?";
		
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	    try {
	        Connection connection = DriverManager.getConnection(url, username, password);
	        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_STUDENT);
	        preparedStatement.setInt(1, studentId);
	        preparedStatement.executeUpdate();
	        connection.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	public void updateStudent(Student student) {
		
		String UPDATE_STUDENT = "UPDATE student SET name=?, grade=?, birthday=?, address=?, notes=? WHERE student_id=?";
		
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	    try {
	    	Connection connection = DriverManager.getConnection(url, username, password);
	        PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STUDENT);
	        preparedStatement.setString(1, student.getName());
	        preparedStatement.setString(2, student.getGrade());
	        preparedStatement.setString(3, student.getBirthday());
	        preparedStatement.setString(4, student.getAddress());
	        preparedStatement.setString(5, student.getNotes());
	        preparedStatement.setInt(6, student.getStudentId());
	        preparedStatement.executeUpdate();
	        connection.close();
	    } catch (SQLException e) {
	        System.out.println(e);
	    }
	}


}

