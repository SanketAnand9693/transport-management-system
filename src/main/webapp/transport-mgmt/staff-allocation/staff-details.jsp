<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>

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

<html>
<head>
<meta charset="UTF-8">
<title>Staff Details</title>

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
							<h5 class="card-title1 text-center fw-bolder">Staffs List</h5>
						</div>

						<div class="card-body">

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

							<table class="table table-hover">

								<thead>

									<tr>
										<td><strong>S No.</strong></td>
										<td><strong>Staff ID</strong></td>
										<td><strong>Name</strong></td>
										<td><strong>Department</strong></td>
										<td><strong>Update</strong></td>
										<td><strong>Delete</strong></td>
									</tr>

								</thead>

								<tbody>

									<%
									PreparedStatement pst1 = con.prepareStatement(
											"SELECT * FROM staff WHERE (staff_id LIKE ? OR first_name LIKE ? OR last_name LIKE ?) AND department LIKE ? ORDER BY staff_id LIMIT ? OFFSET ?");

									pst1.setString(1, "%" + search + "%");
									pst1.setString(2, "%" + search + "%");
									pst1.setString(3, "%" + search + "%");
									pst1.setString(4, "%" + department + "%");
									pst1.setInt(5, recordsPerPage);
									pst1.setInt(6, start);

									ResultSet rs = pst1.executeQuery();

									int count = start + 1;

									while (rs.next()) {

										String staffId = rs.getString("staff_id");
										String departments = rs.getString("department");
									%>

									<tr>

										<td><%=count%></td>

										<td><%=staffId%></td>

										<td><%=rs.getString("first_name") + " " + rs.getString("last_name")%></td>

										<td><%=departments%></td>

										<td>
											<button type='button'
												class='btn btn-primary font-bold update-btn'
												data-staffId="<%=staffId%>">Update</button>
										</td>

										<td>
											<button type='button' class='btn btn-danger delete-btn'
												data-staffId="<%=staffId%>">Delete</button>
										</td>

									</tr>

									<%
									count++;
									}

									rs.close();
									pst1.close();
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
							<div class="modal fade" id="updateModal" tabindex="-1">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">

										<div class="modal-header">
											<h5 class="modal-title">
												<strong>Staff Registration</strong>
											</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal"></button>
										</div>

										<div class="modal-body">

											<form class="row g-3" method="post" id="submitForm">
												<div class="col-md-4">
													<label for="staffId" class="form-label">Staff ID<sup class="text-danger">*</sup></label>
													<input type="text" name="staffId" class="form-control"
														id="staffId" placeholder="Enter Staff ID" maxlength="15" readonly>
													<small class="text-danger error" id="staffIdError"></small>
												</div>
												<div class="col-md-4">
													<label for="department" class="form-label">Departmemt<sup class="text-danger">*</sup></label>
													<input type="text" class="form-control" name="department"
														id="department" placeholder="Enter Department"> <small
														class="text-danger error" id="departmentError"></small>
												</div>

												<div class="col-md-4">
													<label for="guardianContactNumber" class="form-label">Guardian
														Contact Number<sup class="text-danger">*</sup>
													</label> <input type="tel" maxlength="10" class="form-control"
														name="guardianContactNumber" id="guardianContactNumber"
														placeholder="Enter Contact Number"> <small
														class="text-danger error" id="contactNumberError"></small>
												</div>

												<div class="col-md-4">
													<label for="staffFirstName" class="form-label">First
														Name<sup class="text-danger">*</sup>
													</label> <input type="text" name="staffFirstName" maxlength="15"
														class="form-control" id="staffFirstName"
														placeholder="Enter First Name"> <small
														class="text-danger error" id="firstNameError"></small>
												</div>
												<div class="col-md-4">
													<label for="staffMiddleName" class="form-label">Middle
														Name</label> <input type="text" class="form-control"
														maxlength="15" name="staffMiddleName" id="staffMiddleName"
														placeholder="Enter Middle Name"> <small
														class="text-danger error" id="middleNameError"></small>
												</div>
												<div class="col-md-4">
													<label for="staffLastName" class="form-label">Last
														Name<sup class="text-danger">*</sup>
													</label> <input type="text" name="staffLastName"
														class="form-control" maxlength="15" id="staffLastName"
														placeholder="Enter Last Name"><small
														class="text-danger error" id="lastNameError"></small>
												</div>

												<div class="col-md-4">
													<label for="pickupDropPoint" class="form-label">Pickup/Drop
														Point<sup class="text-danger">*</sup>
													</label> <input type="text" name="pickupDropPoint" maxlength="20"
														class="form-control" id="pickupDropPoint"
														placeholder="Enter Pickup/Drop Location"> <small
														class="text-danger error" id="pickupDropError"></small>
												</div>

												<div class="col-md-8">
													<label for="address" class="form-label">Staff
														Address<sup class="text-danger">*</sup>
													</label> <input type="text" class="form-control" name="address"
														id="address" placeholder="Enter Address" maxlength="50">
													<small class="text-danger error" id="addressError"></small>
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

	<script src="js/staff-details.js"></script>

</body>
</html>