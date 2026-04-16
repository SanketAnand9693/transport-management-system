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
						<div class="card-header text-light mb-3"
							style="background-color: #6810c0;">
							<h5 class="card-title1 text-center fw-bolder">Assign Driver</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">

								<div class="form-group ">
									<label for="Select " style="margin-bottom: 8px">Vehicle
										Number</label> <select id="vehicleNumber" name="vehicleNumber"
										class="form-control">
										<option disabled selected hidden>Select Vehicle
											Number</option>
										<%
										String query = "SELECT * FROM vehicle WHERE stats <> 'active' OR stats IS NULL;";
										PreparedStatement st = con.prepareStatement(query);
										ResultSet rs = st.executeQuery();

										while (rs.next()) {
											String vehicleNumber = rs.getString("vehicle_number");
										%>
										<option><%=vehicleNumber%></option>
										<%
										}
										%>

									</select>

								</div>

								<div class="form-group ">
									<label for="Select " style="margin-bottom: 8px">Driver
										ID</label> <select id="driverId" name="driverId" class="form-control">
										<option disabled selected hidden>Select Driver</option>
										<%
										String query1 = "SELECT * FROM driver WHERE stats <> 'active' OR stats IS NULL;";
										PreparedStatement pst = con.prepareStatement(query1);
										ResultSet prs = pst.executeQuery();

										while (prs.next()) {
											String driverId = prs.getString("driver_id");
										%>
										<option><%=driverId%></option>
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
							<table class="table table-hover">
								<tr>
									<td class="px-3"><strong>S No.</strong></td>
									<td><strong>Vehicle No.</strong></td>
									<td><strong>Vehicle Type</strong></td>
									<td><strong>Driver ID</strong></td>
									<td><strong>First Name</strong></td>
									<td><strong>Last Name</strong></td>
									<td><strong>Contact No.</strong></td>
									<td><strong>Delete</strong></td>
								</tr>
								<%
								PreparedStatement driverVehicle = con
										.prepareStatement("SELECT * FROM driver_to_vehicle WHERE stats <> 'active' OR stats IS NULL  ;");
								ResultSet rsDriver = driverVehicle.executeQuery();
								int count = 1;
								while (rsDriver.next()) {
									String vehicleNumber = rsDriver.getString("vehicle_number");
									String vehicleType = rsDriver.getString("vehicle_type");
									String driverId = rsDriver.getString("driver_id");
									String firstName = rsDriver.getString("first_name");
									String lastName = rsDriver.getString("last_name");
									String contactNumber = rsDriver.getString("contact_number");
								%>

								<tr>
									<td class="px-4"><%=count%></td>
									<td><%=vehicleNumber%></td>
									<td><%=vehicleType%></td>
									<td><%=driverId%></td>
									<td><%=firstName%></td>
									<td><%=lastName%></td>
									<td><%=contactNumber%></td>
									<td class='text-right'><button type='button'
											class='btn btn-danger delete-btn'
											data-vehicleNumber=<%=vehicleNumber%>
											data-driverId=<%=driverId%>>Delete</button></td>
								</tr>

								<%
								count++;
								}
								%>




							</table>
						</div>

					</div>
				</div>
			</div>
		</section>
	</main>

	<script src="js/assign-driver.js"></script>

</body>
</html>