
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vehicle Master</title>

<script
	src="${pageContext.request.contextPath }/assets/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<%@ include file="../../includes/commonFile.jsp"%>
	<%@ include file="../../includes/header.jsp"%>
	<%@ include file="../../includes/sideBar.jsp"%>

	<%
	String vehicleNumber = request.getParameter("vehicleNumber");

	String vehicleType = "";
	String fuelType = "";
	String modelName = "";
	String vehicleOwner = "";
	int seatingCapacity = 0;

	boolean isUpdate = false;

	if (vehicleNumber != null && !vehicleNumber.trim().isEmpty()) {
		isUpdate = true;

		PreparedStatement pst = con.prepareStatement(
		"SELECT vehicle_type, seating_capacity, fuel_type, model_name, vehicle_owner FROM vehicle WHERE vehicle_number = ?");
		pst.setString(1, vehicleNumber);

		ResultSet rs = pst.executeQuery();

		if (rs.next()) {
			vehicleType = rs.getString("vehicle_type");
			seatingCapacity = rs.getInt("seating_capacity");
			fuelType = rs.getString("fuel_type");
			modelName = rs.getString("model_name");
			vehicleOwner = rs.getString("vehicle_owner");
		}
	}
	%>
	<main id="main" class="main">
		<div id="divLoading"></div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-header text-light mb-3" style="background-color: #6810c0;">
							<h5 class="card-title1 text-center fw-bolder">Add Vendors</h5>
						</div>
						<div class="card-body">
							<div id="message" class="text-center mb-3"></div>

							<form class="row g-3" method="post" id="submitForm">
								<div class="col-md-12">
									<label for="organization" class="form-label">Organization</label>
									<input type="text" class="form-control" name="organization" maxlength="20"
										id="organization" placeholder="Enter Organization Name">
										<small class="text-danger error"
										id="organizationError"></small>
								</div>
								<br>
								<div class="col-md-4">
									<label for="firstName" class="form-label"> First Name</label> <input
										type="text" class="form-control" id="firstName" maxlength="15"
										name="firstName" placeholder="Enter First Name" >
									<small class="text-danger error" id="firstNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="middleName" class="form-label"> Middle Name</label>
									<input type="text" class="form-control" id="middleName" maxlength="15"
										name="middleName" placeholder="Enter Middle Name" >
									<small class="text-danger error" id="middleNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="lastName" class="form-label">Last Name</label> <input
										type="text" class="form-control" id="lastName" name="lastName" maxlength="15"
										placeholder="Enter Last Name" > <small
										class="text-danger error" id="lastNameError"></small>
								</div>

								<div class="col-md-4">
									<label for="contactNumber" class="form-label">Vendor
										Contact Number</label> <input type="tel" maxlength="10"
										class="form-control" id="contactNumber" name="contactNumber"
										placeholder="Enter Contact Number" > <small
										class="text-danger error" id="contactNumberError"></small>
								</div>
								<div class="col-md-8">
									<label for="address" class="form-label">Vendor Address</label>
									<input type="text" name="address" class="form-control" maxlength="50"
										id="address" placeholder="Enter Address " > <small
										class="text-danger error" id="addressError"></small>
								</div>

								<div class="col-12 mb-5 text-center">
									<button type="submit" class="btn btn-primary" id="submit">Submit</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
<script src="js/vehicle-vendor.js"></script>
</html>