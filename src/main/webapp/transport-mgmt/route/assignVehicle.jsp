<%@page import="java.beans.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Driver Master</title>

<link href="${pageContext.request.contextPath }/assets/css/style.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/assets/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
							<h5 class="card-title1 text-center fw-bolder">Assign Route</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">

								<div class="form-group ">
									<label for="routeNumber" style="margin-bottom: 8px">Route
										Number</label> <select id="routeNumber" name="routeNumber"
										class="form-control">
										<option disabled selected hidden>Select Route Number</option>
										<%
										String query = "SELECT * FROM route ;";
										PreparedStatement st = con.prepareStatement(query);
										ResultSet rs = st.executeQuery();

										while (rs.next()) {
											String routeNumber = rs.getString("route_number");
										%>
										<option><%=routeNumber%></option>
										<%
										}
										%>

									</select>

								</div>

								<div class="form-group ">
									<label for="vehicleNumber" style="margin-bottom: 8px">Select
										Vehicle </label> <select id="vehicleNumber" name="vehicleNumber"
										class="form-control">
										<option disabled selected hidden>Select Vehicle</option>
										<%
										String query1 = "SELECT * FROM vehicle WHERE route_assigned <> 'true' OR route_assigned IS NULL;";
										PreparedStatement pst = con.prepareStatement(query1);
										ResultSet prs = pst.executeQuery();

										while (prs.next()) {
											String vehicleNumber = prs.getString("vehicle_number");
										%>
										<option><%=vehicleNumber%></option>
										<%
										}
										%>

									</select>
								</div>


								<div class="col-md-4" id="error"></div>

								<div class="col-12 mb-5 text-center">
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>
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
							<br>
							<table class="table table-bordered border-primary">
								<thead>
									<tr>
										<td class="px-3"><strong>S No.</strong></td>
										<td><strong>Route Number</strong></td>
										<td><strong>Vehicle Number</strong></td>
										<td class="text-center"><strong>Delete</strong></td>
									</tr>
								</thead>
								<tbody>
									<%
									PreparedStatement vehicleRoute = con.prepareStatement("SELECT * FROM vehicle_to_route  ;");
									ResultSet rsDriver = vehicleRoute.executeQuery();
									int count = 1;
									while (rsDriver.next()) {
										String vehicleNumber = rsDriver.getString("vehicle_number");
										String routeNumber = rsDriver.getString("route_number");
									%>

									<tr>
										<td class="px-4"><%=count%></td>
										<td><%=routeNumber%></td>
										<td><%=vehicleNumber%></td>
										<td class='text-center'><button type='button'
												class='btn btn-danger delete-btn'
												data-vehicleNumber=<%=vehicleNumber%>
												data-routeNumber=<%=routeNumber%>>Delete</button></td>
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
		</section>
	</main>
	<script src="js/assign-vehicle.js"></script>


</body>
</html>