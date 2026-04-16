<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>
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
<title>Vehicle Details</title>

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
							<h5 class="card-title1 text-center fw-bolder">Vehicle List</h5>
						</div>
						<div class="card-body">
							<!-- Search Box -->
							<div class="container center">
								<div class="row ">

									<div class="row col-md-6">
										<h6 class="col-md-3 mt-2">Select Type:</h6>
										<div class="col-md-4">
											<select id="selectType" name="vehicleType" class="form-control">
												<option value="">Select Type</option>
												<%
												PreparedStatement classQuery = con.prepareStatement("SELECT DISTINCT vehicle_type FROM vehicle;");
												ResultSet cq = classQuery.executeQuery();

												while (cq.next()) {
													String vt = cq.getString("vehicle_type");
												%>
												<option value="<%=vt%>"
													<%=vt.equals(vehicleType) ? "selected" : ""%>>
													<%=vt%>
												</option>
												<%
												}

												cq.close();
												classQuery.close();
												%>
											</select>
										</div>
									</div>

									<div class="col-md-3 offset-md-3">
										<div class="search-container">
											<input type="text" id="searchBox" value="<%=search%>"
												class="form-control search-input"
												placeholder="Search By ID, Name, Type">
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-hover ">
									<thead>
										<tr>
											<td><strong> S No.</strong></td>
											<td><strong>Bus No.</strong></td>
											<td><strong>Type</strong></td>
											<td class="text-center"><strong>Update</strong></td>

											<td class="text-center"><strong>Status</strong></td>
										</tr>
									</thead>
									<tbody>
										<%
										PreparedStatement pst = con.prepareStatement(
												"SELECT * FROM vehicle WHERE (vehicle_number LIKE ? OR vehicle_type LIKE ?) AND vehicle_type LIKE ?	ORDER BY vehicle_number LIMIT ? OFFSET ?");

												pst.setString(1, "%" + search + "%");
												pst.setString(2, "%" + search + "%");
												pst.setString(3, "%" + vehicleType + "%");
												pst.setInt(4, recordsPerPage);
												pst.setInt(5, start);

										ResultSet rss = pst.executeQuery();
										int count = start + 1;
										while (rss.next()) {
											String vehicleNumber = rss.getString("vehicle_number");
										%>
										<tr>
											<td><%=count%></td>
											<td><%=vehicleNumber%></td>
											<td><%=rss.getString("vehicle_type")%></td>
											<td class="text-center"><button
													class='btn btn-primary update-btn'
													data-vehicleNumber=<%=vehicleNumber%>>Update</button></td>
											<td class='text-center'><button type='button'
													class='btn btn-danger delete-btn'
													data-vehicleNumber=<%=vehicleNumber%>>Delete</button></td>
										</tr>

										<%
										count++;
										}
										%>
									</tbody>
								</table>
							</div>

							<!-- Dialog box  -->
							<div class="modal fade" id="updateModal" tabindex="-1">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">

										<div class="modal-header">
											<h5 class="modal-title">Vehicle Registration</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal"></button>
										</div>

										<div class="modal-body">

											<form class="row g-3" method="post" id="submitForm">



												<div class="col-md-4">
													<label for="inputVehicleNumber" class="form-label">Vehicle
														Number<sup class="text-danger">*</sup></label> <input type="text" name="vehicleNumber"
														id="vehicleNumber" class="form-control" readonly required>
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
													<label for="seatCapacity" class="form-label">Seating
														Capacity<sup class="text-danger">*</sup></label> <input type="number" name="seatCapacity"
														class="form-control" id="seatCapacity" >
														<small class="text-danger error" id="seatCapacityError"></small>
												</div>
												<div class="col-md-4 ">
													<div class="form-group ">
														<label for="fuelType " style="margin-bottom: 8px">Fuel
															Type<sup class="text-danger">*</sup></label> <select name="fuelType" id="fuelType"
															class="form-control">
															<option value="">Select</option>
															<option>Diesel</option>
															<option>Petrol</option>
															<option>CNG</option>
															<option>Electric</option>
														</select>
														<small class="text-danger error" id="fuelTypeError"></small>
													</div>

												</div>
												<div class="col-md-4">
													<label for="modelName" class="form-label">Model
														Name<sup class="text-danger">*</sup></label> <input type="text" name="modelName"
														class="form-control" id="modelName">
														<small class="text-danger error" id="modelNameError"></small>
												</div>
												<div class="col-md-4">
													<label for="modelYear" class="form-label">Model
														Year<sup class="text-danger">*</sup></label> <input type="date" name="modelYear"
														class="form-control" id="modelYear">
														<small class="text-danger error" id="modelYearError"></small>
												</div>
												<div class="form-group col-md-4">
													<label style="margin-bottom: 8px">Vendor<sup class="text-danger">*</sup></label> <select
														id="vendor" name="vendor" class="form-control">
														<%
														String query = "SELECT organization FROM vendors";
														PreparedStatement st = con.prepareStatement(query);
														ResultSet rs = st.executeQuery();

														while (rs.next()) {
															String vendor = rs.getString("organization").trim();
														%>
														<option value="<%=vendor%>"><%=vendor%></option>
														<%
														}

														rs.close();
														st.close();
														%>
													</select>
													<small class="text-danger error" id="vendorError"></small>
												</div>

												<br> <br>
												<!-- 	<h3 style="margin-top: 5%">Insurance Details:</h3> -->
												<br>
												<div class="col-md-4">
													<label for="inputModel" class="form-label">Insurance
														Company<sup class="text-danger">*</sup></label> <input type="text" name="insuranceCompany"
														class="form-control" id="insuranceCompany">
														<small class="text-danger error" id="insuranceCompanyError"></small>
												</div>
												<div class="col-md-4">
													<label for="inputModel" class="form-label">Policy
														Number<sup class="text-danger">*</sup></label> <input type="text" name="policyNumber"
														class="form-control" id="policyNumber">
														<small class="text-danger error" id="policyNumberError"></small>
												</div>
												<div class="col-md-4">
													<label for="insuranceExpiry" class="form-label">Insurance
														Expiry Date<sup class="text-danger">*</sup></label> <input type="date" name="insuranceExpiry"
														class="form-control" id="insuranceExpiry">
														<small class="text-danger error" id="insuranceExpiryError"></small>
												</div>
												<div class="col-md-4">
													<label for="polutionExpiry" class="form-label">Polution
														Certificate Expiry Date<sup class="text-danger">*</sup></label> <input type="date"
														name="polutionExpiry" class="form-control"
														id="polutionExpiry">
														<small class="text-danger error" id="polutionExpiryError"></small>
												</div>
												<div class="col-md-4 ">

													<div class="form-group ">
														<label for="gps " style="margin-bottom: 8px">GPS </label>
														<select id="gps" name="gps" class="form-control">
															<option></option>
															<option>No</option>
															<option>Yes</option>
														</select>
													</div>

												</div>
												<div class="col-md-4 ">

													<div class="form-group ">
														<label for="speed" style="margin-bottom: 8px">Speed
															Governor </label> <select id="speed" name="speed"
															class="form-control">
															<option></option>
															<option>No</option>
															<option>Yes</option>
														</select>
													</div>

												</div>
												<div class="text-center">
													<button type="submit" class="btn btn-success">Update
														Vehicle</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<%
							PreparedStatement countStmt = con.prepareStatement(
									"SELECT COUNT(*) FROM vehicle WHERE (vehicle_number LIKE ? OR vehicle_type LIKE ?) AND vehicle_type LIKE ?");

									countStmt.setString(1, "%" + search + "%");
									countStmt.setString(2, "%" + search + "%");
									countStmt.setString(3, "%" + vehicleType + "%");

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

<script src="js/vehicle-details.js"></script>
</body>
</html>