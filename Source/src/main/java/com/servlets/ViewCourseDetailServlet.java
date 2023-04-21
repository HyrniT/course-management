package com.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import com.google.gson.Gson;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coursedetail.*;

@WebServlet("/ViewCourseDetailServlet")
public class ViewCourseDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
        
        // Lấy ID của khoá học từ yêu cầu POST
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        CourseDetailDao courseDetailDao = new CourseDetailDao();
        List<CourseDetail> courseDetails;
		try {
			courseDetails = courseDetailDao.getCourseDetailsByCourseId(courseId);
			Gson gson = new Gson();
			String json = gson.toJson(courseDetails);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
