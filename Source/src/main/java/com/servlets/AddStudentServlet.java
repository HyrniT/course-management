package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.student.*;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {
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
       

        // Tạo đối tượng Student
        Student student = new Student(studentId, name, grade, birthday, address, notes);

        // Thêm sinh viên vào database
        StudentDao studentDao = new StudentDao();
//        studentDao.addStudent(student);
        
        boolean result = studentDao.addStudent(student);
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        if (result) {
        	out.print("success");
        } else {
        	out.print("exists");
        }
	}

}
