/**
 * 
 */
$(document).ready(function (){
		/* Search Box Logic */
		$("#searchBox")
									.on(
											"keydown",
											function(e) {

												if (e.key === "Enter") {

													e.preventDefault();

													let value = $(this).val()
															.trim();

													let vehicleType = $(
															"#selectdepartment")
															.val();

													let url = window.location.pathname
															+ "?search="
															+ encodeURIComponent(value);

													if (vehicleType) {
														url += "&vehicleType="
																+ encodeURIComponent(vehicleType);
													}

													window.location.href = url;

												}

											});

							$("#selectdepartment")
									.on(
											"change",
											function() {

												let department = $(this).val();
												let search = $("#searchBox")
														.val();

												let url = window.location.pathname
														+ "?department="
														+ encodeURIComponent(department);

												if (search) {
													url += "&search="
															+ encodeURIComponent(search);
												}

												window.location.href = url;

											});
		/* Delete driver code */
		$(document).on("click", ".delete-btn",function (e){
			 e.preventDefault();
			 var driverId = $(this).attr("data-driverId");
			 const row = $(this).closest("tr");
			$.ajax({
				url: "driverMasterDelete.jsp",
				type: "POST",
	            data: {driverId:driverId},
	            dataType:"json",
	            beforeSend: function () {
	                $("#divLoading").addClass('show');
	            },
	            success: function (response) {
	                $("#divLoading").removeClass('show');
	                if(response.status === "success"){
	                	 row.remove();
	                Swal.fire({
	                    icon: 'success',
	                    title: 'Success',
	                    text: 'Driver Deleted Successfully',
	                    confirmButtonText: 'OK',
	                    allowOutsideClick: false
	                }).then(() => {
	                    window.location.reload();
	                });

	                }
	                else {
	                	 Swal.fire({
	                         icon: 'error',
	                         title: 'error',
	                         text: 'Something went wrong',
	                         confirmButtonText: 'OK',
	                         allowOutsideClick: false
	                     });
	                
	                }
	            },
	            error: function (xhr) {
	                $("#divLoading").removeClass('show');
	                /* Swal.fire("Error", xhr.responseText, "error"); */
	                Swal.fire({
	                    icon: 'error',
	                    title: 'error',
	                    text: 'Something went wrong',
	                    confirmButtonText: 'OK',
	                    allowOutsideClick: false
	                });
	            }
	        });
		
		})
		
		/* update button logic */
		$(document).on("click", ".update-btn", function (e) {
			 
			
			 $("#updateModal").modal('show');
			let driverId= $(this).attr("data-driverId");
			console.log(driverId);
			$.ajax({
				url:"getDriverDetails.jsp",
				type: "GET",
				data: {driver_id : driverId},
				dataType: "json",
				success: function (response){
					if(response.status === "success"){
						let data= response.data;
						$("#driverId").val(data.driver_id);
						$("#firstName").val(data.first_name);
						$("#middleName").val(data.middle_name);
						$("#lastName").val(data.last_name);
						$("#contactNumber").val(data.contact_number);
						$("#licenceNumber").val(data.licence_number);
						$("#licenceType").val(data.licence_type);
						$("#licenceDate").val(data.licence_date);
						$("#driverAddress").val(data.driver_address);
						$("#vehicleType").val(data.vehicle_type);
						$("#experience").val(data.experience);
						$("#training").val(data.training);
						} else{
						console.log("Not able to get data.")
					}
				}	
			})
		});

		/* Update driver code */
		  $("#submitForm").on("submit", function (e) {
			  e.preventDefault(); 
			  $(".error").text("");
	            $(".form-control").removeClass("error-border");
		        let isValid = true;

		        let driverId = $("#driverId").val().trim();
		        let firstName = $("#firstName").val().trim();
		        let middleName = $("#middleName").val().trim();
		        let lastName = $("#lastName").val().trim();
		        let phone = $("#contactNumber").val().trim();
		        let licenceNumber = $("#licenceNumber").val().trim();
		        let licenceType = $("#licenceType").val();
		        let licenceDate = $("#licenceDate").val();
		        let address = $("#driverAddress").val().trim();
		        let vehicleType = $("#vehicleType").val();
		        let experience = $("#experience").val();
		        let training = $("#training").val();

		        let nameRegex = /^[A-Za-z\s]+$/;
		        let phoneRegex = /^[0-9]{10}$/;
		        let driverIdRegex = /^[A-Za-z0-9]+$/;

		        /* Driver ID */

		      if (driverId === "") {
				    $("#driverIdError").text("Please enter Driver ID");
				    isValid = false;
				}
				else if (!driverIdRegex.test(driverId)) {
				    $("#driverIdError").text("Driver ID must be alphanumeric");
				    isValid = false;
				}

		        /* First Name */
		        if (firstName === "" || !nameRegex.test(firstName)) {
		        	$("#firstNameError").text("First name is required");
		            isValid = false;
		        }

		        /* Middle Name */
		      /*   if (middleName === "" || !nameRegex.test(middleName)) {
		            Swal.fire("Validation Error","Enter valid Middle Name","warning");
		            return;
		        } */

		        /* Last Name */
		        if (lastName === "" || !nameRegex.test(lastName)) {
		        	$("#lastNameError").text("Last name is required");
		            isValid = false;
		        }

		        /* Phone Number */
		        if (!phoneRegex.test(phone)) {
		        	$("#contactNumberError").text("Enter contact number");
		            isValid = false;
		        }

		        /* Licence Number */
		        if (licenceNumber === "") {
		        	$("#licenceNumberError").text("Licence number is required");
		            isValid = false;
		        }

		        /* Licence Date */
		        if (licenceDate === "") {
		        	$("#licenceDateError").text("Licence date is required");
		            isValid = false;
		        }

		        let licenceExpiry = new Date(licenceDate);
		        let todayDate = new Date();
		        todayDate.setHours(0,0,0,0);

		        if (licenceExpiry <= todayDate) {
		        	$("#licenceExpiryError").text("First name is required");
		            isValid = false;
		        }
		        if (!licenceType) {
		        	$("#licenceTypeError").text("Please select licence type");
		            isValid = false;
		        }

		        /* Address */
		        if (address === "") {
		        	$("#addressError").text("Enter address");
		            isValid = false;
		        }

		        /* Vehicle Type */
		        if (!vehicleType ) {
		        	$("#vehicleTypeError").text("Select vehicle type");
		            isValid = false;
		        }

		        /* Experience */
		        if (experience === "" || experience < 0 || experience > 50) {
		        	$("#experienceError").text("Experience is required");
		            isValid = false;
		        }

		        /* Training */
		         if (training === "") {
		        	$("#driverIdError").text("First name is required");
		            isValid = false;
		        } 

		        if(!isValid) return;
		        $.ajax({
		            url: "driverMasterUpdate.jsp",
		            type: "POST",
		            data: $(this).serialize(),
		            dataType:"json",
		            beforeSend: function () {
		                $("#divLoading").addClass('show');
		            },
		            success: function (response) {
		                $("#divLoading").removeClass('show');
		                if(response.status === "success"){
		                Swal.fire({
		                    icon: 'success',
		                    title: 'Success',
		                    text: 'Driver Updated Successfully',
		                    confirmButtonText: 'OK',
		                    allowOutsideClick: false
		                }).then(() => {
		                    /* $("#submitForm")[0].reset(); */
		                	 $("#updateModal").modal('hide');
		                	  window.location.reload();
		                });

		                }
		                else {
		                	 Swal.fire({
		                         icon: 'error',
		                         title: 'error',
		                         text: 'Something went wrong',
		                         confirmButtonText: 'OK',
		                         allowOutsideClick: false
		                     });
		                
		                }
		                
		                

		            },
		            error: function (xhr) {
		                $("#divLoading").removeClass('show');
		                /* Swal.fire("Error", xhr.responseText, "error"); */
		                Swal.fire({
		                    icon: 'error',
		                    title: 'error',
		                    text: 'Something went wrong',
		                    confirmButtonText: 'OK',
		                    allowOutsideClick: false
		                });
		            }
		        });
		    });


	})