/**
 * 
 */
	$(document).ready(function (){
		/* Search Box Logic */
		$("#searchBox").on("keyup", function () {

    let value = $(this).val().toLowerCase().trim();

    $("table tbody tr").each(function () {

        let rowText = $(this).text().toLowerCase().trim();

        $(this).toggle(rowText.indexOf(value) > -1);

    });

});
		$("#selectclass").on("change", function () {

		    let selectedClass = $(this).val().toLowerCase();

		    $("table tbody tr").filter(function () {

		        let rowText = $(this).text().toLowerCase();

		        if (selectedClass === "" || selectedClass === "none") {
		            $(this).show();
		        } else {
		            $(this).toggle(rowText.indexOf(selectedClass) > -1);
		        }

		    });

		});
	

    $("#submitForm").on("submit", function (e) {
        e.preventDefault();
        $.ajax({
            url: "addMaintenance.jsp",
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
                    text: 'Added Vehicle For Maintenance',
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
			$.ajax({
					url: "deleteMaintenanceRecord.jsp",
					type: "POST",
					data: {vehicleNumber : vehicleNumber},
					dataType: "json",
					beforeSend: function () {
		                $("#divLoading").addClass('show');
		            },
		            success: function (response){
							if(response.status === "success"){
								Swal.fire({
				                    icon: 'success',
				                    title: 'Success',
				                    text: 'Vehicle Repaired!',
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