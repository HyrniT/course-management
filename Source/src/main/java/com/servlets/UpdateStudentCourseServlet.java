package com.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coursedetail.*;

@WebServlet("/UpdateStudentCourseServlet")
public class UpdateStudentCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int id = Integer.parseInt(request.getParameter("id"));
		int courseId = Integer.parseInt(request.getParameter("course_id"));
        int year = Integer.parseInt(request.getParameter("year"));
        int studentId = Integer.parseInt(request.getParameter("student_id"));
        double score = Double.parseDouble(request.getParameter("score"));
        String notes = request.getParameter("notes");
		
        CourseDetail courseDetail = new CourseDetail(id, courseId, year, studentId, score, notes);
        
        CourseDetailDao courseDetailDao = new CourseDetailDao();
        try {
			courseDetailDao.updateStudentCourse(courseDetail);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
