/**
 * 
 */
$(document).ready(function () {
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
            url: "markAttendance.jsp",
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
                    text: 'Vehicle Added Successfully',
                    confirmButtonText: 'OK',
                    allowOutsideClick: false
                }).then(() => {
                    $("#submitForm")[0].reset();
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

});