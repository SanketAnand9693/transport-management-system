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

	String studentClass = request.getParameter("class");
	if (studentClass == null)
		studentClass = "";

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
							<h5 class="card-title1 text-center fw-bolder">Assign Vehicle
								To Students</h5>
						</div>

						<div class="card-body">

							<div class="row ">

								<div class="row col-md-6">
									<h6 class="col-md-3 mt-2">Select Class:</h6>
									<div class="col-md-4">
										<select id="selectclass" name="class" class="form-control">
											<option value="">Select Class</option>
											<%
											PreparedStatement classQuery = con.prepareStatement(
													"SELECT * FROM class ORDER BY FIELD(class_name,'LKG','UKG','1','2','3','4','5','6','7','8','9','10','11','12')");
											ResultSet cq = classQuery.executeQuery();

											while (cq.next()) {
												String cls = cq.getString("class_name");
											%>
											<option value="<%=cls%>"
												<%=cls.equals(studentClass) ? "selected" : ""%>>
												<%=cls%>
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

							<!-- Table -->
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>S No.</th>
											<th>Course</th>
											<!-- <th>Admission No.</th> -->
											<th>Student ID</th>
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
												"SELECT * FROM student WHERE (student_id LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR pickup_drop_point LIKE ?) AND student_class LIKE ? ORDER BY student_id LIMIT ? OFFSET ?");

										pst.setString(1, "%" + search + "%");
										pst.setString(2, "%" + search + "%");
										pst.setString(3, "%" + search + "%");
										pst.setString(4, "%" + search + "%");
										pst.setString(5, "%" + studentClass + "%");
										pst.setInt(6, recordsPerPage);
										pst.setInt(7, start);

										ResultSet rs = pst.executeQuery();

										int count = start + 1;

										while (rs.next()) {

											String studentId = rs.getString("student_id");
											String stdClass = rs.getString("student_class");
										%>

										<tr>
											<td><%=count%></td>
											<td><%=stdClass%></td>
											<!-- <td></td> -->
											<td><%=studentId%></td>
											<td><%=rs.getString("first_name") + " " + rs.getString("last_name")%></td>
											<td><%=rs.getString("pickup_drop_point")%></td>

											<%
											PreparedStatement verify = con.prepareStatement("SELECT student_id FROM student_to_vehicle WHERE student_id=?");
											verify.setString(1, studentId);

											ResultSet ver = verify.executeQuery();

											if (ver.next()) {
											%>
											<td>
												<button type="button" disabled style="width:100px "
													class="btn btn-success font-bold update-btn"
													data-studentId="<%=studentId%>">Assigned</button>
											</td>
											<%
											} else {
											%>
											<td>
												<button type="button" style="width:100px "
													class="btn btn-primary font-bold update-btn"
													data-studentId="<%=studentId%>">Assign</button>
											</td>
											<%
											}
											%>

											<td>
												<button type="button"
													class="btn btn-warning font-bold edit-btn"
													data-studentId="<%=studentId%>">Edit</button>
											</td>

											<td>
												<button type="button"
													class="btn btn-danger font-bold unassign-btn"
													data-studentId="<%=studentId%>">Unassign</button>
											</td>
										</tr>

										<%
										count++;
										}
										%>
									</tbody>
								</table>
								<%
								PreparedStatement countStmt = con.prepareStatement(
										"SELECT COUNT(*) FROM student WHERE (student_id LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR pickup_drop_point LIKE ?) AND student_class LIKE ?");

								countStmt.setString(1, "%" + search + "%");
								countStmt.setString(2, "%" + search + "%");
								countStmt.setString(3, "%" + search + "%");
								countStmt.setString(4, "%" + search + "%");
								countStmt.setString(5, "%" + studentClass + "%");

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
											href="?page=<%=pageNo - 1%>&search=<%=search%>&class=<%=studentClass%>">
												Previous </a></li>

										<%
										}

										for (int i = 1; i <= totalPages; i++) {
										%>

										<li class="page-item <%=(i == pageNo) ? "active" : ""%>">

											<a class="page-link"
											href="?page=<%=i%>&search=<%=search%>&class=<%=studentClass%>">
												<%=i%>
										</a>

										</li>

										<%
										}

										if (pageNo < totalPages) {
										%>

										<li class="page-item"><a class="page-link"
											href="?page=<%=pageNo + 1%>&search=<%=search%>&class=<%=studentClass%>">
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
												<strong>Student Registration</strong>
											</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal"></button>
										</div>

										<div class="modal-body">

											<form class="row g-3" method="post" id="submitForm">

												<!-- Hidden Field -->
												<input type="hidden" id="studentId" name="studentId">

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
	<script src="js/assign-vehicle-to-student.js"></script>
</body>
</html>