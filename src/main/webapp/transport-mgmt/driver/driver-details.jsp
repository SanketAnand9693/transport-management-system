<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!-- Pagination Code -->
<%
int pageNo = 1;
int recordsPerPage = 10;

String search = request.getParameter("search");
if (search == null)
	search = "";

String vehicleType = request.getParameter("vehicleType");
if (vehicleType == null)
	vehicleType = "";

if (request.getParameter("page") != null) {
	pageNo = Integer.parseInt(request.getParameter("page"));
}

int start = (pageNo - 1) * recordsPerPage;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Driver Details</title>

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
							<h5 class="card-title1 text-center fw-bolder">Driver List</h5>
						</div>
						<div class="card-body">
							<div class="col-md-12">
								<!-- Search Box -->
								<div class="container center">
									<div class="container col-md-12">
										<div class="row justify-content-right">
											<div class="col-md-3 offset-9">
												<div class="search-container">
													<input type="text" id="searchBox" value="<%=search%>"
												class="form-control search-input"
												placeholder="Search By ID, Name, Type">
												</div>
											</div>
										</div>
									</div>
								</div>
								<br>

								<table class="table table-hover ">
									<thead>
										<tr>
											<td><strong>S No.</strong></td>
											<td><strong>Driver ID</strong></td>
											<td><strong>Name</strong></td>
											<td><strong>Contact No.</strong></td>
											<td><strong>Vehicle Type</strong></td>
											
											<td><strong>Update</strong></td>
											<td><strong>Delete</strong></td>
										</tr>
									</thead>
									<tbody>
										<%
										PreparedStatement pst = con.prepareStatement(
												"SELECT * FROM driver WHERE driver_id LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR vehicle_type LIKE ? OR licence_type LIKE ? ORDER BY driver_id LIMIT ? OFFSET ?"
												);
										pst.setString(1, "%" + search + "%");
										pst.setString(2, "%" + search + "%");
										pst.setString(3, "%" + search + "%");
										pst.setString(4, "%" + search + "%");
										pst.setString(5, "%" + search + "%");
										pst.setInt(6, recordsPerPage);
										pst.setInt(7, start);
										
										ResultSet rs = pst.executeQuery();
										int count = start + 1;

										while (rs.next()) {
											String driverId = rs.getString("driver_id");
										%>
										<tr>
											<td><%=count%></td>
											<td><%=driverId%></td>
											<td><%=rs.getString("first_name") + " " +rs.getString("last_name") %></td>
											<td><%=rs.getString("contact_number") %></td>
											<td><%=rs.getString("vehicle_type") %></td>
											<td><button type='button'
													class='btn btn-primary font-bold update-btn'
													data-driverId=<%=driverId%>>Update</button></td>
											<td><button type='button'
													class='btn btn-danger delete-btn'
													data-driverId=<%=driverId%>>Delete</button></td>

										</tr>
										<%
										count++;
										}
										%>
									</tbody>
								</table>
								<!-- Dialog box  -->
								<div class="modal fade" id="updateModal" tabindex="-1">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">

											<div class="modal-header">
												<h5 class="modal-title">
													<strong>Driver Registration</strong>
												</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal"></button>
											</div>

											<div class="modal-body">

												<form class="row g-3" method="post" id="submitForm">
													<div class="col-md-4">
														<label for="driverId" class="form-label">Driver ID<sup class="text-danger">*</sup></label>
														<input type="text" name="driverId" class="form-control"
															id="driverId" required readonly>
													</div>
													<div class="col-md-4">
														<label for="firstName" class="form-label">Driver
															First Name<sup class="text-danger">*</sup></label> <input type="text" name="firstName"
															class="form-control" id="firstName" >
															<small class="text-danger error" id="firstNameError"></small>
													</div>
													<div class="col-md-4">
														<label for="middleName" class="form-label">Driver
															Middle Name</label> <input type="text" name="middleName"
															class="form-control" id="middleName" >
															<small class="text-danger error" id="middleNameError"></small>
													</div>
													<div class="col-md-4">
														<label for="lastName" class="form-label">Driver
															Last Name<sup class="text-danger">*</sup></label> <input type="text" name="lastName"
															class="form-control" id="lastName" >
															<small class="text-danger error" id="lastNameError"></small>
													</div>

													<div class="col-md-4">
														<label for="contactNumber" class="form-label">Driver
															Contact Number<sup class="text-danger">*</sup></label> <input type="tel" name="contactNumber"
															maxlength="10" class="form-control" id="contactNumber"
															>
															<small class="text-danger error" id="contactNumberError"></small>
													</div>
													<div class="col-md-4">
														<label for="licenceNumber" class="form-label">Licence
															Number<sup class="text-danger">*</sup></label> <input type="text" name="licenceNumber"
															class="form-control" id="licenceNumber">
															<small class="text-danger error" id="licenceNumberError"></small>
													</div>
													<div class="col-md-4 ">
														<div class="form-group ">
															<label for="licenceType" style="margin-bottom: 8px">Licence
																Type<sup class="text-danger">*</sup></label> <select id="licenceType" name="licenceType"
																class="form-control">
																<option>LMV</option>
																<option>HMV</option>
																<option>LMV + HMV</option>
															</select>
															<small class="text-danger error" id="licenceTypeError"></small>
														</div>
													</div>
													<div class="col-md-4">
														<label for="licenceDate" class="form-label">License
															Validity Date<sup class="text-danger">*</sup></label> <input type="date" name="licenceDate"
															class="form-control" id="licenceDate">
															<small class="text-danger error" id="licenceDateError"></small>
													</div>
													<div class="col-md-7">
														<label for="driverAddress" class="form-label">Driver
															Address<sup class="text-danger">*</sup></label> <input type="text" name="driverAddress"
															class="form-control" id="driverAddress" >
															<small class="text-danger error" id="addressError"></small>
													</div>

													<div class="col-md-4 ">

														<div class="form-group ">
															<label for="vehicleType" style="margin-bottom: 8px">Vehicle
																Type<sup class="text-danger">*</sup></label> <select id="vehicleType" name="vehicleType"
																class="form-control">
																<option value="">Select</option>
																<option>Van</option>
																<option>Tempo</option>
																<option>Bus</option>
																<option>Mini Bus</option>
															</select>
															<small class="text-danger error" id="vehicleTypeError"></small>
														</div>

													</div>

													<div class="col-md-4">
														<label for="experience" class="form-label">Experience
															In Years<sup class="text-danger">*</sup></label> <input type="number" name="experience"
															class="form-control" id="experience">
															<small class="text-danger error" id="experienceError"></small>
													</div>
													<div class="col-md-4 ">

														<div class="form-group ">
															<label for="training" style="margin-bottom: 8px">First
																Aid Training</label> <select id="training" name="training"
																class="form-control">
																<option>Not Completed</option>
																<option>Completed</option>
															</select>
															<small class="text-danger error" id="trainingError"></small>
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
							</div>
								<%
								PreparedStatement countStmt = con.prepareStatement(
								"SELECT COUNT(*) FROM driver WHERE driver_id LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR vehicle_type LIKE ? OR licence_type LIKE ?");

								countStmt.setString(1, "%" + search + "%");
								countStmt.setString(2, "%" + search + "%");
								countStmt.setString(3, "%" + search + "%");
								countStmt.setString(4, "%" + search + "%");
								countStmt.setString(5, "%" + search + "%");

								ResultSet countRs = countStmt.executeQuery();

								int totalRecords = 0;

								if (countRs.next()) {
								totalRecords = countRs.getInt(1);
								}

								int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

								countRs.close();
								countStmt.close();
								%>


							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center">

									<%
									if (pageNo > 1) {
									%>

									<li class="page-item"><a class="page-link"
										href="?page=<%=pageNo - 1%>">Previous</a></li>

									<%
									}

									for (int i = 1; i <= totalPages; i++) {
									%>

									<li class="page-item <%=(i == pageNo) ? "active" : ""%>">

										<a class="page-link" href="?page=<%=i%>"> <%=i%>
									</a>

									</li>

									<%
									}

									if (pageNo < totalPages) {
									%>

									<li class="page-item"><a class="page-link"
										href="?page=<%=pageNo + 1%>">Next</a></li>

									<%
									}
									%>

								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>

	<script src="js/driver-details.js"></script>
</body>
</html>