package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coursedetail.*;


@WebServlet("/AddStudentCourseServlet")
public class AddStudentCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int studentId = Integer.parseInt(request.getParameter("student_id"));
		int courseId = Integer.parseInt(request.getParameter("course_id"));
		int year = Integer.parseInt(request.getParameter("year"));
		
		CourseDetailDao courseDetailDao = new CourseDetailDao();
		try {
			boolean result = courseDetailDao.addStudentCourse(courseId, year, studentId);
			response.setContentType("text/plain");
	        PrintWriter out = response.getWriter();
	        if (result) {
	        	out.print("success");
	        } else {
	        	out.print("exists");
	        }
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
