<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<%@ include file="../dbconnectconfig/db_Connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>sosv</title>
<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<script src="assets/js/jquery.min.js"></script>
<%-- <%@ include file="valueFetch.jsp"%>  --%>
</head>
<body>
	<%@ include file="/includes/commonFile.jsp"%>
	<%@ include file="/includes/header.jsp"%>
	<%@ include file="/includes/sideBar.jsp"%>
	<main id="main" class="main">
		<div id="divLoading"></div>

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-header text-black bg-light mb-3">
							<h5 class="card-title1 text-center">Student Enquiry Form</h5>
						</div>
						<div class="card-body">

							<form class="row g-3" method="POST" id="lrentry" role="form"
								novalidate>

								<%
								try {
									Statement st = con.createStatement();
									ResultSet rs = st.executeQuery("select DISTINCT institution_name from college_master");
								%>
								<div class="col-md-4">
									<label for="instname" class="form-label">Institution
										Name <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">

										<select class="form-select"
											aria-label="Default select example" name="instname"
											id="instname" onchange="showCategory(this.value, 'category')"
											style="background-color: #FFF8DC;" required>
											<option value="" disabled selected>Select</option>
											<%
											while (rs.next()) {
											%>
											<option value="<%=rs.getString("institution_name")%>"><%=rs.getString("institution_name")%></option>

											<%
											}
											%>
										</select>
										<%
										} catch (Exception e) {
										out.print(e.getMessage());
										%>
										<%
										}
										//finally{
										//  st.close();
										//con.close();
										//}
										%>
										<div class="invalid-feedback">Select institution</div>
									</div>
								</div>


								<div class="col-md-4">
									<label for="city" class="form-label">City <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">

										<select class="form-select"
											aria-label="Default select example" id="city" name="city"
											onchange="showProducts(this.value, 'subcategory')"
											style="background-color: #FFF8DC;" required>
										</select>
										<div class="invalid-feedback">Select city</div>

									</div>
								</div>

								<div class="col-md-4">
									<label for="branch" class="form-label">Branch/Location
										<span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">

										<select class="form-select"
											aria-label="Default select example" id="branch" name="branch"
											style="background-color: #FFF8DC;" required>
										</select>
										<div class="invalid-feedback">Select branch</div>
									</div>
								</div>


								<div class="col-md-4">
									<label for="studname" class="form-label"> Child Full
										Name <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id='studname' name=""
											placeholder="" required maxlength="40"
											style="text-transform: capitalize;"
											oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
										<div class="invalid-feedback">Enter child name</div>
									</div>
								</div>

								<div class="col-md-3">
									<label for="dob" class="form-label">Date of Birth <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id="dob"
											name="date_of_birth" placeholder="dd/mm/yyyy"
											autocomplete="off" maxlength="10" required
											pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}"> <span
											class="input-group-text"> <i
											class="bi bi-calendar-event"></i>
										</span>
										<div class="invalid-feedback">Enter date of birth</div>
									</div>
								</div>

								<div class="col-md-3" hidden>
									<label for="dobinwords" class="form-label">Dob In Words
										<span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id='dobinwords'
											name="dob_in_words" style="background-color: lightgrey;"
											readonly>

										<div class="invalid-feedback">Enter Date of Birth In
											Words</div>
									</div>
								</div>

								<div class="col-md-2" hidden>
									<label for="age" class="form-label">Age <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control bg-light" id="age"
											name="age" readonly>

										<div class="invalid-feedback">Enter Age</div>
									</div>
								</div>

								<div class="col-md-1">
									<label for="years" class="form-label">Years <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control bg-light" id="years"
											name="years" readonly>

										<div class="invalid-feedback">Enter Years</div>
									</div>
								</div>
								<div class="col-md-2">
									<label for="months" class="form-label">Months <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control bg-light" id='months'
											name="months" readonly>

										<div class="invalid-feedback">Enter Months</div>
									</div>
								</div>

								<div class="col-md-2">
									<label for="months" class="form-label">Days <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control bg-light" id='days'
											name="days" readonly>

										<div class="invalid-feedback">Enter days</div>
									</div>
								</div>

								<%
								try {
									Statement st = con.createStatement();
									ResultSet rs = st.executeQuery("select completed_program from completed_program");
								%>
								<div class="col-md-4">
									<label for="compprog" class="form-label">Completed
										Program <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<select class="form-select"
											aria-label="Default select example" name="compprog"
											id="compprog" required>
											<option value="" disabled selected>Select</option>
											<%
											while (rs.next()) {
											%>
											<option value="<%=rs.getString("completed_program")%>"><%=rs.getString("completed_program")%></option>

											<%
											}
											%>
										</select>

										<%
										} catch (Exception e) {
										out.print(e.getMessage());
										%>
										<%
										}
										//finally{
										//  st.close();
										//con.close();
										//}
										%>
										<div class="invalid-feedback">Select Completed program</div>
									</div>
								</div>



								<%
								try {
									Statement st = con.createStatement();
									ResultSet rs = st.executeQuery("select coursename from course_master");
								%>
								<div class="col-md-4">
									<label for="inputName5" class="form-label">Joining
										Program <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<select class="form-select"
											aria-label="Default select example" name="intprog"
											id="intprog" required>
											<option value="" disabled selected>Select</option>
											<%
											while (rs.next()) {
											%>
											<option value="<%=rs.getString("coursename")%>"><%=rs.getString("coursename")%></option>

											<%
											}
											%>
										</select>

										<%
										} catch (Exception e) {
										out.print(e.getMessage());
										%>
										<%
										}
										//finally{
										//  st.close();
										//con.close();
										//}
										%>
										<div class="invalid-feedback">Select Interested program</div>
									</div>
								</div>



								<div class="col-md-4">
									<label for="inputName5" class="form-label">Program Type
										<span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<select class="form-select"
											aria-label="Default select example" id="ptype" required>
											<option value="" disabled selected>Select</option>
											<option value="Regular">Regular</option>
											<option value="3 Hours">Day Care</option>


										</select>
										<div class="invalid-feedback">Select program type</div>
									</div>

								</div>

								<div class="col-md-3">
									<label for="studname" class="form-label"> Father Name <span
										style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id='parentname'
											name="" placeholder="" required maxlength="22"
											style="text-transform: capitalize;"
											oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
										<div class="invalid-feedback">Enter name</div>
									</div>
								</div>


								<div class="col-md-3">
									<label for="paroccupation" class="form-label">Father
										Occupation <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<select class="form-select"
											aria-label="Default select example" id="paroccupation"
											required>
											<option value="" disabled selected>Select</option>
											<option value="Teacher">Teacher</option>
											<option value="Lecturer">Lecturer</option>
											<option value="Farmer">Farmer</option>
											<option value="Businessman">Businessman</option>
											<option value="Advocate">Advocate</option>
											<option value="Engineer">Engineer</option>
											<option value="Doctor">Doctor</option>
											<option value="Other">Other</option>

										</select>
										<div class="invalid-feedback">Select occupation</div>
									</div>
								</div>

								<div class="col-md-2">
									<label for="studcontno" class="form-label"> Father
										Contact <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id="studcontno"
											name="" required maxlength="10" pattern="[0-9]{10}"
											oninput="this.value = this.value.replace(/[^0-9]/g, '')">
										<div class="invalid-feedback">Enter a valid 10-digit
											number</div>
									</div>
								</div>

								<div class="col-md-4">
									<label for="studemail" class="form-label"> Father Email
										Id <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="email" class="form-control" id="studemail"
											name="student_email_id" required
											pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
											oninput="validateEmail(this)">
										<div class="invalid-feedback">Enter a valid email
											address</div>
									</div>
								</div>

								<div class="col-md-3">
									<label for="studname" class="form-label"> Mother Name <span
										style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id='parentname'
											name="" placeholder="" required maxlength="22"
											style="text-transform: capitalize;"
											oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
										<div class="invalid-feedback">Enter name</div>
									</div>
								</div>



								<div class="col-md-3">
									<label for="paroccupation" class="form-label">Mother
										Occupation <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<select class="form-select"
											aria-label="Default select example" id="paroccupation"
											required>
											<option value="" disabled selected>Select</option>
											<option value="Teacher">Teacher</option>
											<option value="Lecturer">Lecturer</option>
											<option value="Farmer">Farmer</option>
											<option value="Businessman">Businessman</option>
											<option value="Advocate">Advocate</option>
											<option value="Engineer">Engineer</option>
											<option value="Doctor">Doctor</option>
											<option value="House Wife">House Wife</option>
											<option value="Other">Other</option>

										</select>
										<div class="invalid-feedback">Select occupation</div>
									</div>
								</div>

								<div class="col-md-2">
									<label for="parentcontno" class="form-label"> Mother
										Contact <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id="parentcontno"
											name="" required maxlength="10" pattern="[0-9]{10}"
											oninput="this.value = this.value.replace(/[^0-9]/g, '')">
										<div class="invalid-feedback">Enter a valid 10-digit
											number</div>
									</div>
								</div>

								<div class="col-md-4">
									<label for="parentemail" class="form-label"> Mother
										Email Id <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<input type="email" class="form-control" id="parentemail"
											name="" required
											pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
											oninput="validateEmail(this)">
										<div class="invalid-feedback">Enter a valid email
											address</div>
									</div>
								</div>


								<div class="col-md-4">
									<label for="inputName5" class="form-label">Address <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<textarea class="form-control" id="addr" placeholder=""
											placeholder="" required maxlength="400"
											style="text-transform: capitalize;" required></textarea>
										<div class="invalid-feedback">Enter address</div>
									</div>
								</div>





								<div class="col-md-3">
									<label class="form-label">Transport Required <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<select class="form-select" id="transportRequired" required
											onchange="toggleKM()">
											<option value="" disabled selected>Select</option>
											<option value="Yes">Yes</option>
											<option value="No">No</option>
										</select>
										<div class="invalid-feedback">Select Option</div>
									</div>
								</div>

								<div class="col-md-2">
									<label class="form-label">KM <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<select class="form-select" id="kmSelect" disabled>
											<option value="" disabled selected>Select</option>
											<option value="1-2">1-2 KM</option>
											<option value="2-4">2-4 KM</option>
											<option value="4-6">4-6 KM</option>
										</select>
										<div class="invalid-feedback">Select KM</div>
									</div>
								</div>

								<div class="col-md-3">
									<label for="cit" class="form-label">Pickup Point <span
										style="color: #FF0000;">*</span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id="cit"
											name="city_village" maxlength="60" disabled
											style="text-transform: capitalize;"
											oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
										<div class="invalid-feedback">Enter pickup point</div>
									</div>
								</div>

								<div class="col-md-4">
									<label for="inputName5" class="form-label">How did you
										heard about cambridge.? <span style="color: #FF0000;">*</span>
									</label>
									<div class="input-group has-validation">
										<select class="form-select"
											aria-label="Default select example" id="heard" required>
											<option value="" disabled selected>Select</option>
											<option value="friend">Friend</option>
											<option value="pomplet">Pomplet</option>
											<option value="banner">Banner</option>
											<option value="no parking board">No Parking Board</option>
											<option value="news paper">News Paper</option>
											<option value="facebook">Facebook</option>
											<option value="instagram">Instagram</option>
											<option value="other">Other</option>

										</select>
										<div class="invalid-feedback">Select</div>
									</div>

								</div>

								<div class="col-md-4">
									<label for="pin" class="form-label">If Other Specify <span
										style="color: #FF0000;"></span></label>
									<div class="input-group has-validation">
										<input type="text" class="form-control" id="pin"
											name="pincode" maxlength="60">
										<div class="invalid-feedback">Enter Specify</div>
									</div>
								</div>


								<div class="col-md-4" hidden>
									<label for="inputName5" class="form-label">Created Date</label>
									<input type="text" class="form-control" id="cdat"
										placeholder=""
										value="<%=(new java.util.Date()).toLocaleString()%> ">
								</div>

								<div class="text-center">
									<button type="submit" class="btn btn-primary">Submit</button>

								</div>
							</form>

						</div>

					</div>

				</div>


			</div>

		</section>
	</main>
	<!-- End #main -->



	<script>
		$(function() {
			$("input[id='onlynumbers']").on('input', function(e) {
				$(this).val($(this).val().replace(/[^0-9]/g, ''));
			});
		});
	</script>

	<script>
		$(function() {
			$("input[id='onlycharacter']").on('input', function(e) {
				$(this).val($(this).val().replace(/[^A-z]/g, ''));
			});
		});
	</script>

	<script>
		function toggleKM() {
			var transport = document.getElementById("transportRequired").value;
			var km = document.getElementById("kmSelect");
			var pickup = document.getElementById("cit");

			if (transport === "Yes") {
				km.disabled = false;
				km.required = true;

				pickup.disabled = false;
				pickup.required = true;
			} else {
				km.disabled = true;
				km.required = false;
				km.selectedIndex = 0;

				pickup.disabled = true;
				pickup.required = false;
				pickup.value = "";
			}
		}
	</script>

	<script>
		$(document)
				.ready(
						function() {
							$("#lrentry")
									.submit(
											function(e) {
												e.preventDefault(); // Prevent default submission initially

												let form = this;

												// Check if form is valid
												if (!form.checkValidity()) {
													e.stopPropagation(); // Stop further event propagation
													form.classList
															.add("was-validated"); // Show validation messages
													return;
												}

												// If form is valid, proceed with AJAX
												$("div#divLoading").addClass(
														'show'); // Show loading spinner

												let formData = {
													institution_name : $(
															"#instname").val(),
													city : $("#city").val(),
													branch : $("#branch").val(),
													full_name : $("#studname")
															.val(),
													parent_name : $(
															"#parentname")
															.val(),
													parent_occupation : $(
															"#paroccupation")
															.val(),
													completed_program : $(
															"#compprog").val(),
													int_program : $("#intprog")
															.val(),
													program_type : $("#ptype")
															.val(),
													stud_cont_no : $(
															"#studcontno")
															.val(),
													stud_email_id : $(
															"#studemail").val(),
													parent_cont_no : $(
															"#parentcontno")
															.val(),
													parent_email_id : $(
															"#parentemail")
															.val(),
													address : $("#addr").val(),
													state : $("#inputState")
															.val(),
													district : $(
															"#inputDistrict")
															.val(),
													city_village : $("#cit")
															.val(),
													pincode : $("#pin").val(),
													heared_about : $("#heard")
															.val(),
													created_on : $("#cdat")
															.val(),
													date_of_birth : $("#dob")
															.val(),
													dob_in_words : $(
															"#dobinwords")
															.val(),
													age : $("#age").val(),
													years : $("#years").val(),
													months : $("#months").val(),
													days : $("#days").val()
												};

												$
														.ajax({
															type : "POST",
															url : "studentEnquiryDataInsert.jsp",
															data : formData,
															beforeSend : function() {
																$(
																		"div#divLoading")
																		.addClass(
																				'show');
															},
															success : function(
																	response) {
																try {
																	let res = JSON
																			.parse(response);

																	if (res.status === "success") {
																		alert("Enquiry Details Added Successfully");
																		window.location.href = "studentEnquiryForm.jsp";
																	} else {
																		alert("Failed to save enquiry:\n"
																				+ res.message);
																		$(
																				"div#divLoading")
																				.removeClass(
																						'show');
																	}
																} catch (e) {
																	alert("Unexpected server response");
																	$(
																			"div#divLoading")
																			.removeClass(
																					'show');
																}
															}

														});
											});
						});
	</script>

	<script>
		document.addEventListener("DOMContentLoaded", function() {

			const dobInput = document.getElementById("dob");
			const dobWords = document.getElementById("dobinwords");
			const ageInput = document.getElementById("age");
			const yearsInput = document.getElementById("years");
			const monthsInput = document.getElementById("months");
			const daysInput = document.getElementById("days");

			dobInput.addEventListener("blur", function() {

				if (!dobInput.value)
					return;

				const parts = dobInput.value.split("/");
				if (parts.length !== 3)
					return;

				const d = parseInt(parts[0], 10);
				const m = parseInt(parts[1], 10) - 1;
				const y = parseInt(parts[2], 10);

				const dobDate = new Date(y, m, d);
				if (isNaN(dobDate.getTime()))
					return;

				const today = new Date();

				// DOB in words
				dobWords.value = dobDate.toLocaleDateString("en-IN", {
					day : "numeric",
					month : "long",
					year : "numeric"
				});

				let years = today.getFullYear() - dobDate.getFullYear();
				let months = today.getMonth() - dobDate.getMonth();
				let days = today.getDate() - dobDate.getDate();

				// Adjust days
				if (days < 0) {
					months--;
					const prevMonthDays = new Date(today.getFullYear(), today
							.getMonth(), 0).getDate();
					days += prevMonthDays;
				}

				// Adjust months
				if (months < 0) {
					years--;
					months += 12;
				}

				// Final output
				yearsInput.value = years >= 0 ? years : 0;
				monthsInput.value = months >= 0 ? months : 0;
				daysInput.value = days >= 0 ? days : 0;

				ageInput.value = yearsInput.value + " Years "
						+ monthsInput.value + " Months " + daysInput.value
						+ " Days";
			});

		});
	</script>




</body>
</html>