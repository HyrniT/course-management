<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home page</title>

<style>
body {
	background-color: #F8F8F8;
}

.container {
	margin-top: 50px;
}

.btn-primary {
	background-color: #5CB85C;
	border-color: #5CB85C;
}

.btn-primary:hover {
	background-color: #449D44;
	border-color: #449D44;
}

.btn-secondary {
	background-color: #F0AD4E;
	border-color: #F0AD4E;
}

.btn-secondary:hover {
	background-color: #EC971F;
	border-color: #EC971F;
}

.btn-group-lg>.btn, .btn-lg {
	font-size: 24px;
	line-height: 1.33;
	border-radius: 6px;
	padding: 10px 16px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6 text-center">
				<h1>Welcome to HyrniT's Web Application</h1>
				<p>Please select a page to start:</p>
			</div>
		</div>
		<div class="row justify-content-center mt-5">
			<div class="col-md-6 text-center">
				<div class="btn-group-lg btn-group-vertical" role="group">
					<a href="${pageContext.request.contextPath}/CourseView.jsp"
						class="btn btn-primary"><i class="fas fa-book"></i> Course
						Management</a> <a
						href="${pageContext.request.contextPath}/StudentView.jsp"
						class="btn btn-secondary"><i class="fas fa-user-graduate"></i>
						Student Management</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
