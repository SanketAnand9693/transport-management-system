<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vehicle Master</title>
<%-- 
<link href="${pageContext.request.contextPath }/assets/css/style.css"
	rel="stylesheet"> --%>
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
						<div class="card-header text-black  mb-3" style="background-color: #6810c0;">
							<h5 class="card-title1 text-light text-center fw-bolder">Vehicle Master</h5>
						</div>
						<div class="card-body">
							<div id="message" class="text-center mb-3"></div>

							<form class="row g-3" method="post" id="submitForm">



								<div class="col-md-4">
									<label for="inputVehicleNumber" class="form-label">Vehicle
										Number<sup class="text-danger">*</sup></label> <input type="text" name="vehicleNumber"
										placeholder="Enter Vehicle Number" maxlength="15"
										value="<%=isUpdate ? vehicleNumber : ""%>"
										class="form-control" <%=isUpdate ? "readonly" : ""%>>
									<small class="text-danger error" id="vehicleNumberError"></small>
								</div>

								<div class="col-md-4 ">

									<div class="form-group ">
										<label for="Select " style="margin-bottom: 8px">Vehicle
											Type<sup class="text-danger">*</sup></label> <select id="vehicleType" name="vehicleType"
											class="form-control">
											<option value="" selected disabled>Select Vehicle
												Type</option>
											<option value="Van">Van</option>
											<option value="Tempo">Tempo</option>
											<option value="Bus">Bus</option>
											<option value="Mini Bus">Mini Bus</option>
										</select> <small class="text-danger error" id="vehicleTypeError"></small>
									</div>

								</div>

								<div class="col-md-4">
									<label for="inputSeatCapacity" class="form-label">Seating
										Capacity<sup class="text-danger">*</sup></label> <input type="number" name="seatCapacity"
										class="form-control" id="inputSeatCapacity"> <small
										class="text-danger error" id="seatCapacityError"></small>
								</div>
								<div class="col-md-4 ">

									<div class="form-group ">
										<label for="selectFuelType " style="margin-bottom: 8px">Fuel
											Type<sup class="text-danger">*</sup></label><select id="selectFuelType" name="fuelType"
											class="form-control">
											<option value="" selected disabled>Select Fuel Type</option>
											<option value="Diesel">Diesel</option>
											<option value="Petrol">Petrol</option>
											<option value="CNG">CNG</option>
											<option value="Electric">Electric</option>
										</select> <small class="text-danger error" id="fuelTypeError"></small>
									</div>

								</div>
								<div class="col-md-4">
									<label for="inputModelName" class="form-label">Model
										Name<sup class="text-danger">*</sup></label> <input type="text" name="modelName" class="form-control" maxlength="20"
										placeholder="Enter Model Name" id="inputModelName"> <small
										class="text-danger error" id="modelNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="inputModelYear" class="form-label">Model
										Year<sup class="text-danger">*</sup></label> <input type="date" name="modelYear" class="form-control"
										id="inputModelYear"> <small class="text-danger error"
										id="modelYearError"></small>
								</div>
								<div class="form-group col-md-4">
									<label for="Select " style="margin-bottom: 8px">Vendor<sup class="text-danger">*</sup></label>
									<select id="vendor" name="vendor" class="form-control">
										<option disabled selected hidden>Select Vendor</option>
										<%
										String query = "SELECT * FROM vendors;";
										PreparedStatement st = con.prepareStatement(query);
										ResultSet rs = st.executeQuery();

										while (rs.next()) {
											String vendor = rs.getString("organization");
										%>
										<option><%=vendor%></option>
										<%
										}
										%>

									</select> <small class="text-danger error" id="vendorError"></small>

								</div>
								<br> <br>
								<!-- 	<h3 style="margin-top: 5%">Insurance Details:</h3> -->
								<br>
								<div class="col-md-4">
									<label for="inputModel" class="form-label">Insurance
										Company<sup class="text-danger">*</sup></label> <input type="text" name="insuranceCompany"
										class="form-control" id="insuranceCompany" maxlength="20"
										placeholder="Enter Company Name"> <small
										class="text-danger error" id="insuranceCompanyError"></small>
								</div>
								<div class="col-md-4">
									<label for="inputModel" class="form-label">Policy
										Number<sup class="text-danger">*</sup></label> <input type="text" name="policyNumber"
										class="form-control" id="policyNumber" maxlength="20"
										placeholder="Enter Policy Number"> <small
										class="text-danger error" id="policyNumberError"></small>
								</div>
								<div class="col-md-4">
									<label for="insuranceExpiryDate" class="form-label">Insurance
										Expiry Date<sup class="text-danger">*</sup></label> <input type="date" name="insuranceExpiryDate"
										class="form-control" id="insuranceExpiryDate"> <small
										class="text-danger error" id="insuranceExpiryError"></small>
								</div>
								<div class="col-md-4">
									<label for="inputPolutionCertificate" class="form-label">Polution
										Certificate Expiry Date<sup class="text-danger">*</sup></label> <input type="date"
										name="polutionExpiryDate" class="form-control"
										id="inputPolutionCertificate"> <small
										class="text-danger error" id="polutionExpiryError"></small>
								</div>
								<div class="col-md-4 ">

									<div class="form-group ">
										<label for="gps " style="margin-bottom: 8px">GPS </label> <select
											id="gps" name="gps" class="form-control">
											<option>No</option>
											<option>Yes</option>
										</select>
									</div>

								</div>
								<div class="col-md-4 ">

									<div class="form-group ">
										<label for="selectFuelType" style="margin-bottom: 8px">Speed
											Governor </label> <select id="speed" name="speed"
											class="form-control">
											<option>No</option>
											<option>Yes</option>
										</select>
									</div>

								</div>

								<div class="text-center">
									<button type="submit" class="btn btn-success">
										<%=isUpdate ? "Update Vehicle" : "Add Vehicle"%>
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>

	<script src="js/vehicle-master.js"></script>

</body>
</html>
