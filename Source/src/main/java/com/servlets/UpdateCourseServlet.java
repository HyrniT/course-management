package com.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.course.*;


@WebServlet("/UpdateCourseServlet")
public class UpdateCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy dữ liệu từ form
		request.setCharacterEncoding("UTF-8");
		int courseId = Integer.parseInt(request.getParameter("course_id"));
        String name = request.getParameter("name");
        String lecture = request.getParameter("lecture");
        int year = Integer.parseInt(request.getParameter("year"));
        String notes = request.getParameter("notes");
        
        Course course = new Course(courseId, name, lecture, year, notes);


        CourseDao courseDao = new CourseDao();
        try {
			courseDao.updateCourse(course);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
