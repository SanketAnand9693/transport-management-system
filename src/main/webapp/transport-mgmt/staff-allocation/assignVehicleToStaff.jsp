<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Details</title>

<link href="${pageContext.request.contextPath }/assets/css/style.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/assets/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<%
	int pageNo = 1;
	int recordsPerPage = 10;

	String search = request.getParameter("search");
	if (search == null)
		search = "";

	String department = request.getParameter("department");
	if (department == null)
		department = "";

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
						<div class="card-header text-light mb-3"
							style="background-color: #6810c0;">
							<h5 class="card-title1 text-center fw-bolder">Assign Vehicle
								To Staffs</h5>
						</div>

						<div class="card-body">

							<!-- Search Box -->
							<div class="container center">
								<div class="row ">

									<div class="row col-md-6">

										<h6 class="col-md-4 mt-2">Select Department:</h6>

										<div class="col-md-4">

											<select id="selectdepartment" class="form-control">

												<option value="">Select Dept</option>

												<%
												PreparedStatement deptQuery = con.prepareStatement("SELECT department_name FROM department ORDER BY department_name");

												ResultSet deptRs = deptQuery.executeQuery();

												while (deptRs.next()) {
													String deptName = deptRs.getString("department_name");
												%>

												<option value="<%=deptName%>"
													<%=deptName.equals(department) ? "selected" : ""%>>
													<%=deptName%>
												</option>

												<%
												}

												deptRs.close();
												deptQuery.close();
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

							<!-- Table -->
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>S No.</th>
											<th>Department</th>
											<th>Staff ID</th>
											<th>Name</th>
											<th>Pickup/Drop Point</th>
											<th></th>
											<th class="">Action</th>
											<th></th>
										</tr>
									</thead>
									<tbody>

										<%
										PreparedStatement pst = con.prepareStatement(
												"SELECT * FROM staff WHERE (staff_id LIKE ? OR first_name LIKE ? OR last_name LIKE ?) AND department LIKE ? ORDER BY staff_id LIMIT ? OFFSET ?");

										pst.setString(1, "%" + search + "%");
										pst.setString(2, "%" + search + "%");
										pst.setString(3, "%" + search + "%");
										pst.setString(4, "%" + department + "%");
										pst.setInt(5, recordsPerPage);
										pst.setInt(6, start);

										ResultSet rs = pst.executeQuery();

										int count = start + 1;

										while (rs.next()) {

											String staffId = rs.getString("staff_id");
											String departments = rs.getString("department");
										%>

										<tr>

											<td><%=count%></td>

											<td><%=departments%></td>

											<td><%=staffId%></td>

											<td><%=rs.getString("first_name") + " " + rs.getString("last_name")%></td>

											<td><%=rs.getString("pickup_drop_point")%></td>

											<%
											PreparedStatement verify = con.prepareStatement("SELECT staff_id FROM staff_to_vehicle WHERE staff_id=?");

											verify.setString(1, staffId);

											ResultSet ver = verify.executeQuery();

											if (ver.next()) {
											%>

											<td>
												<button type="button" disabled style="width: 100px"
													class="btn btn-success font-bold assign-btn"
													data-staffId="<%=staffId%>">Assigned</button>
											</td>

											<%
											} else {
											%>

											<td>
												<button type="button" style="width: 100px"
													class="btn btn-primary font-bold assign-btn"
													data-staffId="<%=staffId%>">Assign</button>
											</td>

											<%
											}
											%>

											<td>
												<button type="button"
													class="btn btn-warning font-bold edit-btn"
													data-staffId="<%=staffId%>">Edit</button>
											</td>

											<td>
												<button type="button"
													class="btn btn-danger font-bold unassign-btn"
													data-staffId="<%=staffId%>">Unassign</button>
											</td>

										</tr>

										<%
										count++;
										}

										rs.close();
										pst.close();
										%>

									</tbody>
								</table>
								<%
								PreparedStatement countStmt = con.prepareStatement(
										"SELECT COUNT(*) FROM staff WHERE (staff_id LIKE ? OR first_name LIKE ? OR last_name LIKE ?) AND department LIKE ?");

								countStmt.setString(1, "%" + search + "%");
								countStmt.setString(2, "%" + search + "%");
								countStmt.setString(3, "%" + search + "%");
								countStmt.setString(4, "%" + department + "%");

								ResultSet countRs = countStmt.executeQuery();

								int totalRecords = 0;

								if (countRs.next()) {
									totalRecords = countRs.getInt(1);
								}

								int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

								countRs.close();
								countStmt.close();
								%>

								<nav aria-label="Page navigation">
									<ul class="pagination justify-content-center">

										<%
										if (pageNo > 1) {
										%>

										<li class="page-item"><a class="page-link"
											href="?page=<%=pageNo - 1%>&search=<%=search%>&department=<%=department%>">
												Previous </a></li>

										<%
										}

										for (int i = 1; i <= totalPages; i++) {
										%>

										<li class="page-item <%=(i == pageNo) ? "active" : ""%>">
											<a class="page-link"
											href="?page=<%=i%>&search=<%=search%>&department=<%=department%>">
												<%=i%>
										</a>
										</li>

										<%
										}

										if (pageNo < totalPages) {
										%>

										<li class="page-item"><a class="page-link"
											href="?page=<%=pageNo + 1%>&search=<%=search%>&department=<%=department%>">
												Next </a></li>

										<%
										}
										%>

									</ul>
								</nav>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="updateModal" tabindex="-1">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">

										<div class="modal-header">
											<h5 class="modal-title">
												<strong>Assign Vehicle</strong>
											</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal"></button>
										</div>

										<div class="modal-body">

											<form class="row g-3" method="post" id="submitForm">

												<!-- Hidden Field -->
												<input type="hidden" id="staffId" name="staffId">

												<div class="form-group">
													<label style="margin-bottom: 8px"> Route Number </label> <select
														id="routeNumber" name="routeNumber" class="form-control">
														<option disabled selected hidden>Select Route</option>
														<%
														String routeNumber = null;
														String query1 = "SELECT * FROM route;";
														PreparedStatement pst1 = con.prepareStatement(query1);
														ResultSet prs = pst1.executeQuery();

														while (prs.next()) {
															routeNumber = prs.getString("route_number");
														%>
														<option value="<%=routeNumber%>">
															<%=routeNumber%>
														</option>
														<%
														}
														%>
													</select>
												</div>

												<div class="form-group">
													<label style="margin-bottom: 8px"> Vehicle Number </label>
													<select id="vehicleNumber" name="vehicleNumber"
														class="form-control">
														<option disabled selected hidden>Select Vehicle
															Number</option>
													</select>
												</div>

												<div class="col-md-4" id="error"></div>

												<div class="col-12 mb-5 text-center">
													<button type="submit" class="btn btn-primary">
														Submit</button>
												</div>

											</form>


										</div>
									</div>

								</div>
							</div>

						</div>
						<!-- card-body -->
					</div>
					<!-- card -->

				</div>
				<!-- col-lg-12 -->
			</div>
			<!-- row -->
		</section>
	</main>

	<script src="js/assign-vehicle-to-staff.js"></script>
</body>
</html>