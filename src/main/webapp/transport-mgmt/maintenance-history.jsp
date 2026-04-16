<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

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

	<%
	int pageNo = 1;
	int recordsPerPage = 8;

	String search = request.getParameter("search");
	if (search == null)
		search = "";

	String vehicleNumber = request.getParameter("vehicleNumber");
	if (vehicleNumber == null)
		vehicleNumber = "";

	if (request.getParameter("page") != null) {
		pageNo = Integer.parseInt(request.getParameter("page"));
	}

	int start = (pageNo - 1) * recordsPerPage;
	%>
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
							<h5 class="card-title1 text-center fw-bolder">Maintenance
								History</h5>
						</div>
						<div class="card-body">
							<div class="row col-md-6">
								<h6 class="col-md-3 mt-2">Select Vehicle:</h6>
								<div class="col-md-3">
									<select id="selectclass" name="class" class="form-control">
										<option value="">Select Vehicle</option>
										<%
										PreparedStatement vehicleQuery = con
												.prepareStatement("SELECT DISTINCT vehicle_number FROM maintenance ORDER BY vehicle_number;");
										ResultSet cq = vehicleQuery.executeQuery();

										while (cq.next()) {
											String vn = cq.getString("vehicle_number");
										%>

										<option value="<%=vn%>"
											<%=vn.equals(vehicleNumber) ? "selected" : ""%>>
											<%=vn%>
										</option>

										<%
										}

										cq.close();
										vehicleQuery.close();
										%>
									</select>
								</div>
							</div>

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

							<table class="table table-hover ">
								<thead>
									<tr>
										<td><strong> S No.</strong></td>
										<td><strong>Bus No.</strong></td>
										<td><strong>Problem</strong></td>
										<td><strong>Date</strong></td>
										<td><strong>Cost</strong></td>
									</tr>
								</thead>
								<tbody>
									<%
									PreparedStatement pst = con.prepareStatement(
											"SELECT * FROM maintenance WHERE (vehicle_number LIKE ? OR problems LIKE ? OR cost LIKE ?) AND vehicle_number LIKE ? ORDER BY vehicle_number LIMIT ? OFFSET ?");
									pst.setString(1, "%" + search + "%");
									pst.setString(2, "%" + search + "%");
									pst.setString(3, "%" + search + "%");
									pst.setString(4, "%" + vehicleNumber + "%");
									pst.setInt(5, recordsPerPage);
									pst.setInt(6, start);

									ResultSet rss = pst.executeQuery();
									int count = start + 1;
									while (rss.next()) {
										String vehicleN = rss.getString("vehicle_number");
									%>
									<tr>
										<td><%=count%></td>
										<td><%=vehicleN%></td>
										<td><%=rss.getString("problems")%></td>
										<td><%=rss.getString("created_on")%></td>
										<td>Rs. <%=rss.getString("cost")%></td>
									</tr>

									<%
									count++;
									}
									%>
								</tbody>
							</table>
							<!-- Page count for pagination  -->
							<%
							PreparedStatement countStmt = con.prepareStatement(
									"SELECT COUNT(*) FROM maintenance WHERE (vehicle_number LIKE ? OR problems LIKE ? OR cost LIKE ?) AND vehicle_number LIKE ?");
							countStmt.setString(1, "%" + search + "%");
							countStmt.setString(2, "%" + search + "%");
							countStmt.setString(3, "%" + search + "%");
							countStmt.setString(4,  "%" + vehicleNumber + "%");

						
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

										<a class="page-link" href="?page=<%=i%>&search=<%=search%>&vehicleNumber=<%=vehicleNumber%>"> <%=i%>
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
														Number</label> <input type="text" name="vehicleNumber"
														id="vehicleNumber" class="form-control" readonly required>
												</div>

												<div class="col-md-4 ">

													<div class="form-group ">
														<label for="vehicleType" style="margin-bottom: 8px">Vehicle
															Type</label> <select id="vehicleType" name="vehicleType"
															class="form-control">
															<option>Select</option>
															<option>Van</option>
															<option>Tempo</option>
															<option>Bus</option>
															<option>Mini Bus</option>
														</select>
													</div>

												</div>

												<div class="col-md-4">
													<label for="seatCapacity" class="form-label">Seating
														Capacity</label> <input type="number" name="seatCapacity"
														class="form-control" id="seatCapacity" required>
												</div>
												<div class="col-md-4 ">
													<div class="form-group ">
														<label for="fuelType " style="margin-bottom: 8px">Fuel
															Type</label> <select name="fuelType" id="fuelType"
															class="form-control">
															<option value="">Select</option>
															<option>Diesel</option>
															<option>Petrol</option>
															<option>CNG</option>
															<option>Electric</option>
														</select>
													</div>

												</div>
												<div class="col-md-4">
													<label for="modelName" class="form-label">Model
														Name</label> <input type="text" name="modelName"
														class="form-control" id="modelName">
												</div>
												<div class="col-md-4">
													<label for="modelYear" class="form-label">Model
														Year</label> <input type="date" name="modelYear"
														class="form-control" id="modelYear">
												</div>
												<div class="form-group col-md-4">
													<label style="margin-bottom: 8px">Vendor</label> <select
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
												</div>

												<br> <br>
												<div class="col-md-4">
													<label for="inputModel" class="form-label">Insurance
														Company</label> <input type="text" name="insuranceCompany"
														class="form-control" id="insuranceCompany">
												</div>
												<div class="col-md-4">
													<label for="inputModel" class="form-label">Policy
														Number</label> <input type="text" name="policyNumber"
														class="form-control" id="policyNumber">
												</div>
												<div class="col-md-4">
													<label for="insuranceExpiry" class="form-label">Insurance
														Expiry Date</label> <input type="date" name="insuranceExpiry"
														class="form-control" id="insuranceExpiry">
												</div>
												<div class="col-md-4">
													<label for="polutionExpiry" class="form-label">Polution
														Certificate Expiry Date</label> <input type="date"
														name="polutionExpiry" class="form-control"
														id="polutionExpiry">
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
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>

	<script src="js/maintenance-history.js"></script>
</body>
</html>