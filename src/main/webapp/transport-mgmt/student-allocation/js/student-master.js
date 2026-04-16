/**
 * 
 */
$(document).ready(function () {

	    $("#submitForm").on("submit", function (e) {

	        e.preventDefault();
	        $(".error").text("");
            $(".form-control").removeClass("error-border");
	        let isValid = true;

	        let studentId = ($("#studentId").val() || "").trim();
	       /*  let satsId = ($("#satsId").val() || "").trim(); */
	        let studentClass = $("#studentClass").val()
	       /*  let admissionNo = ($("#admissionNo").val() || "").trim(); */
	        let guardianPhone = ($("#guardianContactNumber").val() || "").trim();
	        let firstName = ($("#firstName").val() || "").trim();
	     /*    let middleName = ($("#middleName").val() || "").trim(); */
	        let lastName = ($("#lastName").val() || "").trim();
	        let pickupPoint = ($("#pickupDropPoint").val() || "").trim();
	        let address = ($("#address").val() || "").trim();

	        let nameRegex = /^[A-Za-z\s]+$/;
	        let phoneRegex = /^[0-9]{10}$/;

	        /* Student ID */
	        if (studentId === "") {
	        	 $("#studentIdError").text("Please enter student ID");
				    isValid = false;
	        }

	        /* SATS ID */
/* 	        if (satsId === "") {
	        	$("#satsIdError").text("Enter SATS ID");
			    isValid = false;
	        }
 */
	        /* Admission Number */
	       /*  if (admissionNo === "") {
	        	$("#admissionNoError").text("Enter admission number");
			    isValid = false;
	        }
 */
	        /* Class */
	        if (!studentClass) {
	        	$("#classError").text("Select class");
			    isValid = false;
	        }

	        /* Guardian Phone */
	        if (!phoneRegex.test(guardianPhone)) {
	        	$("#contactNoError").text("Enter contact number");
			    isValid = false;
	        }

	        /* First Name */
	        if (firstName === "" || !nameRegex.test(firstName)) {
	        	$("#firstNameError").text("Enter first name ");
			    isValid = false;
	        }

	        /* Middle Name */
	     /*    if (middleName === "" || !nameRegex.test(middleName)) {
	           $("#middleNameError").text("Enter middle name ");
				    isValid = false;
	        }
 */
	        /* Last Name */
	        if (lastName === "" || !nameRegex.test(lastName)) {
	        	 $("#lastNameError").text("Enter last name");
				    isValid = false;
	        }

	        /* Pickup Drop Point */
	        if (pickupPoint === "") {
	        	 $("#pickupDropError").text("Please enter pickup drop point");
				    isValid = false;
	        }

	        /* Address */
	        if (address === "") {
	        	 $("#addressError").text("Please enter driver address");
				    isValid = false;
	        }

	        if(!isValid) return;

	        /* AJAX */

	        $.ajax({
	            url: "studentMasterSubmit.jsp",
	            type: "POST",
	            data: $("#submitForm").serialize(),
	            dataType: "json",

	            beforeSend: function () {
	                $("#divLoading").addClass('show');
	            },

	            success: function (response) {

	                $("#divLoading").removeClass('show');

	                if (response.status === "success") {

	                    Swal.fire({
	                        icon: 'success',
	                        title: 'Success',
	                        text: 'Student Added Successfully'
	                    }).then(() => {

	                        $("#submitForm")[0].reset();

	                    });

	                } else {

	                    Swal.fire({
	                        icon: 'error',
	                        title: 'Error',
	                        text: 'Something went wrong'
	                    });

	                }

	            },

	            error: function () {

	                $("#divLoading").removeClass('show');

	                Swal.fire({
	                    icon: 'error',
	                    title: 'Error',
	                    text: 'Something went wrong'
	                });

	            }

	        });

	    });

	});