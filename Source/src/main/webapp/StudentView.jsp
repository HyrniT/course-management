<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.student.Student"%>
<%@ page import="com.student.StudentDao"%>
<%@ page import="com.coursedetail.CourseDetail" %>
<%@ page import="com.coursedetail.CourseDetail" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<style type="text/css">
@charset "UTF-8";

table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 10px;
}

table, th, td {
	border: 1px solid black;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #EC971F;
	color: white;
}

input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: vertical;
}

input[type=submit] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45A049;
}

.courseDetailTable th:nth-child(4), .courseDetailTable td:nth-child(4) {
	display: none;
}

.btn-delete {
	color: red;
	border: 2px solid black;
	background-color: #fffffff;
	border-radius: 4px;
	border-color: red;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-delete:hover {
	background-color: red;
	color: #ffffff;
	border-color: red;
}

.btn-edit {
	color: blue;
	border: 2px solid black;
	background-color: #fffffff;
	border-radius: 4px;
	border-color: blue;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-edit:hover {
	background-color: blue;
	color: #ffffff;
	border-color: blue;
}

.btn-add {
	display: inline-block;
	padding: 10px 14px;
	background-color: #4CAF50;
	color: #ffffff;
	font-size: 16px;
	border: 2px solid black;
	border-color: #4CAF50;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-add:hover {
	background-color: #ffffff;
	color: #4CAF50;
	border-color: #4CAF50;
}

.btn-add:active {
	display: inline-block;
	margin-right: 10px;
	background-color: #3e8e41;
	transform: translateY(1px);
}

.btn-detail {
	color: #4CAF50;
	border: 2px solid black;
	background-color: #fffffff;
	border-radius: 4px;
	border-color: #4CAF50;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-detail:hover {
	background-color: #4CAF50;
	color: #ffffff;
	border-color: #4CAF50;
}

#addStudentForm {
	width: 100%;
	display: none;
	margin-top: 10px;
	padding: 10px;
	background-color: #f2f2f2;
	border-radius: 5px;
}

#sortStudentForm {
	width: 100%;
	display: none;
	margin-top: 10px;
	padding: 10px;
	background-color: #f2f2f2;
	border-radius: 5px;
}

#updateStudentForm {
	width: 100%;
	margin-top: 10px;
	padding: 10px;
	background-color: #f2f2f2;
	border-radius: 5px;
}
</style>
<meta charset="UTF-8">
<title>Student Management</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/smoothness/jquery-ui.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">

<script>
			$(document).ready(function(){
				$("#studentTable").DataTable();
			});
			$(document).ready(function() {
				$("#birthday").datepicker({
					dateFormat: "dd/mm/yy"
				});
				
				$("#update_birthday").datepicker({
					dateFormat: "dd/mm/yy"
				});
			 
			
		    // Sự kiện click button thêm sinh viên mới
		    $("#addStudentForm").submit(function(event) {
		        event.preventDefault();
		        var student_id = $("#student_id").val();
		        var name = $("#name").val();
		        var grade = $("#grade").val();
		        var birthday = $("#birthday").val();
		        var address = $("#address").val();
		        var notes = $("#notes").val();

		        // Kiểm tra các trường input không được để trống
		        if (student_id == "" || name == "" || grade == "" || birthday == "" || address == "") {
		            alert("Please enter full student information before adding");
		            return;
		        }

		        // Kiểm tra trường student_id phải là số nguyên
		        if (!$.isNumeric(student_id) || !Number.isInteger(parseFloat(student_id))) {
		            alert("The \"Student ID\" field must be an integer");
		            return;
		        }

		        // Kiểm tra trường birthday có đúng định dạng dd/mm/yyyy hay không
		        var pattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
		        if (!pattern.test(birthday)) {
		            alert("The \"Date of birth\" field must be in the format dd/mm/yyyy");
		            return;
		        }
		        
		        // Submit form bằng phương thức POST
		        $.ajax({
		            url: "AddStudentServlet",
		            type: "post",
		            data: {
		                student_id: student_id,
		                name: name,
		                grade: grade,
		                birthday: birthday,
		                address: address,
		                notes: notes
		            },
		            success: function(response) {
		            	if (response == 'success') {
			                alert("Added new student successfully");  
			                location.reload(); // tự động reload lại trang
		                } else {
		                	alert("Error! Student ID already exists!");  
		                }
		            },
		            error: function() {
		            	alert('An error occurred, please try again later!');
		            }
		        });
		    }); 
		    
		    // Sự kiện click button xoá sinh viên
		    $(".btn-delete").click(function(event) {
		        var studentId = $(this).data("student-id");
		        if (confirm("Are you sure to delete this student?")) {
		            deleteStudent(studentId);
		        }
		    });
		    
		    // Sự kiện khi click button detail
		    $(".btn-detail").click(function() {
		        var row = $(this).closest("tr");
		        var studentId = row.find("td:eq(0)").text();
		        
		        scrollToBottom();
		        
		        $.ajax({
		            url: "ViewStudentDetailServlet",
		            type: "post",
		            data: {
		            	studentId: studentId
		            },
		            dataType: "json",
		            success: function(data) {
		                // Xóa hết các dòng cũ
		                $("#courseDetailTable tbody").empty();
						
		                // Thêm các dòng mới
		                for (var i = 0; i < data.length; i++) {
		                    var courseDetail = data[i];
		                    var tr = $("<tr>");
		                    tr.append($("<td>").text(courseDetail.id));
		                    tr.append($("<td>").text(courseDetail.courseId));
		                    tr.append($("<td>").text(courseDetail.year));
		                    tr.append($("<td>").text(courseDetail.studentId));
		                    tr.append($("<td>").text(courseDetail.score));
		                    tr.append($("<td>").text(courseDetail.notes));
		                    

		                    $("#courseDetailTable tbody").append(tr);
		                }

		                // Hiển thị bảng danh sách sinh viên
		                $("#detailSection").show();
		            },
		            error: function() {
		                alert('An error occurred, please try again later!');
		            }
		        });
		    });
		    
		    // Sự kiện click button sửa sinh viên
		    $(".btn-edit").click(function() {
	            var row = $(this).closest("tr");
	            var student_id = row.find("td:eq(0)").text();
	            var name = row.find("td:eq(1)").text();
	            var grade = row.find("td:eq(2)").text();
	            var birthday = row.find("td:eq(3)").text();
	            var address = row.find("td:eq(4)").text();
	            var notes = row.find("td:eq(5)").text();
	            
	            // Hiển thị form cập nhật sinh viên
	            $("#updateStudentForm").show();
	            
	            // Điền dữ liệu sinh viên vào form
	            $("#updateStudentForm #student_id").val(student_id);
	            $("#updateStudentForm #update_name").val(name);
	            $("#updateStudentForm #update_grade").val(grade);
	            $("#updateStudentForm #update_birthday").val(birthday);
	            $("#updateStudentForm #update_address").val(address);
	            $("#updateStudentForm #update_notes").val(notes);
	            
	            // Xử lý việc cập nhật sinh viên
	            $("#updateStudentForm").submit(function(e) {
	                e.preventDefault();
			        var name = $("#update_name").val();
			        var grade = $("#update_grade").val();
			        var birthday = $("#update_birthday").val();
			        var address = $("#update_address").val();
			        var notes = $("#update_notes").val();

			        // Kiểm tra các trường input không được để trống
			        if (name == "" || grade == "" || birthday == "" || address == "") {
			            alert("Please enter full student information before updating");
			            return;
			        }

			        // Kiểm tra trường birthday có đúng định dạng dd/mm/yyyy hay không
			        var pattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
			        if (!pattern.test(birthday)) {
			            alert("The \"Date of birth\" field must be in the format dd/mm/yyyy");
			            return;
			        }
			        
	                $.ajax({
	                    url: "UpdateStudentServlet",
	                    type: "post",
	                    data: $("#updateStudentForm").serialize(),
	                    success: function() { 
	                        // Ẩn form cập nhật sinh viên
	                        $("#updateStudentForm").hide();
	                        location.reload(); // tự động reload lại trang
	                    },
	                    error: function() {
	                    	alert('An error occurred, please try again later!');
	                    }
	                });
	            });
	        });
		});

		// Hàm xoá sinh viên
		function deleteStudent(studentId) {
		    $.ajax({
		        url: "DeleteStudentServlet",
		        type: "post",
		        data: {student_id: studentId},
		        success: function() {
		            location.reload(); // tự động reload lại trang
		        },
		        error: function() {
		            alert("An error occurred, please try again later!");
		        }
		    });
		}
		
		
		function toggleForm() {
			var form = document.getElementById("addStudentForm");
			if (form.style.display === "none") {
				form.style.display = "block";
			} else {
				form.style.display = "none";
			}
		}
		
		function showStudentName(studentName) {
			var detailSection = document.getElementById("detailSection");
			var updateForm = document.getElementById("updateStudentForm");
			if (detailSection.style.display === "none") {
				detailSection.style.display = "block";
				updateForm.style.display = "none";	
				scrollToBottom();
			} else {
				detailSection.style.display = "none";
			}
	        document.getElementById("studentNameLabel").innerHTML = "Student Name: " + studentName;
	    }
		function scrollToBottom() {
			window.scrollTo(0,document.body.scrollHeight);
		}

		</script>
</head>
<body>
	<h1>Student Management</h1>
	<div>
		<button class="btn-add" onclick="toggleForm()">Add New
			Student</button>
	</div>
	<br>
	<form id="addStudentForm" action="#" method="post">
		<h2>Add new student</h2>
		<label for="student_id">Student ID:</label><br> <input
			type="text" id="student_id" name="student_id"><br> <label
			for="name">Full name:</label><br> <input type="text" id="name"
			name="name"><br> <label for="grade">Grade:</label><br>
		<input type="text" id="grade" name="grade"><br> <label
			for="birthday">Date of birth:</label><br> <input type="text"
			id="birthday" name="birthday"><br> <label for="address">Address:</label><br>
		<input type="text" id="address" name="address"><br> <label
			for="notes">Notes:</label><br>
		<textarea id="notes" name="notes"></textarea>
		<br> <input type="submit" value="Add">
	</form>

	<table id="studentTable">
		<thead>
			<tr>
				<th>Student ID</th>
				<th>Full name</th>
				<th>Grade</th>
				<th>Date of birth</th>
				<th>Address</th>
				<th>Notes</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<% 
        			StudentDao studentDao = new StudentDao();
            		List<Student> students = studentDao.getAllStudents();
                   for (Student student : students) { %>
			<tr>
				<td><%= student.getStudentId() %></td>
				<td><%= student.getName() %></td>
				<td><%= student.getGrade() %></td>
				<td><%= student.getBirthday() %></td>
				<td><%= student.getAddress() %></td>
				<td><%= student.getNotes() %></td>
				<td>
					<button class="btn-delete"
						data-student-id="<%= student.getStudentId() %>">Delete</button>
					<button class="btn-edit"
						data-student-id="<%= student.getStudentId() %>">Edit</button>
					<button class="btn-detail" onclick="showStudentName('<%= student.getName() %>')" data-student-id="<%= student.getStudentId() %>">Detail</button>
				</td>
			</tr>
			<% } %>
		</tbody>
	</table>
	<br>
	
	<div id="detailSection" style="display: none;">
		<h2 id="studentNameLabel"></h2> 
		<table class="courseDetailTable" id="courseDetailTable">
			<thead>
				<tr>
					<th>ID</th>
					<th>Course ID</th>
					<th>Year</th>
					<th>Student ID</th>
					<th>Score</th>
					<th>Notes</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table><br>
	</div><br>


	<form id="updateStudentForm" action="#" method="post"
		style="display: none;">
		<h2>Edit student information</h2>
		<input type="hidden" id="student_id" name="student_id" value="">
		<label for="name">Full Name:</label><br> <input type="text"
			id="update_name" name="name"><br> <label for="grade">Grade:</label><br>
		<input type="text" id="update_grade" name="grade"><br> <label
			for="birthday">Date of birth:</label><br> <input type="text"
			id="update_birthday" name="birthday"><br> <label
			for="address">Address:</label><br> <input type="text"
			id="update_address" name="address"><br> <label
			for="notes">Notes:</label><br>
		<textarea id="update_notes" name="notes"></textarea>
		<br> <input type="submit" value="Update">
	</form>


</body>
</html>