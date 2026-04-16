<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../dbconnectconfig/db_Connect.jsp"%>
<%@ include file="/includes/commonFile.jsp"%>
<%@ include file="/includes/header.jsp"%>
<%@ include file="/includes/sideBar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Dashboard</title>

<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>

<body>



	<%
	String totalVehicle = "0";
	String activeVehicle = "0";
	String totalDriver = "0";
	String activeDriver = "0";
	PreparedStatement tv = con.prepareStatement("SELECT COUNT(*) AS total FROM vehicle;");

	ResultSet rs = tv.executeQuery();

	if (rs.next()) {
		totalVehicle = rs.getString("total");
	}

	PreparedStatement av = con
			.prepareStatement("SELECT COUNT(vehicle_number) AS total FROM vehicle WHERE stats = 'active'");

	ResultSet rsav = av.executeQuery();

	if (rsav.next()) {
		activeVehicle = rsav.getString("total");
	}
	//-----------------
	/* Total Drivers */
	PreparedStatement td = con.prepareStatement("SELECT COUNT(*) AS total FROM driver");

	ResultSet rstd = td.executeQuery();

	if (rstd.next()) {
		totalDriver = rstd.getString("total");
	}

	/* Active Drivers */
	PreparedStatement ad = con.prepareStatement("SELECT COUNT(driver_id) AS total FROM driver WHERE stats = 'active'");

	ResultSet rsad = ad.executeQuery();

	if (rsad.next()) {
		activeDriver = rsad.getString("total");
	}

	/* Close resources (recommended) */
	rstd.close();
	td.close();

	rsad.close();
	ad.close();
	%>

	<main id="main" class="main">
		<section class="section">

			<div class="row">

				<div class="col-lg-12">
					<div class="card rounded-4 shadow-sm">

						<!-- Header -->
						<div class="card-header text-center"
							style="background-color: #6810c0;">
							<h5 class="card-title mb-0 text-light">
								<strong>Dashboard</strong>
							</h5>
						</div>

						<!-- Body -->
						<div class="card-body">
							<div class="row g-3 mt-2">

								<!-- Card 1 -->
								<div class="col-md-4">
								<a href="./vehicle/vehicle-details.jsp">
									<div class="card gradient-blue text-white rounded-4 shadow dashboard-card">
										<div class="card-body text-center">
											<h5 class="card-title">Total Vehicles</h5>
											<p class="card-text"><%=totalVehicle%></p>
										</div>
									</div>
									</a>
								</div>

								<!-- Card 2 -->

								<div class="col-md-4">
									<a href="./vehicle/vehicle-details.jsp"
										class="text-decoration-none">
										<div class="card gradient-green text-white rounded-4 shadow dashboard-card">
											<div class="card-body text-center">
												<h5 class="card-title">Active Vehicles</h5>
												<p class="card-text"><%=activeVehicle%></p>
											</div>
										</div>
									</a>
								</div>

								<!-- Card 3 -->
								<div class="col-md-4">
								<a href="./driver/driver-details.jsp"
										class="text-decoration-none">
									<div class="card gradient-red text-white rounded-4 shadow dashboard-card">
										<div class="card-body text-center">
											<h5 class="card-title">Drivers</h5>
											<p class="card-text"><%=activeDriver%>
												/
												<%=totalDriver%></p>
										</div>
									</div>
									</a>
								</div>

							</div>
						</div>

					</div>
				</div>

			</div>

		</section>
	</main>


</body>
<style>
.dashboard-card {
	transition: all 0.3s ease;
	cursor: pointer;
}

.dashboard-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
}

.gradient-blue {
	background: linear-gradient(45deg, #36d1dc, #5b86e5);
	color: white;
	border: none;
}

.gradient-green {
	background: linear-gradient(45deg, #11998e, #38ef7d);
	color: white;
	border: none;
}

.gradient-red {
	background: linear-gradient(45deg, #ff416c, #ff4b2b);
	color: white;
	border: none;
}
</style>
</html>