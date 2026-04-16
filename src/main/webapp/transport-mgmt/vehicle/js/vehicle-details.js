/**
 * 
 */
	$(document).ready(function (e){
		/* Search Box Logic */
	$("#searchBox").on("keydown", function (e) {

    if (e.key === "Enter") {

        e.preventDefault();

        let value = $(this).val().trim();
        let vehicleType = $("#selectType").val();

        let url = window.location.pathname + "?";

        if (value) {
            url += "search=" + encodeURIComponent(value);
        }

        if (vehicleType) {
            url += (value ? "&" : "") + "vehicleType=" + encodeURIComponent(vehicleType);
        }

        window.location.href = url;
    }

});


$("#selectType").on("change", function () {

    let vehicleType = $(this).val();
    let search = $("#searchBox").val();

    let url = window.location.pathname + "?";

    if (vehicleType) {
        url += "vehicleType=" + encodeURIComponent(vehicleType);
    }

    if (search) {
        url += (vehicleType ? "&" : "") + "search=" + encodeURIComponent(search);
    }

    window.location.href = url;

});
		    
		$(document).on("click", ".delete-btn",function (e){
			 e.preventDefault();
			 var vehicleNumber = $(this).attr("data-vehicleNumber");
			 const row = $(this).closest("tr");
			$.ajax({
				url: "vehicleMasterDelete.jsp",
				type: "POST",
	            data: {vehicleNumber:vehicleNumber},
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
	                    text: 'Vehicle Deleted Successfully',
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
			
			let vehicleNumber= $(this).attr("data-vehicleNumber");
			 $("#updateModal").modal('show');
			 
			$.ajax({
				url:"getVehicleDetails.jsp",
				type: "GET",
				data: {vehicle_number : vehicleNumber},
				dataType: "json",
				success: function (response){
					if(response.status === "success"){
						let data= response.data;
						console.log(data);
						$("#vehicleNumber").val(data.vehicle_number);
						$("#vehicleType").val(data.vehicle_type);
						$("#seatCapacity").val(data.seating_capacity);
						$("#fuelType").val(data.fuel_type);
						$("#modelName").val(data.model_name);
						$("#modelYear").val(data.model_year);
						 $("#vendor").val(data.vendor); 		
						$("#insuranceCompany").val(data.insurance_company);
						$("#policyNumber").val(data.policy_number);
						$("#insuranceExpiry").val(data.insurance_expiry);
						$("#polutionExpiry").val(data.polution_expiry);
						$("#gps").val(data.gps);
						$("#speed").val(data.speed);
						} else{
						console.log("Not able to get data.")
					}
					
				}
				
			})
			
		});
		  $("#submitForm").on("submit", function (e) {
			  e.preventDefault(); 
			  $(".error").text("");
	            $(".form-control").removeClass("error-border");

		            let isValid = true;
		        let vehicleNumber = $("#vehicleNumber").val().trim();
		        let vehicleType = $("#vehicleType").val();
		        let seatCapacity = $("#seatCapacity").val();
		        let fuelType = $("#fuelType").val();
		        let vendor = $("#vendor").val();
		        let modelName = $("#modelName").val().trim();
		        let modelYear = $("#modelYear").val();
		        let insuranceCompany = $('#insuranceCompany').val().trim();
		        let insuranceExpiryDate = $("#insuranceExpiry").val().trim();
		        let policyNumber = $('#policyNumber').val().trim();
		        let polutionDate = $("#polutionExpiry").val();

		        let vehicleRegex = /^[A-Z]{2}[0-9]{1,2}[A-Z]{1,2}[0-9]{4}$/;

		        if (vehicleNumber === "") {
		            $("#vehicleNumberError").text("Vehicle Number is required");
		            isValid = false;
		        } 
		        else if (!vehicleRegex.test(vehicleNumber)) {
		            $("#vehicleNumberError").text("Example: KA01AB1234");
		            isValid = false;
		        }

		        if (!vehicleType || vehicleType=== "Select") {
		            $("#vehicleTypeError").text("Select Vehicle Type");
		            isValid = false;
		        }

		        if (seatCapacity === "" || seatCapacity <= 0) {
		            $("#seatCapacityError").text("Enter valid seating capacity");
		            isValid = false;
		        }

		        if (!fuelType) {
		            $("#fuelTypeError").text("Select fuel type");
		            isValid = false;
		        } 

		        if (!vendor) {
		            $("#vendorError").text("Select vendor");
		            isValid = false;
		        }

		        if (modelName === "") {
		            $("#modelNameError").text("Model name required");
		            isValid = false;
		        }

		        if (modelYear === "") {
		            $("#modelYearError").text("Please select Model Year");
		            isValid = false;
		        } else {

		            let modelDate = new Date(modelYear);
		            let today = new Date();

		            if (modelDate > today) {
		                $("#modelYearError").text("Model year cannot be future date");
		                isValid = false;
		            }
		        }

		        if (insuranceExpiryDate === "") {
		            $("#insuranceExpiryError").text("Please select Model Year");
		            isValid = false;
		        } else {

		            let modelDate = new Date(modelYear);
		            let today = new Date();

		            if (modelDate > today) {
		                $("#insuranceExpiryError").text("Insurance expired");
		                isValid = false;
		            }
		        }
		        if (polutionDate === "") {
		            $("#polutionExpiryError").text("Please select polution expiry date");
		            isValid = false;
		        } else {

		            let modelDate = new Date(modelYear);
		            let today = new Date();

		            if (modelDate > today) {
		                $("#polutionExpiryError").text("polution expired");
		                isValid = false;
		            }
		        }
		        
		        if (insuranceCompany === "") {
		            $("#insuranceCompanyError").text("Insurance Company name required");
		            isValid = false;
		        }
		        if (policyNumber === "") {
		            $("#policyNumberError").text("Policy number required");
		            isValid = false;
		        }

		        let today = new Date();
		        today.setHours(0,0,0,0);

		        if (insuranceDate !== "") {
		            let insDate = new Date(insuranceDate);

		            if (insDate <= today) {
		                $("#insuranceDateError").text("Insurance must be future date");
		                isValid = false;
		            }
		        }

		        if (polutionDate !== "") {
		            let polDate = new Date(polutionDate);

		            if (polDate <= today) {
		                $("#polutionDateError").text("Pollution date must be future");
		                isValid = false;
		            }
		        }

		        if (!isValid) return;
		        $.ajax({
		            url: "vehicleMasterUpdate.jsp",
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
		                    text: 'Vehicle Updated Successfully',
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
	