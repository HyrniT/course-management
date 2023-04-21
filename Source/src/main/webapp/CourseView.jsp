<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="com.course.Course"%>
<%@ page import="com.course.CourseDao"%>
<%@ page import="com.coursedetail.CourseDetail"%>
<%@ page import="com.coursedetail.CourseDetailDao"%>
<%@ page import="com.student.Student"%>
<%@ page import="com.student.StudentDao"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Course Management</title>
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
}

th {
	background-color: #4CAF50;
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

.courseDetailTable th:nth-child(1), .courseDetailTable td:nth-child(1) {
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

.btn-remove {
	color: red;
	border: 2px solid black;
	background-color: #fffffff;
	border-radius: 4px;
	border-color: red;
	cursor: pointer;
	margin: 0 5px 0 0;
	transition: background-color 0.3s ease;
}

.btn-remove:hover {
	background-color: red;
	color: #ffffff;
	border-color: red;
}

.btn-update {
	color: blue;
	border: 2px solid black;
	background-color: #fffffff;
	border-radius: 4px;
	border-color: blue;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-update:hover {
	background-color: blue;
	color: #ffffff;
	border-color: blue;
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

.btn-add-to {
	color: #4CAF50;
	border: 2px solid black;
	background-color: #fffffff;
	border-radius: 4px;
	border-color: #4CAF50;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn-add-to:hover {
	background-color: #4CAF50;
	color: #ffffff;
	border-color: #4CAF50;
}

.btn-add {
	display: inline-block;
	padding: 10px 16px;
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

#addCourseForm {
	width: 100%;
	margin-top: 10px;
	padding: 10px;
	background-color: #f2f2f2;
	border-radius: 5px;
}

#updateCourseForm {
	width: 100%;
	margin-top: 10px;
	padding: 10px;
	background-color: #f2f2f2;
	border-radius: 5px;
}

#updateStudentCourseForm {
	width: 100%;
	margin-top: 10px;
	padding: 10px;
	background-color: #f2f2f2;
	border-radius: 5px;
}
</style>
<script>
			$(document).ready(function() {
				$("#courseTable").DataTable();
			});
			
			/* $(document).ready(function(){
				$("#studentTable").DataTable();
			}); */

			$(document).ready(function() {
				var CURRENT_COURSE_ID = 0;
				var CURRENT_YEAR = 0;
				// Sự kiện click button thêm khoá học mới
				$("#addCourseForm").submit(function(event) {
					event.preventDefault();
					var course_id = $("#course_id").val();
					var name = $("#name").val();
					var lecture = $("#lecture").val();
					var year = $("#year").val();
					var notes = $("#notes").val();
					// Kiểm tra các trường input không được để trống
				    if (course_id == "" || name == "" || lecture == "" || year == "") {
				        alert("Please enter full course information before adding");
				        return;
				    }

				    // Kiểm tra trường id phải là số nguyên
				    if (!$.isNumeric(course_id) || !Number.isInteger(parseFloat(course_id))) {
				        alert("The \"Course ID\" field must be an integer");
				        return;
				    }
				    
				 	// Kiểm tra trường id phải là số nguyên
				    if (!$.isNumeric(year) || !Number.isInteger(parseFloat(year))) {
				        alert("The \"Year\" field must be an integer");
				        return;
				    }
				    
				 	// Submit form bằng phương thức POST
			        $.ajax({
			            url: "AddCourseServlet",
			            type: "post",
			            /* data: $("#addCourseForm").serialize(), */
			            data: {
			                course_id: course_id,
			                name: name,
			                lecture: lecture,
			                year: year,
			                notes: notes
			            },
			            success: function(response) {
			            	if (response == 'success') {
				                alert("Added new course successfully");  
				                location.reload(); // tự động reload lại trang
			                } else {
			                	alert("Error! Course ID already exists!");  
			                }
			            },
			            error: function() {
			            	alert('An error occurred, please try again later!');
			            }
			        });

					// Xóa nội dung các trường input
					$("#course_id").val("");
					$("#name").val("");
					$("#lecture").val("");
					$("#year").val("");
					$("#notes").val("");

				}); 
				
				// Sự kiện click button xoá khoá học
			    $(".btn-delete").click(function(event) {
			        var courseId = $(this).data("course-id");
			        if (confirm("Are you sure to delete this course?")) {
			            deleteCourse(courseId);
			        }
			    });
				
			 	// Sự kiện click button sửa khoá học
			    $(".btn-update").click(function() {
		            var row = $(this).closest("tr");
		            var course_id = row.find("td:eq(0)").text();
		            var name = row.find("td:eq(1)").text();
		            var lecture = row.find("td:eq(2)").text();
		            var year = row.find("td:eq(3)").text();
		            var notes = row.find("td:eq(4)").text();
		            
		            // Hiển thị form cập nhật khoá học
		            $("#updateCourseForm").show();
		            
		            // Điền dữ liệu khoá học vào form
		            $("#updateCourseForm #course_id").val(course_id);
		            $("#updateCourseForm #update_name").val(name);
		            $("#updateCourseForm #update_lecture").val(lecture);
		            $("#updateCourseForm #update_year").val(year);
		            $("#updateCourseForm #update_notes").val(notes);
		            
		            // Xử lý việc cập nhật khoá học
		            $("#updateCourseForm").submit(function(e) {
		                e.preventDefault();
				        var name = $("#update_name").val();
				        var lecture = $("#update_lecture").val();
				        var year = $("#update_year").val();
				        var notes = $("#update_notes").val();

				        // Kiểm tra các trường input không được để trống
				        if (name == "" || lecture == "" || year == "") {
				            alert("Please enter full course information before updating");
				            return;
				        }
				        
				        if (!$.isNumeric(year) || !Number.isInteger(parseFloat(year))) {
					        alert("The \"Year\" field must be an integer");
					        return;
					    }
				        
		                $.ajax({
		                    url: "UpdateCourseServlet",
		                    type: "post",
		                    data: $("#updateCourseForm").serialize(),
		                    success: function() {
		                        // Ẩn form cập nhật sinh viên
		                        $("#updateCourseForm").hide();
		                        location.reload(); // tự động reload lại trang
		                    },
		                    error: function() {
		                    	alert('An error occurred, please try again later!');
		                    }
		                });
		            });
		        });
			 	
			 	
			 	// Sự kiện click button sửa sinh viên trong trong khoá học
			    $(document).on("click", ".btn-edit", function() {
				    var row = $(this).closest("tr");
				    var id = row.find("td:eq(0)").text();
				    var course_id = row.find("td:eq(1)").text();
				    var year = row.find("td:eq(2)").text(); 
				    var student_id = row.find("td:eq(3)").text();
				    var score = row.find("td:eq(4)").text();
				    var notes = row.find("td:eq(5)").text();
				
				    // Hiển thị form cập nhật thông tin sinh viên
				    $("#updateStudentCourseForm").show();
				    
				    scrollToBottom();
				
				    // Điền dữ liệu vào form
				    $("#updateStudentCourseForm #id").val(id);
				    $("#updateStudentCourseForm #course_id").val(course_id);
				    $("#updateStudentCourseForm #year").val(year); 
				    $("#updateStudentCourseForm #student_id").val(student_id);
				    $("#updateStudentCourseForm #score").val(score);
				    $("#updateStudentCourseForm #notes").val(notes);
				
				    // Bắt đầu xử lý cập nhật thông tin sinh viên
				    $("#updateStudentCourseForm").submit(function(e) {
				        e.preventDefault();
				
				        var score = $("#score").val();
				        var notes = $("#notes").val();
						
				        // Thực hiện gọi API cập nhật thông tin sinh viên
				        $.ajax({
				            url: "UpdateStudentCourseServlet",
				            type: "post",
				            data: $("#updateStudentCourseForm").serialize(),
				            success: function() {
				                // Ẩn form cập nhật thông tin sinh viên
				                $("#updateStudentCourseForm").hide();
				                // Tự động reload lại trang
				                location.reload();
				            },
				            error: function() {
				                alert('An error occurred, please try again later!');
				            }
				        });
				    });
				});
			 	
			    $(document).on("click", ".btn-remove", function() {
			        /* var id = $(this).data("id"); */
			        var row = $(this).closest("tr");
				    var id = row.find("td:eq(0)").text();
			        if (confirm("Are you sure to delete this student from course?")) {
			            deleteStudentCourse(id);
			        }
			    });
			    
			    // Sự kiện khi click button thêm sinh viên vào khoá học
			    $('.btn-add-to').click(function() {
				  var student_id = $(this).data('student-id');
				  /* var course_id = $('#courseTable tbody .selected').find('td:eq(0)').text();
				  var year = $('#courseTable tbody .selected').find('td:eq(3)').text(); */
				  var course_id = CURRENT_COURSE_ID;
				  var year = CURRENT_YEAR;
				
				  $.ajax({
				    type: 'post',
				    url: 'AddStudentCourseServlet',
				    data: { 
				      student_id: student_id, 
				      course_id: course_id, 
				      year: year 
				    },
				    success: function(response) {
				      if (response == 'success') {
				        alert("Added new student successfully");  
				        location.reload(); // tự động reload lại trang
				      } else {
				        alert("Error! This student's already existed in the course!");  
				      }
				    },
				    error: function(response) {
				      alert('An error occurred, please try again later!');
				    }
				  });
				});

			 	
			 	// Sự kiện khi click button detail
			    $(".btn-detail").click(function() {
			        var row = $(this).closest("tr");
			        var courseId = row.find("td:eq(0)").text();
			        CURRENT_COURSE_ID = courseId;
			        CURRENT_YEAR = row.find("td:eq(3)").text();
			        scrollToBottom();
			        
			        $.ajax({
			            url: "ViewCourseDetailServlet",
			            type: "post",
			            data: {
			                courseId: courseId
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
			                    tr.append($("<td>").html("<button class=\"btn-remove\" >Remove</button><button class=\"btn-edit\" >Edit</button>"));

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
			});
			
			// Hàm xoá khoá học
			function deleteCourse(courseId){
				$.ajax({
					url: "DeleteCourseServlet",
					type: "post",
					data: {course_id: courseId},
					success: function() {
			            location.reload(); // tự động reload lại trang
			        },
			        error: function() {
			        	alert('An error occurred, please try again later!');
			        }
				})
			}
			
			// Hàm xoá sinh viên khoá học
			function deleteStudentCourse(id){
				$.ajax({
					url: "DeleteStudentCourseServlet",
					type: "post",
					data: {id: id},
					success: function() {
			            location.reload(); // tự động reload lại trang
			        },
			        error: function() {
			        	alert('An error occurred, please try again later!');
			        }
				})
			}
			
			// Xử lý toggle button
			function toggleAddCourseForm() {
				var form = document.getElementById("addCourseForm");
				if (form.style.display === "none") {
					form.style.display = "block";
					
				} else {
					form.style.display = "none";
				}
			}
			
			function toggleAddStudentForm() {
				var form = document.getElementById("studentSection");
				var updateForm = document.getElementById("updateStudentCourseForm");
				if (form.style.display === "none") {
					form.style.display = "block";
					updateForm.style.display = "none";
					scrollToBottom();
				} else {
					form.style.display = "none";
				}
			}
			
			function toggleUpdateForm() {
				var updateForm = document.getElementById("updateCourseForm");
				var detailSection = document.getElementById("detailSection");
				if (updateForm.style.display === "none") {
					updateForm.style.display = "block";
					detailSection.style.display = "none";
					scrollToBottom();
				} else {
					updateForm.style.display = "none";
				}
			} 
 
			function showCourseName(courseName) {
				var detailSection = document.getElementById("detailSection");
				var updateForm = document.getElementById("updateCourseForm");
				if (detailSection.style.display === "none") {
					detailSection.style.display = "block";
					updateForm.style.display = "none";	
					scrollToBottom();
				} else {
					detailSection.style.display = "none";
				}
		        document.getElementById("courseNameLabel").innerHTML = "Course Name: " + courseName;
		    }
			function scrollToBottom() {
				window.scrollTo(0,document.body.scrollHeight);
			}
			
		</script>
</head>
<body>
	<h1>Course Management</h1>
	<div>
		<button class="btn-add" onclick="toggleAddCourseForm()">Add
			New Course</button>
	</div>
	<form id="addCourseForm" action="#" method="post"
		style="display: none;">
		<h2>Add new course</h2>
		<label for="course_id">Course ID:</label><br> <input type="text"
			id="course_id" name="course_id"><br> <label for="name">Course
			name:</label><br> <input type="text" id="name" name="name"><br>

		<label for="lecture">Lecture:</label><br> <input type="text"
			id="lecture" name="lecture"><br> <label for="year">Year:</label><br>
		<input type="text" id="year" name="year"><br> <label
			for="notes">Notes:</label><br>
		<textarea id="notes" id="notes" name="notes"></textarea>
		<br> <input type="submit" value="Add">
	</form>
	<br>

	<table id="courseTable">
		<thead>
			<tr>
				<th>Course ID</th>
				<th>Course name</th>
				<th>Lecture</th>
				<th>Year</th>
				<th>Notes</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<% 
        			CourseDao courseDao = new CourseDao();
            		List<Course> courses = courseDao.getAllCourses();
                    for (Course course : courses) { %>
			<tr>
				<td><%= course.getCourseId() %></td>
				<td><%= course.getName() %></td>
				<td><%= course.getLecture() %></td>
				<td><%= course.getYear() %></td>
				<td><%= course.getNotes() %></td>
				<td>
					<button class="btn-delete"
						data-course-id="<%= course.getCourseId() %>">Delete</button>
					<button class="btn-update" onclick="toggleUpdateForm()">Update</button>
					<button class="btn-detail"
						data-course-id="<%= course.getCourseId() %>"
						data-course-year="<%= course.getYear() %>"
						onclick="showCourseName('<%= course.getName() %>')">Detail</button>
				</td>
			</tr>
			<% } %>
		</tbody>
	</table>
	<br>

	<form id="updateCourseForm" action="#" method="post"
		style="display: none;">
		<h2>Edit course information</h2>
		<input type="hidden" id="course_id" name="course_id" value="">
		<label for="name">Course name:</label><br> <input type="text"
			id="update_name" name="name"><br> <label for="lecture">Lecture:</label><br>
		<input type="text" id="update_lecture" name="lecture"><br>

		<label for="year">Year:</label><br> <input type="text"
			id="update_year" name="year"><br> <label for="notes">Notes:</label><br>
		<textarea id="update_notes" name="notes"></textarea>
		<br> <input type="submit" value="Update">
	</form>

	<div id="detailSection" style="display: none;">
		<h2 id="courseNameLabel"></h2>
		<table class="courseDetailTable" id="courseDetailTable">
			<thead>
				<tr>
					<th>ID</th>
					<th>Course ID</th>
					<th>Year</th>
					<th>Student ID</th>
					<th>Score</th>
					<th>Notes</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
		<button class="btn-add" onclick="toggleAddStudentForm()">Add
			Student</button>
		<br>
		<br>
	</div>

	<div id="studentSection" style="display: none;">
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
						<button class="btn-add-to"
							data-student-id="<%= student.getStudentId() %>">Add to
							course</button>
					</td>
				</tr>
				<% } %>
			</tbody>
		</table>
		<br>
	</div>

	<form id="updateStudentCourseForm" action="#" method="post"
		style="display: none;">
		<h2>Update student information</h2>

		<input type="hidden" id="id" name="id" value=""> <input
			type="hidden" id="course_id" name="course_id" value=""> <label
			for="year">Year:</label> <input id="year" name="year" value=""
			readonly> <label for="student_id">Student ID:</label> <input
			id="student_id" name="student_id" value="" readonly><br>
		<br> <label for="score">Score:</label><br> <input
			type="text" id="score" name="score"><br> <label
			for="notes">Notes:</label><br>
		<textarea id="notes" name="notes"></textarea>
		<br> <input type="submit" value="Update">
	</form>

</body>
</html>