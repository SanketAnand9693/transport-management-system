<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Master</title>

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
							<h5 class="card-title1 text-center fw-bolder">Student Registration</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">
								<div class="col-md-4">
									<label for="studentId" class="form-label">Student ID<sup class="text-danger">*</sup></label> <input
										type="text" name="studentId" class="form-control" maxlength="15"
										id="studentId" placeholder="Enter Student ID">
										<small
										class="text-danger error" id="studentIdError"></small>
								</div>
							<!-- 		<div class="col-md-4">
									<label for="satsId" class="form-label">SATS ID</label> <input
										type="text" name="satsId" class="form-control"
										id="satsId" placeholder="Enter SATS ID">
										<small
										class="text-danger error" id="satsIdError"></small>
								</div> -->
							<!-- 		<div class="col-md-4">
									<label for="admissionNo" class="form-label">Admission No.</label> <input
										type="text" name="admissionNo" class="form-control"
										id="admissionNo" placeholder="Enter Admission Number">
										<small
										class="text-danger error" id="admissionNoError"></small>
								</div> -->
								
								<div class="col-md-2 ">
									<div class="form-group ">
										<label for="studentClass" style="margin-bottom: 8px">Class<sup class="text-danger">*</sup></label> <select id="studentClass" name="studentClass"
											class="form-control">
											<option disabled selected>Select</option>
											<option>LKG</option>
											<option>UKG</option>
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
											<option>11</option>
											<option>12</option>
										</select>
										<small
										class="text-danger error" id="classError"></small>
									</div>
								</div>

								<div class="col-md-4">
									<label for="guardianContactNumber" class="form-label">Guardian
										Contact Number<sup class="text-danger">*</sup></label> <input type="tel" name="guardianContactNumber"
										maxlength="10" class="form-control" id="guardianContactNumber" placeholder="Enter Contact Number"
										>
										<small
										class="text-danger error" id="contactNoError"></small>
								</div>

								<div class="col-md-4">
									<label for="firstName" class="form-label">First Name<sup class="text-danger">*</sup></label> <input
										type="text" name="firstName" class="form-control" maxlength="15"
										id="firstName" placeholder="Enter First Name" >
										<small
										class="text-danger error" id="firstNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="middleName" class="form-label">Middle Name</label>
									<input type="text" name="middleName" class="form-control" maxlength="15"
										id="middleName" placeholder="Enter Middle Name">
										
								</div>
								<div class="col-md-4">
									<label for="lastName" class="form-label">Last Name<sup class="text-danger">*</sup></label> <input
										type="text" name="lastName" class="form-control" id="lastName" placeholder="Enter last Name" maxlength="15"
										>
										<small
										class="text-danger error" id="lastNameError"></small>
								</div>

								<div class="col-md-4">
									<label for="pickupDropPoint" class="form-label">Pickup/Drop
										Point<sup class="text-danger">*</sup></label> <input type="text" name="pickupDropPoint" maxlength="20"
										class="form-control" id="pickupDropPoint" placeholder="Enter Pickup/Drop Location">
										<small
										class="text-danger error" id="pickupDropError"></small>
								</div>
							
								<div class="col-md-8">
									<label for="address" class="form-label">Student Address<sup class="text-danger">*</sup></label>
									<input type="text" name="address" class="form-control" maxlength="50"
										id="address" placeholder="Enter Address">
										<small
										class="text-danger error" id="addressError"></small>
								</div>



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

	<script src="js/student-master.js"></script>
</body>
</html>