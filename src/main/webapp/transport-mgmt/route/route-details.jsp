<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>

<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Route Details</title>
<script
	src="${pageContext.request.contextPath }/assets/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link href="${pageContext.request.contextPath }/assets/css/style.css"
	rel="stylesheet">
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
						<div class="card-header text-light mb-3" style="background-color: #6810c0;">
							<h5 class="card-title1 text-center fw-bolder">Route List</h5>
						</div>
						<div class="card-body">
							<!-- Search Box -->
							<div class="container center">
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
							</div>

							<table class="table table-hover ">
								<thead>
									<tr>
										<td><strong> S No.</strong></td>
										<td><strong>Route No.</strong></td>
										<td><strong>Start At</strong></td>
										<td><strong>End At</strong></td>
										<td><strong>Update</strong></td>

										<td><strong>Delete</strong></td>
									</tr>
								</thead>
								<tbody>
									<%
									PreparedStatement pst = con.prepareStatement("SELECT * FROM route ORDER BY route_number;");
									ResultSet rs = pst.executeQuery();
									int count = 1;
									while (rs.next()) {
										String routeId = rs.getString("route_number");
									%>
									<tr>
										<td><%=count%></td>
										<td><%=routeId%></td>
										<td><%=rs.getString("bus_stop_1")%></td>
										<td><%=rs.getString("bus_stop_6")%></td>
										<td><button type='button'
												class='btn btn-primary font-bold update-btn'
												data-routeNumber=<%=routeId%>>Update</button></td>
										<td><button type='button'
												class='btn btn-danger delete-btn'
												data-routeNumber=<%=routeId%>>Delete</button></td>

									</tr>
									<%
									count++;
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>


			<!-- Dialog box  -->
			<div class="modal fade" id="updateModal" tabindex="-1">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">

						<div class="modal-header">
							<h5 class="modal-title">Update Route</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>

						<div class="modal-body">

							<form class="row g-3" method="post" id="submitForm">
								<div class="col-md-4">
									<label for="routeNumber" class="form-label">Route Name</label>
									<input type="text" name="routeNumber" class="form-control"
										id="routeNumber" required>
								</div>

								<div class="col-md-12">
									<hr>
								</div>
								<div class="col-md-2">
									<label for="busStop1" class="form-label">Bus Stop 1</label> <input
										type="text" name="busStop1" class="form-control" id="busStop1"
										required>

								</div>
								<div class="col-md-2">
									<label for="busStop2" class="form-label">Bus Stop 2</label> <input
										type="text" name="busStop2" class="form-control" id="busStop2"
										required>
								</div>

								<div class="col-md-2">
									<label for="busStop3" class="form-label">Bus Stop 3</label> <input
										type="text" name="busStop3" class="form-control" id="busStop3"
										required>
								</div>

								<div class="col-md-2">
									<label for="busStop4" class="form-label">Bus Stop 4</label> <input
										type="text" name="busStop4" class="form-control" id="busStop4"
										required>
								</div>

								<div class="col-md-2">
									<label for="busStop5" class="form-label">Bus Stop 5</label> <input
										type="text" name="busStop5" class="form-control" id="busStop5"
										required>
								</div>

								<div class="col-md-2">
									<label for="busStop6" class="form-label">Bus Stop 6</label> <input
										type="text" name="busStop6" class="form-control" id="busStop6"
										required>
								</div>
								<div class="col-md-4" id="error"></div>

								<div class="col-12 mb-5 text-center">
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

		</section>
	</main>
	<script src="js/route-details.js"></script>

</body>
</html>