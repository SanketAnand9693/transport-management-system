/**
 * 
 */
$(document).ready(function (){
		/* Search Box Logic */
	$("#searchBox").on("keydown", function (e) {

    if (e.key === "Enter") {

        e.preventDefault();

        let value = $(this).val().trim();
        let stdClass = $("#selectclass").val();

        let url = window.location.pathname;

        if (value) {
            url += "?search=" + encodeURIComponent(value);
        }

        if (stdClass) {
            url += (value ? "&" : "?") + "class=" + encodeURIComponent(stdClass);
        }

        window.location.href = url;
    }

});


$("#selectclass").on("change", function () {

    let stdClass = $(this).val();
    let search = $("#searchBox").val();

    let url = window.location.pathname;

    if (stdClass) {
        url += "?class=" + encodeURIComponent(stdClass);

        if (search) {
            url += "&search=" + encodeURIComponent(search);
        }
    }
    else if (search) {
        url += "?search=" + encodeURIComponent(search);
    }

    window.location.href = url;

});
		/* Delete Staff - code */
		$(document).on("click", ".delete-btn",function (e){
			 e.preventDefault();
			 var studentId = $(this).attr("data-studentId");
			 const row = $(this).closest("tr");
			$.ajax({
				url: "studentMasterDelete.jsp",
				type: "POST",
	            data: {student_id:studentId},
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
	                    text: 'Student Deleted Successfully',
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
			let studentId= $(this).attr("data-studentId");
			console.log(studentId);
			$.ajax({
				url:"getStudentDetails.jsp",
				type: "GET",
				data: {student_id : studentId},
				dataType: "json",
				success: function (response){
					if(response.status === "success"){
						let data= response.data;
						$("#studentId").val(data.student_id);
						$("#studentClass").val(data.student_class);
						$("#guardianContactNumber").val(data.guardian_number);
						$("#firstName").val(data.first_name);
						$("#middleName").val(data.middle_name);
						$("#lastName").val(data.last_name);
						$("#pickupDropPoint").val(data.pickup_drop_point);
						$("#address").val(data.address);
						
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

		        let studentId = ($("#studentId").val() || "").trim();
		       /*  let satsId = ($("#satsId").val() || "").trim(); */
		        let studentClass = $("#studentClass").val()
		       /*  let admissionNo = ($("#admissionNo").val() || "").trim(); */
		        let guardianPhone = ($("#guardianContactNumber").val() || "").trim();
		        let firstName = ($("#firstName").val() || "").trim();
		        let middleName = ($("#middleName").val() || "").trim();
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
		        if (middleName === "" || !nameRegex.test(middleName)) {
		           $("#middleNameError").text("Enter middle name ");
					    isValid = false;
		        }

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

		        $.ajax({
		            url: "studentMasterUpdate.jsp",
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
		                    text: 'Student Updated Successfully',
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