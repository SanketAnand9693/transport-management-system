<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Driver Master</title>

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
						<div class="card-header text-light mb-3"
							style="background-color: #6810c0;">
							<h5 class="card-title1 text-center fw-bolder">Route Master</h5>
						</div>
						<div class="card-body">
							<form class="row g-3" method="post" id="submitForm">
								<div class="col-md-4">
									<label for="routeName" class="form-label">Route Name<sup
										class="text-danger">*</sup></label> <input type="text"
										name="routeName" class="form-control" id="routeName" required>
								</div>

								<div class="col-md-12">
									<hr>
								</div>
								<div class="col-md-2">
									<label for="busStop1" class="form-label">Bus Stop 1</label> <input
										type="text" name="busStop1" class="form-control" id="busStop1">

								</div>
								<div class="col-md-2">
									<label for="busStop2" class="form-label">Bus Stop 2</label> <input
										type="text" name="busStop2" class="form-control" id="busStop2">
								</div>

								<div class="col-md-2">
									<label for="busStop3" class="form-label">Bus Stop 3</label> <input
										type="text" name="busStop3" class="form-control" id="busStop3">
								</div>

								<div class="col-md-2">
									<label for="busStop4" class="form-label">Bus Stop 4</label> <input
										type="text" name="busStop4" class="form-control" id="busStop4">
								</div>

								<div class="col-md-2">
									<label for="busStop5" class="form-label">Bus Stop 5</label> <input
										type="text" name="busStop5" class="form-control" id="busStop5">
								</div>

								<div class="col-md-2">
									<label for="busStop6" class="form-label">Bus Stop 6</label> <input
										type="text" name="busStop6" class="form-control" id="busStop6">
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
		</section>
	</main>

	<script src="js/route-master.js"></script>
</body>
</html>