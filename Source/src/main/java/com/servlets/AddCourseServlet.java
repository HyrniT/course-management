package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.course.Course;
import com.course.CourseDao;

/**
 * Servlet implementation class AddCourseServlet
 */
@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy dữ liệu từ form
		request.setCharacterEncoding("UTF-8");
		int courseId = Integer.parseInt(request.getParameter("course_id"));
		String name = request.getParameter("name");
		String lecture = request.getParameter("lecture");
		int year = Integer.parseInt(request.getParameter("year"));
		String notes = request.getParameter("notes");

        // Tạo đối tượng Course
		Course course = new Course(courseId, name, lecture, year, notes);

        // Thêm khoá học vào database
        CourseDao courseDao = new CourseDao();
        
        boolean result = courseDao.addCourse(course);
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        if (result) {
        	out.print("success");
        } else {
        	out.print("exists");
        }
	}

}
