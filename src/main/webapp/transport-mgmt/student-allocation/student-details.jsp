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
							<h5 class="card-title1 text-center fw-bolder">Students List</h5>
						</div>
						<div class="card-body">
							<!-- Search Box -->
							<div class="container center">
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
							</div>
							<div class="table-responsive">
								<table class="table table-hover">
									<thead>
										<tr>
											<td><strong> S No.</strong></td>
											<td><strong>Student ID</strong></td>
											<td><strong>Class</strong></td>
											<td><strong>Name</strong></td>
											<td><strong>Update</strong></td>
											<td><strong>Delete</strong></td>
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
											<td><%=studentId%></td>
											<td><%=stdClass%></td>
											<td><%=rs.getString("first_name") + " " + rs.getString("last_name")%></td>
											<td><button type='button'
													class='btn btn-primary font-bold update-btn'
													data-studentId=<%=studentId%>>Update</button></td>
											<td><button type='button'
													class='btn btn-danger delete-btn'
													data-studentId=<%=studentId%>>Delete</button></td>

										</tr>

										<%
										count++;
										}

										rs.close();
										pst.close();
										%>
									</tbody>
								</table>
							</div>
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
							<!-- Dialog box  -->
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
								<div class="col-md-4">
									<label for="studentId" class="form-label">Student ID<sup class="text-danger">*</sup></label> <input
										type="text" name="studentId" class="form-control" maxlength="15"
										id="studentId" placeholder="Enter Student ID" readonly>
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
						</div>
					</div>
				</div>
			</div>

		</section>
	</main>

	<script src="js/student-details.js"></script>
</body>
</html>