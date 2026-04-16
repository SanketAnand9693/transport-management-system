<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>


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
							<h5 class="card-title1 text-center fw-bolder">Driver
								Registration</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">
								<div class="col-md-4">
									<label for="driverId" class="form-label">Driver ID<sup
										class="text-danger">*</sup></label> <input type="text" name="driverId"
										class="form-control" id="driverId" maxlength="15"
										placeholder="Enter Driver ID"> <small
										class="text-danger error" id="driverIdError"></small>
								</div>
								<div class="col-md-4">
									<label for="firstName" class="form-label">Driver First
										Name<sup class="text-danger">*</sup>
									</label> <input type="text" name="firstName" class="form-control"
										maxlength="15" id="firstName" placeholder="Enter First Name"><small
										class="text-danger error" id="firstNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="middleName" class="form-label">Driver
										Middle Name</label> <input type="text" name="middleName"
										maxlength="15" class="form-control" id="middleName"
										placeholder="Enter Middle Name">

								</div>
								<div class="col-md-4">
									<label for="lastName" class="form-label">Driver Last
										Name<sup class="text-danger">*</sup>
									</label> <input type="text" name="lastName" class="form-control"
										maxlength="15" id="lastName" placeholder="Enter Last Name">
									<small class="text-danger error" id="lastNameError"></small>
								</div>

								<div class="col-md-4">
									<label for="phoneNumber" class="form-label">Driver
										Contact Number<sup class="text-danger">*</sup>
									</label> <input type="tel" name="phoneNumber" maxlength="10"
										class="form-control" id="phoneNumber"
										placeholder="Enter Contact Number"><small
										class="text-danger error" id="contactNumberError"></small>
								</div>
								<div class="col-md-4">
									<label for="licenceNumber" class="form-label">Licence
										Number<sup class="text-danger">*</sup>
									</label> <input type="text" name="licenceNumber" class="form-control"
										id="licenceNumber" maxlength="15" placeholder="Enter Licence">
									<small class="text-danger error" id="licenceNumberError"></small>
								</div>
								<div class="col-md-4 ">
									<div class="form-group ">
										<label for="licenceType" style="margin-bottom: 8px">Licence
											Type<sup class="text-danger">*</sup>
										</label> <select id="licenceType" name="licenceType"
											class="form-control">
											<option disabled selected>Select Licence Type</option>
											<option>LMV</option>
											<option>HMV</option>
											<option>LMV + HMV</option>
										</select> <small class="text-danger error" id="licenceTypeError"></small>
									</div>
								</div>
								<div class="col-md-4">
									<label for="licenceDate" class="form-label">License
										Validity Date<sup class="text-danger">*</sup>
									</label> <input type="date" name="licenceDate" class="form-control"
										id="licenceDate"> <small class="text-danger error"
										id="licenceDateError"></small>
								</div>
								<div class="col-md-7">
									<label for="driverAddress" class="form-label">Driver
										Address<sup class="text-danger">*</sup>
									</label> <input type="text" name="driverAddress" maxlength="50"
										class="form-control" id="driverAddress"
										placeholder="Enter Address"><small
										class="text-danger error" id="driverAddressError"></small>
								</div>

								<div class="col-md-4 ">

									<div class="form-group ">
										<label for="selectType" style="margin-bottom: 8px">Vehicle
											Type<sup class="text-danger">*</sup>
										</label> <select id="selectType" name="vehicleType"
											class="form-control">
											<option disabled selected>Select Vehicle Type</option>
											<option>Van</option>
											<option>Tempo</option>
											<option>Bus</option>
											<option>Mini Bus</option>
										</select> <small class="text-danger error" id="vehicleTypeError"></small>
									</div>

								</div>





								<div class="col-md-4">
									<label for="experience" class="form-label">Experience
										In Years<sup class="text-danger">*</sup>
									</label> <input type="number" name="experience" class="form-control"
										id="experience"> <small class="text-danger error"
										id="experienceError"></small>
								</div>
								<div class="col-md-4 ">

									<div class="form-group ">
										<label for="training" style="margin-bottom: 8px">First
											Aid Training</label> <select id="training" name="training"
											class="form-control">
											<option>Not Completed</option>
											<option>Completed</option>
										</select>
									</div>

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

	<script src="js/driver-master.js"></script>
</body>
</html>