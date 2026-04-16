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
		
		/* update button logic */
		$(document).on("click", ".update-btn", function (e) {
			
			 $("#updateModal").modal('show');
			let studentId= $(this).attr("data-studentId");
			 $("#studentId").val(studentId);   
			let routeNumber = $(this).attr()
			console.log(studentId);
			$.ajax({
				url:"getStudentDetails.jsp",
				type: "GET",
				data: {student_id : studentId, },
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

		/* update button logic */
		$(document).on("click", ".edit-btn", function (e) {
			
			 $("#updateModal").modal('show');
			let studentId= $(this).attr("data-studentId");
			 $("#studentId").val(studentId);   
			let routeNumber = $(this).attr()
			console.log(studentId);
			$.ajax({
				url:"editAssignedStudent.jsp",
				type: "GET",
				data: {student_id : studentId,},
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


		$(document).on("click", ".unassign-btn", function () {

		    let studentId = $(this).attr("data-studentId");
		    $("#studentId").val(studentId);

		    $.ajax({
		        url: "unassignStudent.jsp",
		        type: "GET",
		        data: { student_id: studentId },
		        dataType: "json",

		        beforeSend: function () {
		            $("#divLoading").addClass("show");
		        },

		        success: function (response) {

		            $("#divLoading").removeClass("show");

		            if (response.status === "success") {

		                console.log("success");

		                Swal.fire({
		                    icon: "success",
		                    title: "Success",
		                    text: "Student Unassigned Successfully",
		                    confirmButtonText: "OK",
		                    allowOutsideClick: false
		                }).then(() => {

		                    $("#updateModal").modal("hide");
		                    window.location.reload();

		                });

		            } else {

		                Swal.fire({
		                    icon: "error",
		                    title: "Error",
		                    text: "Something went wrong",
		                    confirmButtonText: "OK",
		                    allowOutsideClick: false
		                });

		            }
		        },

		        error: function (xhr) {

		            $("#divLoading").removeClass("show");

		            Swal.fire({
		                icon: "error",
		                title: "Error",
		                text: "Something went wrong",
		                confirmButtonText: "OK",
		                allowOutsideClick: false
		            });

		        }
		    });

		});
		/* Update driver code */
		  $("#submitForm").on("submit", function (e) {
			  e.preventDefault(); 
		        $.ajax({
		            url: "assignStudentDetails.jsp",
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
		                    text: 'Student Assigned Successfully',
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
	
	
	//get vehicles according to route number
	document.getElementById("routeNumber").addEventListener("change", function () {

    var routeNumber = this.value;

    fetch("getVehicleForRoute.jsp?routeNumber=" + routeNumber)
        .then(response => response.json())
        .then(data => {

            var vehicleDropdown = document.getElementById("vehicleNumber");
            vehicleDropdown.innerHTML = 
                '<option disabled selected hidden>Select Vehicle Number</option>';

            data.forEach(function (vehicle) {
                var option = document.createElement("option");
                option.value = vehicle;
                option.text = vehicle;
                vehicleDropdown.appendChild(option);
            });
        });
});