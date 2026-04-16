<%@page import="java.beans.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Driver Attendance</title>

<link href="${pageContext.request.contextPath }/assets/css/style.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/assets/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.present-row {
	background-color: #d4edda !important;
}

.absent-row {
	background-color: #f8d7da !important;
}
</style>

</head>
<body>
	<%@ include file="../../includes/commonFile.jsp"%>
	<%@ include file="../../includes/header.jsp"%>
	<%@ include file="../../includes/sideBar.jsp"%>
	<main id="main" class="main">
		<div id="divLoading"></div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-header text-light mb-3"style="background-color: #6810c0;">
							<h5 class="card-title1 text-center fw-bolder">Driver Attendance</h5>
						</div>
						<div class="card-body">

							<div class="col-md-12">

								<div class="container col-md-12">
									<div class="row justify-content-right">	
										<div class="col-md-3 offset-9">
											<div class="search-container">
												<input type="text" id="searchBox"
													class="form-control search-input"
													placeholder="Search By ID, Name, Type">
											</div>
										</div>
									</div>
								</div>
								<br>
								<form id="submitForm" method="post">


									<table class="table table-bordered border-primary ">
										<thead>
											<tr>
												<td><strong> S No.</strong></td>
												<td><strong>Driver ID</strong></td>
												<td><strong>First Name</strong></td>
												<td><strong>Last Name</strong></td>
												<td class="text-center"><strong>Present/Absent</strong></td>

											</tr>
										</thead>
										<tbody>
											<%
											PreparedStatement pst = con.prepareStatement("SELECT * FROM driver ORDER BY driver_id;");
											ResultSet rs = pst.executeQuery();
											int count = 1;
											while (rs.next()) {
												String driverId = rs.getString("driver_id");
											%>
											<tr>
												<td><%=count%></td>
												<td><%=driverId%></td>
												<td><%=rs.getString("first_name")%></td>
												<td><%=rs.getString("last_name")%></td>

												<td class="text-center">
													<!-- Send ALL drivers --> <input type="hidden"
													name="driverId" value="<%=driverId%>"> <!-- Only checked drivers -->
													<input type="checkbox" name="presentDriver"
													value="<%=driverId%>">
												</td>
											</tr>
											<%
											count++;
											}
											%>
										</tbody>
									</table>
									<br>
									<div class="col-md-12 text-center">
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

		</section>
	</main>

	<script src="js/driver-attendance.js"></script>


</body>
</html>