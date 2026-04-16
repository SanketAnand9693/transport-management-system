<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Master</title>

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
							<h5 class="card-title1 text-center fw-bolder">Staff
								Registration</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">
								<div class="col-md-4">
									<label for="staffId" class="form-label">Staff ID<sup class="text-danger">*</sup></label> <input
										type="text" name="staffId" class="form-control" id="staffId" placeholder="Enter Staff ID" maxlength="15"
									>
									<small
										class="text-danger error" id="staffIdError"></small>
								</div>
								<div class="col-md-4">
									<label for="department" class="form-label">Departmemt<sup class="text-danger">*</sup></label> <input
										type="text" class="form-control" name="department"
										id="department" placeholder="Enter Department">
										<small
										class="text-danger error" id="departmentError"></small>
								</div>

								<div class="col-md-4">
									<label for="guardianContactNumber" class="form-label">Guardian
										Contact Number<sup class="text-danger">*</sup></label> <input type="tel" maxlength="10"
										class="form-control" name="guardianContactNumber"
										id="guardianContactNumber" placeholder="Enter Contact Number">
										<small
										class="text-danger error" id="contactNumberError"></small>
								</div>

								<div class="col-md-4">
									<label for="staffFirstName" class="form-label">First
										Name<sup class="text-danger">*</sup></label> <input type="text" name="staffFirstName" maxlength="15"
										class="form-control" id="staffFirstName" placeholder="Enter First Name">
										<small
										class="text-danger error" id="firstNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="staffMiddleName" class="form-label">Middle
										Name</label> <input type="text" class="form-control" maxlength="15"
										name="staffMiddleName" id="staffMiddleName" placeholder="Enter Middle Name">
										<small
										class="text-danger error" id="middleNameError"></small>
								</div>
								<div class="col-md-4">
									<label for="staffLastName" class="form-label">Last Name<sup class="text-danger">*</sup></label>
									<input type="text" name="staffLastName" class="form-control" maxlength="15"
										id="staffLastName" placeholder="Enter Last Name"><small
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
									<label for="address" class="form-label">Staff Address<sup class="text-danger">*</sup></label> <input
										type="text" class="form-control" name="address" id="address" placeholder="Enter Address" maxlength="50"
										>
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

	<script src="js/staff-master.js"></script>



</body>
</html>