<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>ghps</title>
<meta content="" name="description">
<meta content="" name="keywords">
<!-- Favicons -->
<link href="${pageContext.request.contextPath}/assets/img/favicon.png"
	rel="icon">
<link
	href="${pageContext.request.contextPath}/assets/img/apple-touch-icon.png"
	rel="apple-touch-icon">
<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link
	href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/vendor/quill/quill.snow.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/vendor/quill/quill.bubble.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/vendor/remixicon/remixicon.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/assets/vendor/simple-datatables/style.css"
	rel="stylesheet">

<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet">
</head>
<body>
	<!-- ======= Sidebar ======= -->
	<aside id="sidebar" class="sidebar">
		<ul class="sidebar-nav" id="sidebar-nav">
			<li class="nav-item"><a class="nav-link "
				href="${pageContext.request.contextPath }/transport-mgmt/index.jsp">
					<i class="bi bi-grid"></i> <span>Dashboard</span>
			</a></li>
			<!-- End Dashboard Nav -->

			<!------------------------------------ Vehicle ------------------------------------- -->
			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#frontoffice-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-person-workspace"></i><span>Vehicle</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="frontoffice-nav" class="nav-content collapse"
					data-bs-parent="#sidebar-nav ">

					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/vehicle/vehicle-master.jsp">
							<i class="bi bi-circle"></i><span>Vehicle Master</span>
					</a></li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/vehicle/vehicle-details.jsp">
							<i class="bi bi-circle"></i><span>Vehicle Details</span>
					</a></li>

					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/vehicle/vehicle-vendors.jsp">
							<i class="bi bi-circle"></i><span>Vehicle Vendors</span>
					</a></li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/vehicle/assignDriver.jsp">
							<i class="bi bi-circle"></i><span>Assign Driver</span>
					</a></li>
				</ul></li>
			<!-- End Components Nav -->

			<!------------------------------------ Driver --------------------------------------->
			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-card-checklist"></i><span>Driver</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="components-nav" class="nav-content collapse"
					data-bs-parent="#sidebar-nav ">


					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/driver/driver-master.jsp">
							<i class="bi bi-circle"></i><span>Driver Master</span>
					</a></li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/driver/driver-details.jsp">
							<i class="bi bi-circle"></i><span>Driver Details</span>
					</a></li>

					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/driver/driver-attendance.jsp">
							<i class="bi bi-circle"></i><span>Driver Attendance</span>
					</a></li>

				</ul></li>
			<!-- End Components Nav -->


			<!------------------------------------ Route Management ------------------------------------- -->

			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-cash"></i><span>Route Management</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="forms-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/route/route-master.jsp">
							<i class="bi bi-circle"></i><span>Route Master</span>
					</a></li>

					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/route/route-details.jsp">
							<i class="bi bi-circle"></i><span>Route Details</span>
					</a></li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/route/assignVehicle.jsp">
							<i class="bi bi-circle"></i><span>Assign Route</span>
					</a></li>


				</ul></li>
			<!-- End Forms Nav -->

			<!------------------------------------ Student Allocation ------------------------------------- -->


			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#academic-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-mortarboard-fill"></i><span>Student
						Allocation</span><i class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="academic-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/student-allocation/student-master.jsp">
							<i class="bi bi-circle"></i><span>Student Master</span>
					</a></li>



					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/student-allocation/student-details.jsp">
							<i class="bi bi-circle"></i><span>Students Details</span>
					</a></li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/student-allocation/assignVehicleToStudent.jsp">
							<i class="bi bi-circle"></i><span>Assign Vehicle To
								Student</span>
					</a></li>
					<li>
				</ul></li>
			<!-- End Forms Nav -->


			<!------------------------------------ Staff Allocation ------------------------------------- -->
			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#idcard-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-person-badge"></i><span>Staff Allocation</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="idcard-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/staff-allocation/staff-master.jsp">
							<i class="bi bi-circle"></i><span>Staff Master</span>
					</a></li>
					<li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/staff-allocation/staff-details.jsp">
							<i class="bi bi-circle"></i><span>Staff Details</span>
					</a></li>
					<li><a
						href="${pageContext.request.contextPath }/transport-mgmt/staff-allocation/assignVehicleToStaff.jsp">
							<i class="bi bi-circle"></i><span>Assign Vehicle To
								Staff</span>
					</a></li>

				</ul></li>






			<!------------------------------------ Additional ------------------------------------- -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="${pageContext.request.contextPath }/transport-mgmt/maintenance-records.jsp">
					<i class="bi bi-bar-chart-fill"></i> <span>Maintenance
						Records</span>
			</a></li>
			<%-- <li class="nav-item"><a class="nav-link collapsed"
				href="${pageContext.request.contextPath }/transport-mgmt/transport-tracking.jsp">
					<i class="bi bi-bar-chart-fill"></i> <span>Transport
						Tracking</span>
			</a></li> --%>


		</ul>
		</li>
		<!-- End Charts Nav -->
		</ul>

	</aside>
	<!-- End Sidebar-->
	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
	<!-- Vendor JS Files -->
	<script
		src="${pageContext.request.contextPath}/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/chart.js/chart.umd.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/echarts/echarts.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/quill/quill.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>