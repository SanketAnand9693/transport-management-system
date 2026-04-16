/**
 * 
 */
$(document).ready(function () {

    $("#submitForm").on("submit", function (e) {
        e.preventDefault();
        $.ajax({
            url: "assignDetails.jsp",
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
                    text: 'Driver Assigned Successfully',
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
			let vehicleNumber = $(this).attr("data-vehicleNumber");
			let driverId = $(this).attr("data-driverId");
			$.ajax({
					url: "deleteAssignDriver.jsp",
					type: "GET",
					data: {vehicleNumber : vehicleNumber, driverId : driverId},
					dataType: "json",
					beforeSend: function () {
		                $("#divLoading").addClass('show');
		            },
		            success: function (response){
							if(response.status === "success"){
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