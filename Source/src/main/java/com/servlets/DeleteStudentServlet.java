package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.student.StudentDao;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin mã sinh viên từ request
        int studentId = Integer.parseInt(request.getParameter("student_id"));
        
        // Xóa sinh viên từ cơ sở dữ liệu
        StudentDao studentDao = new StudentDao();
        studentDao.deleteStudent(studentId);
        
//        // Chuyển hướng về trang hiển thị danh sách sinh viên
//        response.sendRedirect("ViewStudentServlet");
    }
}
