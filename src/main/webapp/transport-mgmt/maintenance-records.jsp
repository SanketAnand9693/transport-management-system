<%@page import="java.beans.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<%@ include file="/dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Maintenance Records</title>

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
							<h5 class="card-title1 text-center fw-bolder">Add Vehicle
								For Maintenance</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">

								<div class="form-group ">
									<label for="Select " style="margin-bottom: 8px">Vehicle
										Number</label> <select id="vehicleNumber" name="vehicleNumber"
										class="form-control">
										<option disabled selected hidden>Select Vehicle
											Number</option>
										<%
										String query = "SELECT * FROM vehicle";
										PreparedStatement st = con.prepareStatement(query);
										ResultSet rs = st.executeQuery();

										while (rs.next()) {
											String vehicleNumber = rs.getString("vehicle_number");
										%>
										<option><%=vehicleNumber%></option>
										<%
										}
										%>

									</select>

								</div>


								<div class="col-md-12">
									<label for="driverAddress" class="form-label">Problems
									</label> <input type="text" name="problems" class="form-control"
										id="problems" required>
								</div>
								<div class="col-md-4">
									<label for="driverAddress" class="form-label">Estimated
										Cost </label> <input type="number" name="cost" class="form-control"
										id="cost" placeholder="In Rupees" required>
								</div>

								<div class="col-md-4" id="error"></div>

								<div class="col-12 mb-5 text-center">
									<button type="submit" class="btn btn-primary" style="width:100px ">Submit</button>
								</div>
							</form>
							<div class="col-md-2 offset-10 mb-2 row text-right">
								<a href="maintenance-history.jsp">Maintenance History</a>
							</div>
						<div class="container center">
								<div class="row ">

									<div class="row col-md-6">
										<h6 class="col-md-3 mt-2">Select Vehicle:</h6>
										<div class="col-md-3">
											<select id="selectclass" name="class" class="form-control">
												<option>Select Vehicle</option>
												<%
												PreparedStatement vehicleQuery = con.prepareStatement(
														"SELECT vehicle_number FROM maintenance ORDER BY vehicle_number;");
												ResultSet cq = vehicleQuery.executeQuery();

												while (cq.next()) {
												%>

												<option value="<%=cq.getString("vehicle_number")%>">
													<%=cq.getString("vehicle_number")%>
												</option>

												<%
												}

												cq.close();
												vehicleQuery.close();
												%>
											</select>
										</div>
									</div>

									<div class="col-md-3 offset-md-3">
										<div class="search-container">
											<input type="text" id="searchBox"
												class="form-control search-input"
												placeholder="Search By ID, Name, Type">
										</div>
									</div>

								</div>
							</div>

							<br>
							<table class="table table-bordered border-primary ">
								<thead>
									<tr>
										<td class="px-3"><strong>S No.</strong></td>
										<td><strong>Vehicle No.</strong></td>
										<td><strong>Problem</strong></td>
										<td><strong>Date</strong></td>
										<td><strong>Estimated Cost</strong></td>
										<td><strong>Status</strong></td>

									</tr>
								</thead>
								<tbody>
									<%
									PreparedStatement pst = con.prepareStatement("SELECT * FROM maintenance WHERE stats is NULL ORDER BY vehicle_number;");
									ResultSet rss = pst.executeQuery();
									int count = 1;
									while (rss.next()) {
										String vehicleNumber = rss.getString("vehicle_number");
										String problem = rss.getString("problems");
										String estCost = rss.getString("cost");
										String date = rss.getString("created_on");
									%>
									<tr>
										<td><%=count%></td>
										<td><%=vehicleNumber%></td>
										<td><%=problem%></td>
										<td><%=date%></td>
										<td>Rs. <%=estCost%></td>
										<td><button type='button' style="width:100px;"
												class='btn btn-danger delete-btn'
												data-vehicleNumber=<%=vehicleNumber%>>Fixed</button></td>

									</tr>
									<%
									count++;
									}
									%>

								</tbody>
							</table>
						</div>

					</div>
				</div>
			</div>
		</section>
	</main>
	<script src="js/maintenance-records.js"></script>


</body>
</html>