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
	    	url += "?vehicleNumber=" + encodeURIComponent(stdClass);

	        if (search) {
	            url += "&search=" + encodeURIComponent(search);
	        }
	    }
	    else if (search) {
	        url += "?search=" + encodeURIComponent(search);
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
	
