/**
 * 
 */
$(document).ready(function () {
	/* Search Box Logic */
	 $("#searchBox").on("keyup", function () {

	        let value = $(this).val().toLowerCase();

	        $("table tbody tr").filter(function () {

	            $(this).toggle(
	                $(this).text().toLowerCase().indexOf(value) > -1
	            );

	        });

	    });


    $("#submitForm").on("submit", function (e) {
        e.preventDefault();
        $.ajax({
            url: "assignRoute.jsp",
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
                    text: 'Route Assigned Successfully',
                    confirmButtonText: 'OK',
                    allowOutsideClick: false
                }).then(() => {
                    $("#submitForm")[0].reset();
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
                    text: 'Please Fill the Empty Fields',
                    confirmButtonText: 'OK',
                    allowOutsideClick: false
                });
            }
        });
    });

    $(".delete-btn").on('click', function(e){
			e.preventDefault();
			let routeNumber = $(this).attr("data-routeNumber");
			let vehicleNumber = $(this).attr("data-vehicleNumber");
			const row = $(this).closest("tr");
			$.ajax({
					url: "deleteAssignedVehicle.jsp",
					type: "POST",
					data: {routeNumber : routeNumber, vehicleNumber : vehicleNumber},
					dataType: "json",
					beforeSend: function () {
		                $("#divLoading").addClass('show');
		            },
		            success: function (response){
							if(response.status === "success"){
								 $("#divLoading").removeClass('show');
								row.remove();
								Swal.fire({
				                    icon: 'success',
				                    title: 'Success',
				                    text: 'Driver Removed From Vehicle',
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
			            }

				})
        })

});
