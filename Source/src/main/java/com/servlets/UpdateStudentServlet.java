package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.student.*;

@WebServlet("/UpdateStudentServlet")
public class UpdateStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy dữ liệu từ form
		request.setCharacterEncoding("UTF-8");
		int studentId = Integer.parseInt(request.getParameter("student_id"));
        String name = request.getParameter("name");
        String grade = request.getParameter("grade");
        String birthday = request.getParameter("birthday");
        String address = request.getParameter("address");
        String notes = request.getParameter("notes");
        
        Student student = new Student(studentId, name, grade, birthday, address, notes);

        StudentDao studentDao = new StudentDao();
        studentDao.updateStudent(student);
	}

}
